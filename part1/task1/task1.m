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



