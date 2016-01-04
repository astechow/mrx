function varargout = mrxGUI(varargin)
% MRXGUI MATLAB code for mrxGUI.fig
%      MRXGUI, by itself, creates a new MRXGUI or raises the existing
%      singleton*.
%
%      H = MRXGUI returns the handle to a new MRXGUI or the handle to
%      the existing singleton*.
%
%      MRXGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MRXGUI.M with the given input arguments.
%
%      MRXGUI('Property','Value',...) creates a new MRXGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mrxGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mrxGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mrxGUI

% Last Modified by GUIDE v2.5 18-Dec-2015 14:53:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mrxGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @mrxGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before mrxGUI is made visible.
function mrxGUI_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mrxGUI (see VARARGIN)

% set some defaults
setappdata(handles.figure1,'traceSelector1SelectedItem','')
setappdata(handles.figure1,'traceSelector2SelectedItem','')
setappdata(handles.figure1,'imageSelectorSelectedItem', NaN);
setappdata(handles.figure1,'fileName',NaN)
setappdata(handles.figure1,'tDisplayStart',NaN);
setappdata(handles.figure1,'tDisplayEnd',NaN);
setappdata(handles.figure1,'tSelect',NaN);
setappdata(handles.figure1,'tIndSelect',NaN);
setappdata(handles.figure1,'shotData',NaN);
setappdata(handles.figure1,'shot',NaN)

% Choose default command line output for mrxGUI
handles.output = hObject;

% set up defaults for some handles
handles.tSelectHandle = num2cell(nan(5,1));

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using mrxGUI.
if strcmp(get(hObject,'Visible'),'off')
    plot(handles.trace1,[0 0]);
    plot(handles.trace2,[0 0]);
    plot(handles.trace3,[0 0]);
    plot(handles.trace4,[0 0]);
    plot(handles.trace5,[0 0]);
end

% set user prefs possibly stored in conf file
if  exist('initMRX','file')
    conf = initMRX;
else
    % default MRX path
    conf.dataPath = '/p/mrxdata/matlab/GeneralRoutines/ProcessedDataFiles';
    conf.dbPath   = '';
    disp('initMRX() not found, using default path /p/mrxdata/matlab/GeneralRoutines/ProcessedDataFiles')
end
setappdata(handles.figure1,'conf',conf)

% --- Outputs from this function are returned to the command line.
function varargout = mrxGUI_OutputFcn(hObject, eventdata, handles) %#ok<INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

function shotNumberTextBox_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to shotNumberTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shotNumberTextBox as text
%        str2double(get(hObject,'String')) returns contents of shotNumberTextBox as a double

% does the initial file loading

% get shot number field
shotNum = get(hObject,'String');
setappdata(handles.figure1,'shot',str2double(shotNum))

loadMRXData(handles, shotNum)

% --- Executes during object creation, after setting all properties.
function shotNumberTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shotNumberTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in debugGuiButton.
function debugGuiButton_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to debugGuiButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% simple button to enter debug mode and output GUI state
handles %#ok<NOPRT>
appdata = getappdata(handles.figure1) %#ok<NOPRT,NASGU>
keyboard

% --- Executes on selection change in traceSelector1.
function traceSelector1_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
% hObject    handle to traceSelector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns traceSelector1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from traceSelector1

contents = cellstr(get(hObject,'String'));
setappdata(handles.figure1,'traceSelector1SelectedItem',contents{get(hObject,'Value')});
plotMRXTraces(handles)

% --- Executes during object creation, after setting all properties.
function traceSelector1_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to traceSelector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String','Load data to select item')

% --- Executes on selection change in traceSelector2.
function traceSelector2_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
% hObject    handle to traceSelector2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns traceSelector2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from traceSelector2

contents = cellstr(get(hObject,'String'));
setappdata(handles.figure1,'traceSelector2SelectedItem',contents{get(hObject,'Value')});
plotMRXTraces(handles)

% --- Executes during object creation, after setting all properties.
function traceSelector2_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to traceSelector2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String','Load data to select item')

function tStartTextBox_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
% hObject    handle to tStartTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tStartTextBox as text
%        str2double(get(hObject,'String')) returns contents of tStartTextBox as a double

setappdata(handles.figure1,'tDisplayStart',str2double(get(hObject,'String')));
plotMRXTraces(handles)

% --- Executes during object creation, after setting all properties.
function tStartTextBox_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to tStartTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tEndTextBox_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
% hObject    handle to tEndTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tEndTextBox as text
%        str2double(get(hObject,'String')) returns contents of tEndTextBox as a double

setappdata(handles.figure1,'tDisplayEnd',str2double(get(hObject,'String')));
plotMRXTraces(handles)


% --- Executes during object creation, after setting all properties.
function tEndTextBox_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to tEndTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in imageSelector.
function imageSelector_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
% hObject    handle to imageSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns imageSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from imageSelector

contents = cellstr(get(hObject,'String'));
setappdata(handles.figure1,'imageSelectorSelectedItem', contents{get(hObject,'Value')});
plotImages(handles);

% --- Executes during object creation, after setting all properties.
function imageSelector_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to imageSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String','Load data to select item')


