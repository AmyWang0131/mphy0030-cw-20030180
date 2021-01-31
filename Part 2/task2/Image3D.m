function [model] = Image3D(varargin)

if nargin == 0
    demo_vol3d;
    return
end

if isstruct(varargin{1})
    model = varargin{1};
    if length(varargin) > 1
       varargin = {varargin{2:end}};
    end
else
    model = localGetDefaultModel;
end

if length(varargin)>1
  for n = 1:2:length(varargin)
    switch(lower(varargin{n}))
        case 'cdata'
            model.cdata = varargin{n+1};
        case 'parent'
            model.parent = varargin{n+1};
        case 'texture'
            model.texture = varargin{n+1};
        case 'alpha'
            model.alpha = varargin{n+1};
        case 'xdata'
            model.xdata = varargin{n+1}([1 end]);
        case 'ydata'
            model.ydata = varargin{n+1}([1 end]);
        case 'zdata'
            model.zdata = varargin{n+1}([1 end]);
    end
    
  end
end

if isempty(model.parent)
    model.parent = gca;
end

[model] = local_draw(model);

%------------------------------------------%
function [model] = localGetDefaultModel

model.cdata = [];
model.alpha = [];
model.xdata = [];
model.ydata = [];
model.zdata = [];
model.parent = [];
model.handles = [];
model.texture = '3D';
tag = tempname;
model.tag = ['vol3d_' tag(end-11:end)];

%------------------------------------------%
function [model,ax] = local_draw(model)

cdata = model.cdata; 
siz = size(cdata);

% Define [x,y,z]data
if isempty(model.xdata)
    model.xdata = [0 siz(2)];
end
if isempty(model.ydata)
    model.ydata = [0 siz(1)];
end
if isempty(model.zdata)
    model.zdata = [0 siz(3)];
end

try
   delete(model.handles);
catch
end

ax = model.parent;
cam_dir = camtarget(ax) - campos(ax);
[m,ind] = max(abs(cam_dir));

opts = {'Parent',ax,'cdatamapping',[],'alphadatamapping',[],'facecolor','texturemap','edgealpha',0,'facealpha','texturemap','tag',model.tag};

if ndims(cdata) > 3
    opts{4} = 'direct';
else
    cdata = double(cdata);
    opts{4} = 'scaled';
end

if isempty(model.alpha)
    alpha = cdata;
    if ndims(model.cdata) > 3
        alpha = sqrt(sum(double(alpha).^2, 4));
        alpha = alpha - min(alpha(:));
        alpha = 1 - alpha / max(alpha(:));
    end
    opts{6} = 'scaled';
else
    alpha = model.alpha;
    if ~isequal(siz(1:3), size(alpha))
        error('Incorrect size of alphamatte');
    end
    opts{6} = 'none';
end

h = findobj(ax,'type','surface','tag',model.tag);
for n = 1:length(h)
  try
     delete(h(n));
  catch
  end
end

is3DTexture = strcmpi(model.texture,'3D');
handle_ind = 1;

% Create z-slice
if(ind==3 || is3DTexture )    
  x = [model.xdata(1), model.xdata(2); model.xdata(1), model.xdata(2)];
  y = [model.ydata(1), model.ydata(1); model.ydata(2), model.ydata(2)];
  z = [model.zdata(1), model.zdata(1); model.zdata(1), model.zdata(1)];
  diff = model.zdata(2)-model.zdata(1);
  delta = diff/size(cdata,3);
  for n = 1:size(cdata,3)

   cslice = squeeze(cdata(:,:,n,:));
   aslice = double(squeeze(alpha(:,:,n)));
   h(handle_ind) = surface(x,y,z,cslice,'alphadata',aslice,opts{:});
   z = z + delta;
   handle_ind = handle_ind + 1;
  end

end

% Create x-slice
if (ind==1 || is3DTexture ) 
  x = [model.xdata(1), model.xdata(1); model.xdata(1), model.xdata(1)];
  y = [model.ydata(1), model.ydata(1); model.ydata(2), model.ydata(2)];
  z = [model.zdata(1), model.zdata(2); model.zdata(1), model.zdata(2)];
  diff = model.xdata(2)-model.xdata(1);
  delta = diff/size(cdata,2);
  for n = 1:size(cdata,2)

   cslice = squeeze(cdata(:,n,:,:));
   aslice = double(squeeze(alpha(:,n,:)));
   h(handle_ind) = surface(x,y,z,cslice,'alphadata',aslice,opts{:});
   x = x + delta;
   handle_ind = handle_ind + 1;
  end
end

% Create y-slice
if (ind==2 || is3DTexture)
  x = [model.xdata(1), model.xdata(1); model.xdata(2), model.xdata(2)];
  y = [model.ydata(1), model.ydata(1); model.ydata(1), model.ydata(1)];
  z = [model.zdata(1), model.zdata(2); model.zdata(1), model.zdata(2)];
  diff = model.ydata(2)-model.ydata(1);
  delta = diff/size(cdata,1);
  for n = 1:size(cdata,1)

   cslice = squeeze(cdata(n,:,:,:));
   aslice = double(squeeze(alpha(n,:,:)));
   h(handle_ind) = surface(x,y,z,cslice,'alphadata',aslice,opts{:});
   y = y + delta;
   handle_ind = handle_ind + 1;
  end
end

model.handles = h;

function demo_vol3d
figure;
load mri.mat
vol3d('cdata', squeeze(D), 'xdata', [0 1], 'ydata', [0 1], 'zdata', [0 0.7]);
colormap(bone(256));
alphamap([0 linspace(0.1, 0, 255)]);
axis equal off
set(gcf, 'color', 'w');
view(3);