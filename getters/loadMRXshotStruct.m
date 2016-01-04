function out=loadMRXshotStruct(shotNum,conf)
% loads an MRX shot file as matfile struct

filePath = fullfile(conf.dataPath,['Processed_Data_' int2str(shotNum) '.mat']);

if exist(filePath,'file')
    out      = load(filePath);
else
    out      = NaN;
    warning(['file ' filePath ' does not exist!'])
end