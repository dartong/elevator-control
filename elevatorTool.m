function varargout = elevatorTool(varargin)
% ELEVATORTOOL MATLAB code for elevatorTool.fig
%      ELEVATORTOOL, by itself, creates a new ELEVATORTOOL or raises the existing
%      singleton*.
%
%      H = ELEVATORTOOL returns the handle to a new ELEVATORTOOL or the handle to
%      the existing singleton*.
%
%      ELEVATORTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELEVATORTOOL.M with the given input arguments.
%
%      ELEVATORTOOL('Property','Value',...) creates a new ELEVATORTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before elevatorTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to elevatorTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help elevatorTool

% Last Modified by GUIDE v2.5 24-Apr-2018 18:08:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @elevatorTool_OpeningFcn, ...
                   'gui_OutputFcn',  @elevatorTool_OutputFcn, ...
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


% --- Executes just before elevatorTool is made visible.
function elevatorTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to elevatorTool (see VARARGIN)

% Choose default command line output for elevatorTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes elevatorTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = elevatorTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.stopButton.Enable = 'on';
%handles.pauseButton.Enable = 'on';

hObject.Enable = 'off';
%hObject.String = 'Running...';
main(handles);
hObject.Enable = 'on';

% --- Executes on button press in plottingCheck.
function plottingCheck_Callback(hObject, eventdata, handles)
% hObject    handle to plottingCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plottingCheck



function iterationsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to iterationsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterationsEdit as text
%        str2double(get(hObject,'String')) returns contents of iterationsEdit as a double


% --- Executes during object creation, after setting all properties.
function iterationsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterationsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function deltaTEdit_Callback(hObject, eventdata, handles)
% hObject    handle to deltaTEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deltaTEdit as text
%        str2double(get(hObject,'String')) returns contents of deltaTEdit as a double


% --- Executes during object creation, after setting all properties.
function deltaTEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deltaTEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)
% hObject    handle to stopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pauseButton.
function pauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to pauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stepButton.
function stepButton_Callback(hObject, eventdata, handles)
% hObject    handle to stepButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function plotspeedEdit_Callback(hObject, eventdata, handles)
% hObject    handle to plotspeedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plotspeedEdit as text
%        str2double(get(hObject,'String')) returns contents of plotspeedEdit as a double


% --- Executes during object creation, after setting all properties.
function plotspeedEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotspeedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function floorheightEdit_Callback(hObject, eventdata, handles)
% hObject    handle to floorheightEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of floorheightEdit as text
%        str2double(get(hObject,'String')) returns contents of floorheightEdit as a double


% --- Executes during object creation, after setting all properties.
function floorheightEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to floorheightEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function callfrequencyEdit_Callback(hObject, eventdata, handles)
% hObject    handle to callfrequencyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of callfrequencyEdit as text
%        str2double(get(hObject,'String')) returns contents of callfrequencyEdit as a double


% --- Executes during object creation, after setting all properties.
function callfrequencyEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to callfrequencyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