function timeSelectorTextBox_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to timeSelectorTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeSelectorTextBox as text
%        str2double(get(hObject,'String')) returns contents of timeSelectorTextBox as a double
setappdata(handles.figure1,'tIndSelect', NaN);
setappdata(handles.figure1,'tSelect',    str2double(get(hObject,'String')));
plotImages(handles);

% --- Executes during object creation, after setting all properties.
function timeSelectorTextBox_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to timeSelectorTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function timeIndexSelectorTextBox_Callback(hObject, eventdata, handles) %#ok<DEFNU,INUSL>
% hObject    handle to timeIndexSelectorTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeIndexSelectorTextBox as text
%        str2double(get(hObject,'String')) returns contents of timeIndexSelectorTextBox as a double

setappdata(handles.figure1,'tIndSelect', str2double(get(hObject,'String')));
setappdata(handles.figure1,'tSelect',    NaN);

plotImages(handles);

% --- Executes during object creation, after setting all properties.
function timeIndexSelectorTextBox_CreateFcn(hObject, eventdata, handles) %#ok<DEFNU,INUSD>
% hObject    handle to timeIndexSelectorTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function trace1_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>


% --- Executes on button press in shotBackButton.
function shotBackButton_Callback(hObject, eventdata, handles)
% hObject    handle to shotBackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(handles.shotNumberTextBox,'String'));
set(handles.shotNumberTextBox,'String',num2str(val-1));
shotNumberTextBox_Callback(handles.shotNumberTextBox,eventdata,handles)

% --- Executes on button press in shotForwardButton.
function shotForwardButton_Callback(hObject, eventdata, handles)
% hObject    handle to shotForwardButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(handles.shotNumberTextBox,'String'));
set(handles.shotNumberTextBox,'String',num2str(val+1));
shotNumberTextBox_Callback(handles.shotNumberTextBox,eventdata,handles)

% --- Executes on button press in indexBackButton.
function indexBackButton_Callback(hObject, eventdata, handles)
% hObject    handle to indexBackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(handles.timeIndexSelectorTextBox,'String'));
set(handles.timeIndexSelectorTextBox,'String',num2str(val-1));
timeIndexSelectorTextBox_Callback(handles.timeIndexSelectorTextBox,eventdata,handles)

% --- Executes on button press in indexForwardButton.
function indexForwardButton_Callback(hObject, eventdata, handles)
% hObject    handle to indexForwardButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(handles.timeIndexSelectorTextBox,'String'));
set(handles.timeIndexSelectorTextBox,'String',num2str(val+1));
timeIndexSelectorTextBox_Callback(handles.timeIndexSelectorTextBox,eventdata,handles)


% --- Executes on button press in lqGfxButton.
function lqGfxButton_Callback(hObject, eventdata, handles)
% hObject    handle to lqGfxButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lqGfxButton
shotNumberTextBox_Callback(handles.shotNumberTextBox,eventdata,handles)


% --- Executes on button press in gatherDataButton.
function gatherDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to gatherDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = gatherData(handles);
names = fieldnames(data);
set(handles.uitable1,'Data',[names, struct2cell(data)])
setappdata(handles.figure1,'shotData',data)

% --- Executes on button press in saveDataButton.
function saveDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveData(handles);

% --- Executes on button press in markShotButton.
function markShotButton_Callback(hObject, eventdata, handles)
% hObject    handle to markShotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tmp = getappdata(handles.figure1,'shotMarked');
tmp = ~tmp;
setappdata(handles.figure1,'shotMarked',tmp);
gatherDataButton_Callback(handles.gatherDataButton, eventdata, handles);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% keyboard shortcuts
if strcmp(eventdata.Key,'i')
    shotForwardButton_Callback(handles.shotForwardButton, eventdata, handles)
elseif strcmp(eventdata.Key,'u')
    shotBackButton_Callback(handles.shotBackButton, eventdata, handles)
elseif strcmp(eventdata.Key,'g')
    gatherDataButton_Callback(handles.gatherDataButton, eventdata, handles)
elseif strcmp(eventdata.Key,'s')
    saveDataButton_Callback(handles.saveDataButton, eventdata, handles)
elseif strcmp(eventdata.Key,'j')
    indexBackButton_Callback(handles.indexBackButton, eventdata, handles)
elseif strcmp(eventdata.Key,'k')
    indexForwardButton_Callback(handles.indexForwardButton, eventdata, handles)
end



function compareTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to compareTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of compareTextBox as text
%        str2double(get(hObject,'String')) returns contents of compareTextBox as a double


% --- Executes during object creation, after setting all properties.
function compareTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compareTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in compareButton.
function compareButton_Callback(hObject, eventdata, handles)
% hObject    handle to compareButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tmp = get(handles.compareTextBox,'String');
set(handles.compareTextBox,'String',get(handles.shotNumberTextBox,'String'));
set(handles.shotNumberTextBox,'String',tmp);

shotNumberTextBox_Callback(handles.shotNumberTextBox,eventdata,handles)


% --- Executes on button press in freezeButton.
function freezeButton_Callback(hObject, eventdata, handles)
% hObject    handle to freezeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)