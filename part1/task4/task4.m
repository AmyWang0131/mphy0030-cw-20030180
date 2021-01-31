% Read an example triangulation mesh in the csv files, ��data/example_vertices.csv�� and
% ��data/example_triangles.csv��. [2] (N.B. Examples of using such triangulation mesh can be
% found in the <iterative_closes_point> tutorial in the module repository.)
% o Smooth the surface mesh with three different numbers of iterations, 5, 10, 25. [3]
% o Plot the surface meshes before and after each of filtering operations, in a clear and visually
% comparable manner. [5]

filename = 'H:\service\2021\1 29 241269735\coursework202021\coursework202021\data\example_vertices.csv';
delimiter = ',';

%% ÿ���ı��еĸ�ʽ:
%   ��1: ˫����ֵ (%f)
%	��2: ˫����ֵ (%f)
%   ��3: ˫����ֵ (%f)
% �й���ϸ��Ϣ������� TEXTSCAN �ĵ���
formatSpec = '%f%f%f%[^\n\r]';

%% ���ı��ļ���
fileID = fopen(filename,'r');

%% ���ݸ�ʽ��ȡ�����С�
% �õ��û������ɴ˴������õ��ļ��Ľṹ����������ļ����ִ����볢��ͨ�����빤���������ɴ��롣
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% �ر��ı��ļ���
fclose(fileID);

%% ���޷���������ݽ��еĺ���
% �ڵ��������δӦ���޷���������ݵĹ�����˲�����������롣Ҫ�����������޷���������ݵĴ��룬�����ļ���ѡ���޷������Ԫ����Ȼ���������ɽű���

%% �����������
examplevertices = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3'});

%% �����ʱ����
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'H:\service\2021\1 29 241269735\coursework202021\coursework202021\data\example_triangles.csv';
delimiter = ',';

%% ÿ���ı��еĸ�ʽ:
%   ��1: ˫����ֵ (%f)
%	��2: ˫����ֵ (%f)
%   ��3: ˫����ֵ (%f)
% �й���ϸ��Ϣ������� TEXTSCAN �ĵ���
formatSpec = '%f%f%f%[^\n\r]';

%% ���ı��ļ���
fileID = fopen(filename,'r');

%% ���ݸ�ʽ��ȡ�����С�
% �õ��û������ɴ˴������õ��ļ��Ľṹ����������ļ����ִ����볢��ͨ�����빤���������ɴ��롣
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% �ر��ı��ļ���
fclose(fileID);

%% ���޷���������ݽ��еĺ���
% �ڵ��������δӦ���޷���������ݵĹ�����˲�����������롣Ҫ�����������޷���������ݵĴ��룬�����ļ���ѡ���޷������Ԫ����Ȼ���������ɽű���

%% �����������
exampletriangles = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3'});

%% �����ʱ����
clearvars filename delimiter formatSpec fileID dataArray ans;

 [x,y,z]=peaks(14);      % sample data
 v=-3:1.2:6;             % contour levels to draw
 contour(x,y,z,v);       % standard contour
hold on
lowpass_mesh_smoothing(x,y,z,v); % smoothed contours
title('Original and Smoothed Contour')
              hold off


