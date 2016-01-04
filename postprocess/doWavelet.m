function doWavelet(shots)
% does wavelet analysis on fluctuation data and stores result in directory

conf = initMRX;

% m    = matfile(conf.waveletPath,'writable',true);
% 
% w       = whos(m);
% names   = {w.name};
% 

files      = dir(conf.waveletPath);
% fieldNames = {'Br','By','Bz','Ey','pref','pr','py','pz'};

for i=1:length(shots)
    shotStr = int2str(shots(i));
    % check if already processed
    if strmatch(['wavelet_' shotStr '.mat'],{files.name}) 
        disp(['shot ' shotStr ' exists, skipping'])
    else
        disp(['processing shot ' shotStr])
        % load fluctuations
        f = getMRXflucs(shots(i));
        % do wavelet transform
        w = waveletMRX(f);
        % save data
        save(fullfile(conf.waveletPath,['wavelet_' shotStr '.mat']),'-v7.3','-struct','w')
    end
    
end