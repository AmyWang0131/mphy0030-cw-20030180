% Gradient descent from scratch


clc
clear
format long

% Function Definition (Enter your Function here):
syms X Y;
f = X - Y + 2*X^2 + 2*X*Y + Y^2;

% Initial Guess:
x(1) = 1;
y(1) = -5;
e = 10^(-8); % Convergence Criteria
i = 1; % Iteration Counter

% Gradient Computation:
df_dx = diff(f, X);
df_dy = diff(f, Y);
J = [subs(df_dx,[X,Y], [x(1),y(1)]) subs(df_dy, [X,Y], [x(1),y(1)])]; % Gradient
S = -(J); % Search Direction

% Minimization Condition:
while norm(J) > e 
    I = [x(i),y(i)]';
    syms h; % Step size
    g = subs(f, [X,Y], [x(i)+S(1)*h,y(i)+h*S(2)]);
    dg_dh = diff(g,h);
    h = solve(dg_dh, h); % Optimal Step Length
    x(i+1) = I(1)+h*S(1); % Updated x value
    y(i+1) = I(2)+h*S(2); % Updated y value
    i = i+1;
    J = [subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])]; % Updated Gradient
    S = -(J); % New Search Direction
end

% Result Table:
Iter = 1:i;
X_coordinate = x';
Y_coordinate = y';
Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate);

% Plots:
fcontour(f, 'Fill', 'On');
hold on;
plot(x,y,'*-r');

% Output:
fprintf('Initial Objective Function Value: %d\n\n',subs(f,[X,Y], [x(1),y(1)]));
if (norm(J) < e)
    fprintf('Minimum succesfully obtained...\n\n');
end
fprintf('Number of Iterations for Convergence: %d\n\n', i);
fprintf('Point of Minima: [%d,%d]\n\n', x(i), y(i));
fprintf('Objective Function Minimum Value Post-Optimization: %d\n\n', subs(f,[X,Y], [x(i),y(i)]));
disp(T);


clearvars;
a = randi(5,1,10); % generate a random 1x10 array of values a0-a9, with the values being between 1-5.

x = [1 1 1]; % generate an intial x vector of x1, x2, x3


step_sz = 0.00001; % set step size, small size to avoid overshooting minimum
max_iter = 100000; % maximum number of iterations to run script
tol = 0.00001; % tolerance on the difference between two successive final function outputs

optimal_x = gradient_descent(x,a,step_sz,max_iter,tol); % call gradient_descent function to minimise the output of a multivariate polynomial iwth x & a
% the output is the x vector corresponding to the min function output

min_output = quadratic_polynomial(a,optimal_x); % uses the optimal x to obtain the minimised function output value

% verify output with first and second order derivative
grad = finite_difference_gradient(optimal_x,a); % a first derivative being close to zero symbolises a stationary point 
grad_2 = second_differivative(optimal_x,a); % a second order derivative being positive shows the stationary point is a minimum