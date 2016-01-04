function out=getMRXlangdata(shot)
%function out=getMRXlangdata(shot)


conf = initMRX;
m = loadMRXshot(shot,conf);
out = m.LangData;