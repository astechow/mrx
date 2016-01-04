function updateDropdownMenu(handles)


%% part 1: left side dropdowns

strings = {'density','electron temperature','total current','x-point z pos.'};

% set dropdown handle names
set(handles.traceSelector1,'string',strings);
set(handles.traceSelector2,'string',strings);

%% part 2: right side dropdown

strings = {'Ey','Jx','Jz','Flux'};

set(handles.imageSelector,'string',strings);