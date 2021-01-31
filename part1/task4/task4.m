% Read an example triangulation mesh in the csv files, “data/example_vertices.csv” and
% “data/example_triangles.csv”. [2] (N.B. Examples of using such triangulation mesh can be
% found in the <iterative_closes_point> tutorial in the module repository.)
% o Smooth the surface mesh with three different numbers of iterations, 5, 10, 25. [3]
% o Plot the surface meshes before and after each of filtering operations, in a clear and visually
% comparable manner. [5]

filename = 'H:\service\2021\1 29 241269735\coursework202021\coursework202021\data\example_vertices.csv';
delimiter = ',';

%% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%f%f%f%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% 关闭文本文件。
fclose(fileID);

%% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的元胞，然后重新生成脚本。

%% 创建输出变量
examplevertices = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3'});

%% 清除临时变量
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'H:\service\2021\1 29 241269735\coursework202021\coursework202021\data\example_triangles.csv';
delimiter = ',';

%% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%f%f%f%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% 关闭文本文件。
fclose(fileID);

%% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的元胞，然后重新生成脚本。

%% 创建输出变量
exampletriangles = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3'});

%% 清除临时变量
clearvars filename delimiter formatSpec fileID dataArray ans;

 [x,y,z]=peaks(14);      % sample data
 v=-3:1.2:6;             % contour levels to draw
 contour(x,y,z,v);       % standard contour
hold on
lowpass_mesh_smoothing(x,y,z,v); % smoothed contours
title('Original and Smoothed Contour')
              hold off


