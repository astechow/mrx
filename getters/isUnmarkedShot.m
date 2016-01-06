function index = isUnmarkedShot(shot)
% index = isUnmarkedShot(shot)
%
% returns the index in shotdb of a shot number if "marked" field is false,
% 0 if true or if shot is unavailable
%
% Jan. 2016, Adrian von Stechow

c = initMRX;
m = matfile(c.dbPath);

index  = find(m.shot==shot);

if isempty(index) || m.marked(index,1)
    index = 0;
end