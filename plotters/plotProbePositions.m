function plotProbePositions(d)

clf

for i=1:8
    plot(d.MagProbes(i).By.z,d.MagProbes(i).By.x,'k.')
    hold on
    plot(d.MagProbes(i).Bx.z,d.MagProbes(i).Bx.x,'k.')
    plot(d.MagProbes(i).Bz.z,d.MagProbes(i).Bz.x,'k.')
end

for i=1:4
    plot(d.LangData(i).Z,d.LangData(i).R,'o')
end

hline(0.375)

labels('','Z','R')