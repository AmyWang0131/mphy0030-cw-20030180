%%load an example image in mat file

load('example_image.mat')

%%Write the image into a file ¡°data/image.sim
xd = double(vol); % x is a double
gim =reshape(xd,224,2240,3);


imwrite(gim,'image.sim.jpg');

%Read the file ¡°data/image.sim¡± using simple_image_read function. [2]

gim=imread('image.sim.jpg');
%Plot 3 images at different z-coordinates to verify the read images
imshow(gim,[]),title('titl');


% load in image data, volume data, vol, and voxel dimensions, voxdims
load('data/example_image.mat'); 

filename = 'data/image.sim'; % set filename for binary file to be saved in data folder

simple_image_write(vol,voxdims,filename); % write vol & voxdims to a binary file

[image, dims] = simple_image_read(filename,vol,voxdims); % read binary file back into variables

xaxis = dims(1)* 0:223; % create axis array for plots by multiplying voxel dimensions
yaxis = dims(2)* 0:223; % by array of x & y dimensions

image = permute(image,[2 1 3]); % swap x & y dimensions to obtain correction orientation


z = randi(30,[1,3]); % select 3 random z values from the 30 z slices for plotting

figure;
imagesc(xaxis,yaxis,image(:,:,z(1)));
colormap gray;
xlabel('x-dimension');
ylabel('y-dimension');
title(sprintf('Plot at z=%d', z(1)));
colorbar;

figure;
imagesc(xaxis,yaxis,image(:,:,z(2)));
colormap gray;
xlabel('x-dimension');
ylabel('y-dimension');
title(sprintf('Plot at z=%d', z(2)));
colorbar;

figure;
imagesc(xaxis,yaxis,image(:,:,z(3)));
colormap gray;
xlabel('x-dimension');
ylabel('y-dimension');
title(sprintf('Plot at z=%d', z(3)));
colorbar;
