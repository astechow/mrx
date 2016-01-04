%sorts the shot database according to shot number

conf = initMRX;
m = matfile(conf.dbPath,'writable',true);
[a,s] = sort(m.shot);
w = whos(m);
names = {w.name};
n = length(m.shot);

for i=1:length(names)
    tmp = m.(names{i});
    if length(tmp)<n
        if islogical(tmp)
            tmp = padarray(tmp,[n-length(tmp) 0],false,'post');
        else
            tmp = padarray(tmp,[n-length(tmp) 0],nan,'post');
        end
    end
    m.(names{i})=tmp(s);
end