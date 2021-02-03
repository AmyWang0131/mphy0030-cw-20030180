% Read an example triangulation mesh in the csv files, ¡°data/example_vertices.csv¡± and
% ¡°data/example_triangles.csv¡±. [2] (N.B. Examples of using such triangulation mesh can be
% found in the <iterative_closes_point> tutorial in the module repository.)
% o Smooth the surface mesh with three different numbers of iterations, 5, 10, 25. [3]
% o Plot the surface meshes before and after each of filtering operations, in a clear and visually
% comparable manner. [5]

filename = 'H:\service\2021\1 29 241269735\coursework202021\coursework202021\data\example_vertices.csv';
delimiter = ',';

%% the row format

formatSpec = '%f%f%f%[^\n\r]';

%% open the file
fileID = fopen(filename,'r');

%% read the datas
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% close the file
fclose(fileID);


%% create output varibles
examplevertices = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3'});

%% clear the temparory varibles
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'H:\service\2021\1 29 241269735\coursework202021\coursework202021\data\example_triangles.csv';
delimiter = ',';

%% the row format
formatSpec = '%f%f%f%[^\n\r]';

%% open the file
fileID = fopen(filename,'r');

%% read the colume data
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% close the file
fclose(fileID);


%% creat output varibles
exampletriangles = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3'});

%% clear temprory varibles
clearvars filename delimiter formatSpec fileID dataArray ans;

 [x,y,z]=peaks(14);      % sample data
 v=-3:1.2:6;             % contour levels to draw
 contour(x,y,z,v);       % standard contour
hold on
lowpass_mesh_smoothing(x,y,z,v); % smoothed contours
title('Original and Smoothed Contour')
              hold off


