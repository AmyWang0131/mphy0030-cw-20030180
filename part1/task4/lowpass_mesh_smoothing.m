function [cout,h]=lowpass_mesh_smoothing(varargin)


if nargin==4             % CONTOURSPLINE(X,Y,Z,N) or CONTOURSPLINE(X,Y,Z,V)
   
   [c,hd]=contour(varargin{:});
   
elseif nargin==5 % CONTOURSPLINE(TRI,X,Y,Z,N) or CONTOURSPLINE(TRI,X,Y,Z,V)
   
   if ~(exist('tricontour','file')==2)
      error('CONTOURSPLINE:rhs','Function TRICONTOUR is Not Available.')
   end
   [c,hd]=tricontour(varargin{:});
   
else
   error('CONTOURSPLINE:rhs','Four or FIve Input Argument Required.')
end
% have default contour plotted
xylim=get(gca,{'XLim' 'YLim'});
delete(hd) % eliminate original contours so they can be replaced

% move through c matrix, extracting data, finding spline, replotting
C=zeros(2,0);
h=[];
tol=1e-12;
col=1;   % index of column containing contour level and number of points
while col<size(c,2); % while less than total columns in c
   
   % extract contour data points
   zlevel=c(1,col);
   idx=col+1:col+c(2,col);
   xdata = c(1,idx);
   ydata = c(2,idx);
   isopen = abs(diff(c(1,idx([1 end]))))>tol || ...
            abs(diff(c(2,idx([1 end]))))>tol;
   col=col+c(2,col)+1;

   % smooth contour data by 2-D spline interpolation
   if ~isopen  % wrap data so closed curve is smooth at joint
      xdata=[xdata(end-1) xdata xdata(2)]; %#ok
      ydata=[ydata(end-1) ydata ydata(2)]; %#ok
   end

   % get path length to create independent variable
   t=[0 cumsum(hypot(diff(xdata),diff(ydata)))]; % independent variable

   % place interpolation points in between those in t    
   n=max(2,ceil(20/sqrt(length(t))));
   ti=repmat(t(1:end-1),n,1);
   d=repmat((0:n-1)'/n,1,length(xdata)-1);
   dt=repmat(diff(t),n,1);
   ti=ti+d.*dt;
   ti=[ti(:); t(end)]; % independent variable interpolation points

   % computer new contour points from spline fit
   xi=spline(t,xdata,ti);
   yi=spline(t,ydata,ti);
   if ~isopen   % take out redundant data if curve was closed
      xi=xi(n+1:end-n);
      yi=yi(n+1:end-n);
   else
      xi(end+1)=nan; %#ok don't close open contours
      yi(end+1)=nan; %#ok
   end
   k=length(xi);

   % create a patch containing the new contour
   if nargout<2                     % plot the contour
      patch('XData',xi,'YData',yi,'CData',repmat(zlevel,k,1),...
            'FaceColor','none','EdgeColor','flat','UserData',zlevel)
      C=horzcat(C,[zlevel xi';k yi']); % contour label data
   else                             % plot contour and create output

      h=[h;patch('XData',xi,'YData',yi,'CData',repmat(zlevel,k,1),...
         'FaceColor','none','EdgeColor','flat','UserData',zlevel)]; %#ok
      C=horzcat(C,[zlevel xi';k yi']); % contour label data
   end
end
set(gca,'XLim',xylim{1},'YLim',xylim{2},'box','on')
if nargout>0
   cout=C;
end


