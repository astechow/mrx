function plotMRXTraces(handles)
% plots the 1D traces on the left side of mrxGUI

% prepare data

magData      = getappdata(handles.figure1,'magData');
time         = getappdata(handles.figure1,'time');
fastCurrents = getappdata(handles.figure1,'fastCurrents');

% get trace selector dropdown values

userTrace1 = getappdata(handles.figure1,'traceSelector1SelectedItem');
userTrace2 = getappdata(handles.figure1,'traceSelector2SelectedItem');

% trace names and plot titles

titleList  = {'coil currents','rec. rate','x-point r pos.',userTrace1,userTrace2};

for i=1:5
    
    % select axis
    name  = ['trace' num2str(i)];
    h = handles.(name);
    
    if ~isempty(titleList{i})
        
        % get data
        data = caseHandler(handles,titleList{i});
        
        % plot data
        plot(h,data.time,data.values);
        ylabel(h,data.label)
        title(h,titleList{i})
        
        if iscell(data.legend)
            legend(h,data.legend)
        end
        
        if ~isnan(data.ylims)
            ylim(h,data.ylims)
        end
        
        % perform "xtra" functions
        if iscell(data.xtra)
            for n = 1:length(data.xtra)
                eval(data.xtra{n})
            end
        end
        
        % set time bounds
        if ~isnan(getappdata(handles.figure1,'tDisplayStart')) && ~isnan(getappdata(handles.figure1,'tDisplayEnd'))
            xlim(h,[getappdata(handles.figure1,'tDisplayStart') getappdata(handles.figure1,'tDisplayEnd')])
        elseif ~isnan(getappdata(handles.figure1,'tDisplayStart'))
            xlim(h,[getappdata(handles.figure1,'tDisplayStart') time(end)])
        elseif ~isnan(getappdata(handles.figure1,'tDisplayEnd'))
            xlim(h,[time(1) getappdata(handles.figure1,'tDisplayEnd')])
        end

    else
        
        % if no field selected, plot 0
        hold(h,'off')
        plot(h,[0 0],[0 0]);
        title(h,'choose from dropdown')
        
    end
    
end

end
