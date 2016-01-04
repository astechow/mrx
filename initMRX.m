function out=initMRX

if ~(exist('mrxGUI','file')==2)
    thisPath = fileparts(mfilename('fullpath'));
    
    addpath(fullfile(thisPath,'getters'))
    addpath(fullfile(thisPath,'plotters'))
    addpath(fullfile(thisPath,'evaluation'))
    addpath(fullfile(thisPath,'postprocess'))
    addpath(fullfile(thisPath,'mrxGUI'))
end


out=loadconf('config.txt');