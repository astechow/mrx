function out = saveData(handles)
% saves gathered data for export to database

data    = getappdata(handles.figure1,'shotData');
fields  = fieldnames(data);
conf    = getappdata(handles.figure1,'conf');
m       = matfile(conf.dbPath,'Writable',true);
w       = whos(m);

if ~ismember('shot',{w.name}) % empty file, start writing
    index = 1;
else
    index = find(m.shot==data.shot); % not empty, check if shot saved
    if isempty(index) % not saved, add to end of array
        index = length(m.shot)+1;
    end
end

% write data to index found above
for i=1:length(fields)
    m.(fields{i})(index,1) = data.(fields{i});
end

end