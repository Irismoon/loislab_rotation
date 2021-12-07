% -----------------
% Ver 1.0 Apr 2021
% -----------------

function varargout = Directed_GUI(varargin)
% Directed_GUI MATLAB code for Directed_GUI.fig
%      Directed_GUI, by itself, creates a new Directed_GUI or raises the existing
%      singleton*.
%
%      H = Directed_GUI returns the handle to a new Directed_GUI or the handle to
%      the existing singleton*.
%
%      Directed_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Directed_GUI.M with the given input arguments.
%
%      Directed_GUI('Property','Value',...) creates a new Directed_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the Directed_GUI before Directed_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Directed_GUI_OpeningFcn via varargin.
%
%      *See Directed_GUI Options on GUIDE's Tools menu.  Choose "Directed_GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Directed_GUI

% Last Modified by GUIDE v2.5 12-Aug-2019 11:45:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Directed_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Directed_GUI_OutputFcn, ...
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


% --- Executes just before Directed_GUI is made visible.
function Directed_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Directed_GUI (see VARARGIN)

% Choose default command line output for Directed_GUI
handles.output = hObject;

handles.vid = videoinput('winvideo',1,'MJPG_640x360');
im=image(zeros(360,640),'Parent',handles.axes5);
handles.vid.FramesPerTrigger=800;
handles.vid.LoggingMode='memory';
preview(handles.vid,im);
% Update handles structure
guidata(hObject, handles);



% UIWAIT makes Directed_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Directed_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Running
Running=1;
% if ~isfolder('NoSong')
%     mkdir('NoSong');
% end
Uno=arduino('COM3','UNO');
set(handles.text5,'String',num2str(1));
set(handles.text7,'String',num2str(0));
TrialNum=1;
deviceReader = audioDeviceReader('SamplesPerFrame',4410,'Device','Microphone (HD Pro Webcam C920)','NumChannels',2);

while(Running)

    set(handles.text5,'String',num2str(TrialNum));
    mark=[];cache=[];ifSong=[];signal=[];
    
    cTime=string(fix(clock()));
    start(handles.vid);pause(0.2);
    writeDigitalPin(Uno,'D13',0);
    fprintf('Mic on\n');
    axes(handles.axes3);cla;hold on;
    for N = 1:250
        cache = deviceReader();
        signal = [signal; cache(:,1)]; 
        mark(N) = bandpower(cache,44100,[1000 7000])/bandpower(cache,44100,[0 1000]);
        if N>=10 && length(find(mark(N-9:N)>3))>5
            ifSong(N)=1;
        else
            ifSong(N)=0;
        end
        plot([4410*(N-1)+1:4410*N],cache,'k');
        xlim([0 25*44100]); xticks(44100*[0:25]); xticklabels([0:25]);
        pause(0.001);
    end
    fprintf('Mic off\n');
    writeDigitalPin(Uno,'D13',1);
    birdID=get(handles.edit1,'String');
    audioFile=string(birdID)+'_'+cTime(1)+cTime(2)+cTime(3)+'_'+cTime(4)+'_'+cTime(5)+'_'+cTime(6)+'.wav';
    videoFile=string(birdID)+'_'+cTime(1)+cTime(2)+cTime(3)+'_'+cTime(4)+'_'+cTime(5)+'_'+cTime(6)+'.avi';
    if ~isempty(find(ifSong>0, 1))
        HitorMiss(TrialNum)=1;
        audiowrite(audioFile,signal,44100);
        videodata=getdata(handles.vid);
        v=VideoWriter(videoFile);
        open(v);writeVideo(v,videodata);close(v);
    else
        HitorMiss(TrialNum)=0;
        audiowrite('NS_'+audioFile,signal,44100);
        videodata=getdata(handles.vid);
        v=VideoWriter('NS_'+videoFile);
        open(v);writeVideo(v,videodata);close(v);
    end
    
    switch HitorMiss(TrialNum)
        case 0
            
        case 1
            set(handles.text7,'String',num2str(str2num(get(handles.text7,'String'))+1));
    end
    axes(handles.axes1);
    scatter(1:TrialNum,HitorMiss);
    ylim([-1 2]);yticks([-1 0 1 2]); yticklabels({'','Miss','Hit',''});
    TrialNum=TrialNum+1;
    pausetime=fix(30+rand*300);
    while(pausetime)
        set(handles.text9,'String',num2str(pausetime));
        pause(1);
        if Running==0
            break;
        end
        pausetime=pausetime-1;
    end
end
release(deviceReader);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Running
% set(handles.text5,'String','0');
Running=0;

fprintf('stop\n');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
