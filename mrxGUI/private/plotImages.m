function handles = plotImages(handles)
% function handles = plotImages(hObject,handles)
%
% updates 2D plots

% check if plot selector dropdown menu has been used yet
if isnan(getappdata(handles.figure1,'imageSelectorSelectedItem'))
    userPlot = 'Ey'; % default is inductive electric field
else
    userPlot = getappdata(handles.figure1,'imageSelectorSelectedItem');
end

% data to plot
titleList = {'Jy','By','Bz',userPlot};

% determine time point to plot
time       = getappdata(handles.figure1,'time');
tInd       = getappdata(handles.figure1,'tIndSelect');
tSelect    = getappdata(handles.figure1,'tSelect');

% check if any of the time selectors have been used yet
if isnan(tSelect) && isnan(tInd)
    % none chosen
    % this case probably never occurs?
    tSelect = 330;
    tInd    = ind_get(time,tSelect);
elseif isnan(tInd)
    % time point chosen
    tInd    = ind_get(time,tSelect);
    tSelect = time(tInd);
else
    % time index chosen
    tSelect = time(tInd);
end

% check if shotData has been gathered yet (for misc markers)
shotData = getappdata(handles.figure1,'shotData');
shot = getappdata(handles.figure1,'shot');

if isstruct(shotData) && (shotData.shot == shot)
    marker.x = shotData.rx;
    marker.z = shotData.zx;
else
    marker.x = nan;
    marker.z = nan;
end

for i=1:4
    
    % select axis
    name  = ['imagePlot' num2str(i)];
    h = handles.(name);
    
    if ~isempty(titleList{i})
        
        % get data
        data = caseHandler(handles,titleList{i},tInd);
        
        % plot requested data
        contourupdate(h,data.values,handles)
        title(h,[titleList{i} ' - ' data.label])
        if ~isnan(data.ylims)
            caxis(h,data.ylims)
        end
        
        if isfield(data,'rx')
            delete(findobj(h,'Marker','x'))
            plot(h,data.zx*1e3,data.rx*1e3,'xk')
        end
        
    else
        
        title(h,[titleList{i} ' - NO DATA'])
        
    end
    
end

% update position of vertical bar in time traces

for i=1:5
    % delete old bars
    try
        delete(handles.tSelectHandle{i})
    catch
        try
            delete(handles.tSelectHandle{i}{1})
        end
    end
    % add new bars
    handles.tSelectHandle{i} = vline(handles.(['trace' num2str(i)]),time(tInd),'k');
end
guidata(handles.figure1,handles)

% output time index
setappdata(handles.figure1,'tIndSelect',tInd);
setappdata(handles.figure1,'tSelect',tSelect);

% set GUI text fields to reflect shown time point
set(handles.timeIndexSelectorTextBox,'String',num2str(getappdata(handles.figure1,'tIndSelect')))
set(handles.timeSelectorTextBox,'String',num2str(getappdata(handles.figure1,'tSelect')))

end

function contourupdate(h,data,handles)
% update content of contour/image plot h
tmp = get(h,'Children');
m = max(abs(data(:)));

if get(handles.lqGfxButton,'Value')
    set(findobj(tmp,'Type','Image'),'CData',data)
else
    if verLessThan('matlab', '8.2')
        set(findobj(tmp,'Type','hggroup'),'ZData',data)
        set(findobj(tmp,'Type','hggroup'),'LevelList',linspace(-m,m,61))
    else
        set(findobj(tmp,'Type','Contour'),'ZData',data)
        set(findobj(tmp,'Type','Contour'),'LevelList',linspace(-m,m,61))
    end
end

caxis(h,[-m m])

end