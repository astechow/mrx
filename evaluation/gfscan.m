c  = initMRX;
db = load(c.dbPath);

shotList = 168857:169010;

n = 0;
    
for i = 1:length(shotList)
    disp([num2str(i) '/' num2str(length(shotList))])
    if isUnmarkedShot(shotList(i))
        n = n+1;
        dbShotInd(n) = find(db.shot==shotList(i));
        tmp          = loadMRXshot(shotList(i),c);
        current(n)   = tmp.GF_Current;
    end
end

%% fluctuation processing

out = getHighGfShotFlucData(shotList);

%%
figure(1)
clf
subplot(2,1,1)
plot(db.shot(dbShotInd)-168000,-db.By(dbShotInd,1),'.')
labels('guide field at X-pt','shot','B_y [mT]')

subplot(2,1,2)
plot(db.shot(dbShotInd)-168000,-db.By(dbShotInd,1)./db.Bzup(dbShotInd,1),'.')
labels('norm. guide field at X-pt','shot','B_y/B_z')
%%
figure(2)
clf

subplot(2,1,1)
plot(-current,-db.By(dbShotInd,1),'.')
hold on
plot(-current,db.Bzup(dbShotInd,1),'.')
labels('','GF current','B_y or B_z [mT]')

subplot(2,1,2)
plot(-current,-db.By(dbShotInd,1)./db.Bzup(dbShotInd,1),'.')
labels('','GF current','norm. guide field')
ylim([0 40])

figure(3)
clf
subplot(2,1,1)
plot(-current,-db.I(dbShotInd,1),'.')
labels('','GF current','total plasma current [kA]')

subplot(2,1,2)
plot(-current,-db.jMax(dbShotInd,1),'.')
hold on
plot(-current,-db.j(dbShotInd,1),'.')
labels('','GF current','plasma current density [MA/m^2]')

figure(4)
clf
plot(-current,out.Bz,'.')%