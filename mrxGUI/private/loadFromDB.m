function out = loadFromDB(handles)
% saves gathered data for export to database

shot    = getappdata(handles.figure1,'shot');
conf    = getappdata(handles.figure1,'conf');
m       = matfile(conf.dbPath,'Writable',true);
w       = whos(m);
names   = {w.name};

if ~ismember('shot',names) % empty file, return NaN
    out = NaN;
else
    index = find(m.shot==shot,1); % not empty, check if shot saved
    if isempty(index) % not saved, return NaN
        out = NaN;
    else
        for i = 1:length(names)
            try
                out.(names{i}) = m.(names{i})(index,1);
            catch % catches case where m.(names{i}) is not fully populated yet
                out.(names{i}) = NaN;
            end
        end
    end
end
