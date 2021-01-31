%%Plotting multivariate Gaussian probability density surfaces


%%Randomly generate 10,000 samples of ?from any distribution
mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];

x1 = -3:0.2:3;
x2 = -3:0.2:3;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
%%Fit a Gaussian to the generated random points, i.e. computing the mean and covariance
%%matrix from the available data
%%probability densities
y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));

%%Plot the three ellipsoid surfaces
surf(x1,x2,y)
caxis([min(y(:))-0.5*range(y(:)),max(y(:))])
axis([-3 3 -3 3 0 0.4])
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')



mu = [1 -1];
Sigma = [.9 .4; .4 .3];


[X1,X2] = meshgrid(linspace(-1,3,25)',linspace(-3,1,25)');
X = [X1(:) X2(:)];


p = mvncdf(X,mu,Sigma);


Z = reshape(p,25,25);
surf(X1,X2,Z)


mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];

p = mvncdf([0 0],[1 1],mu,Sigma)


x1 = -3:.2:3;
x2 = -3:.2:3;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));

contour(x1,x2,y,[0.0001 0.001 0.01 0.05 0.15 0.25 0.35])
xlabel('x')
ylabel('y')
line([0 0 1 1 0],[1 0 0 1 1],'Linestyle','--','Color','k')

