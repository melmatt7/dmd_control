%% This is a demo script that shows all functionality

SetPaths

debug = true; 
% debug = true : access the executable from DMDControler/bin/Debug
%
% Set debug = false if the build configuration of the executable is 'Release'
% debug = false : access the executable from DMDController/bin/Release
% 

%% 1) Initialize DMD

InitializeDMD(debug)

%% 2) Load Multiple Files
patFile1 = 'C:\DLP-Discovery-DMD-Control\DMDController\DMDController\data\right.bmp';
patFile2 = 'C:\DLP-Discovery-DMD-Control\DMDController\DMDController\data\left.bmp';
delineate = ',';

patFiles = [patFile1,delineate,patFile2];

numPatterns = size(patFiles);

LoadMultiple(1, patFiles);

%% 3) Float the DMD mirrors
% This must be done before turning off the power

%FloatDMD(debug)

