% Visualizing fluid flow
 v = flow(50);
 h = Image3D('cdata',v,'texture','2D');
 view(3); 
 % Update view since 'texture' = '2D'
 Image3D(h);  
alphamap('rampdown'), alphamap('decrease'), alphamap('decrease')

 % Visualizing MRI data
load mri.mat
D = squeeze(D);
h = Image3D('cdata',D,'texture','3D');
view(3);  
axis tight;  daspect([1 1 .4])
alphamap('rampup');
alphamap(.06 .* alphamap);