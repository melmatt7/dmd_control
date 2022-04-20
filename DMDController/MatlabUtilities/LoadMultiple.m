function LoadMultiple(displayOutput, patFiles)
%LOADMULTIPLEBMP Summary of this function goes here
%   Detailed explanation goes here
callerMode = 'mult';
exeFullFile = 'DMDController\bin\Debug\DMDController.exe';


cmdInput = [exeFullFile, ' ', callerMode, ' ', ...
                patFiles];
[status, cmdout] = system(cmdInput);

if displayOutput   
    disp(['Status: ', num2str(status)])
    disp(cmdout)
end
end

