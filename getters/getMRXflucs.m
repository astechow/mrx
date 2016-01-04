function f=getMRXflucs(shot)

conf = initMRX;
m = matfile(conf.flucPath);

ind = find(m.shot==shot,1);

f.Br = m.Br(1:10000,ind);
f.By = m.By(1:10000,ind);
f.Bz = m.Bz(1:10000,ind);
f.Ey = m.FP(1:10000,ind);

f.time1 = m.time1+200;
%todo fix this!
f.time2 = linspace(0,400,2e6);

f.pref = m.pref(1:2e6,ind);
f.pr = m.pr(1:2e6,ind);
f.py = m.py(1:2e6,ind);
f.pz = m.pz(1:2e6,ind);