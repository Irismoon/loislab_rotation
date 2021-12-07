function varargout = NoiseRemoving_1(varargin)
% NOISEREMOVING_1 MATLAB code for NoiseRemoving_1.fig
%      NOISEREMOVING_1, by itself, creates a new NOISEREMOVING_1 or raises the existing
%      singleton*.
%
%      H = NOISEREMOVING_1 returns the handle to a new NOISEREMOVING_1 or the handle to
%      the existing singleton*.
%
%      NOISEREMOVING_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISEREMOVING_1.M with the given input arguments.
%
%      NOISEREMOVING_1('Property','Value',...) creates a new NOISEREMOVING_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NoiseRemoving_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NoiseRemoving_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NoiseRemoving_1

% Last Modified by GUIDE v2.5 16-Aug-2020 15:56:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NoiseRemoving_1_OpeningFcn, ...
                   'gui_OutputFcn',  @NoiseRemoving_1_OutputFcn, ...
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


% --- Executes just before NoiseRemoving_1 is made visible.
function NoiseRemoving_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NoiseRemoving_1 (see VARARGIN)

% Choose default command line output for NoiseRemoving_1
handles.output = hObject;
recycle('off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NoiseRemoving_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NoiseRemoving_1_OutputFcn(hObject, eventdata, handles) 
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

folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text11,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nSongFiles:    '])));
    set(handles.text2,'String',folder);
else
    set(handles.text2,'String','');
    set(handles.text11,'string',compose(string(['     /     ' '\nSongFiles:    '])));
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text12,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nSongFiles:    '])));
    set(handles.text3,'String',folder);
else
    set(handles.text3,'String','');
    set(handles.text12,'string',compose(string(['     /     ' '\nSongFiles:    '])));
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text13,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nSongFiles:    '])));
    set(handles.text4,'String',folder);
else
    set(handles.text4,'String','');
    set(handles.text13,'string',compose(string(['     /     ' '\nSongFiles:    '])));
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text14,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nSongFiles:    '])));
    set(handles.text5,'String',folder);
else
    set(handles.text5,'String','');
    set(handles.text14,'string',compose(string(['     /     ' '\nSongFiles:    '])));
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text15,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nSongFiles:    '])));
    set(handles.text6,'String',folder);
else
    set(handles.text6,'String','');
    set(handles.text15,'string',compose(string(['     /     ' '\nSongFiles:    '])));
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text16,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nSongFiles:    '])));
    set(handles.text7,'String',folder);
else
    set(handles.text7,'String','');
    set(handles.text16,'string',compose(string(['     /     ' '\nSongFiles:    '])));
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text17,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nSongFiles:    '])));
    set(handles.text8,'String',folder);
else
    set(handles.text8,'String','');
    set(handles.text17,'string',compose(string(['     /     ' '\nSongFiles:    '])));
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text18,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nSongFiles:    '])));
    set(handles.text9,'String',folder);
else
    set(handles.text9,'String','');
    set(handles.text18,'string',compose(string(['     /     ' '\nSongFiles:    '])));
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text19,'Value',0);
set(handles.startbutton,'ForegroundColor','r');
if ~isempty(get(handles.text2,'String'))
    SongCleaning(hObject,handles);
end
set(handles.startbutton,'ForegroundColor','k');


function SongCleaning(hObject,handles)
folder={};
folder{1}=get(handles.text2,'String');
folder{2}=get(handles.text3,'String');
folder{3}=get(handles.text4,'String');
folder{4}=get(handles.text5,'String');
folder{5}=get(handles.text6,'String');
folder{6}=get(handles.text7,'String');
folder{7}=get(handles.text8,'String');
folder{8}=get(handles.text9,'String');
for p=1:8

    if ~isempty(folder{p})
        cd(folder{p});
        File=dir('*.wav');
        Filename={File.name};
        mkdir('Noises');
        n_song=0; i=0;
        
        switch p
            case 1
                set(handles.text11,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                del=get(handles.checkbox1,'Value');
            case 2
                set(handles.text12,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                del=get(handles.checkbox2,'Value');
            case 3
                set(handles.text13,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                del=get(handles.checkbox3,'Value');
            case 4
                set(handles.text14,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                del=get(handles.checkbox4,'Value');
            case 5
                set(handles.text15,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                del=get(handles.checkbox5,'Value');
            case 6
                set(handles.text16,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                del=get(handles.checkbox6,'Value');
            case 7
                set(handles.text17,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                del=get(handles.checkbox7,'Value');
            case 8
                set(handles.text18,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                del=get(handles.checkbox8,'Value');
        end
        Mark=[];
        for i=1:fix(length(Filename)/100)+1
            parfor q=100*(i-1)+1:min(100*i,length(Filename))
                Mark(q)=isSong(Filename{q});
                if ~Mark(q)
                    switch del
                    case 0
                        movefile(Filename{q},'Noises');
                    case 1
                        delete(Filename{q});
                    end
                end
            end
            n_song=length(find(Mark==1));
            
            switch p
                case 1
                    set(handles.text11,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                case 2
                    set(handles.text12,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                case 3
                    set(handles.text13,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                case 4
                    set(handles.text14,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                case 5
                    set(handles.text15,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                case 6
                    set(handles.text16,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                case 7
                    set(handles.text17,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
                case 8
                    set(handles.text18,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nSongFiles:' num2str(n_song)])));
            end
            pause(0.001);

            if get(handles.text19,'Value')
                return
            end
        end
    end
end
set(handles.text19,'Value',0);

function ifSong=isSong(Filename)

[songdata,fs]=audioread(Filename);
binsize=fix(fs/100);
songMark=highpass(songdata,1000,fs);
songMark=movmean(abs(songMark),binsize);
songMark(songMark<0.001)=0;
Thresh=find(songMark>0.001);

ifSong=0;
N=0;
                
END=[Thresh(diff(Thresh)>fs*0.5);Thresh(end)];
START=[Thresh(1);Thresh(find(diff(Thresh)>fs*0.5)+1)];
            
q=1;
while ~ifSong
    if END(q)-START(q)>fs*0.8
        cache=songdata(START(q):END(q));
        r=1;Mark=[];
        while r<length(cache)/fs*10
            if bandpower(cache((r-1)*fs*0.1+1:r*fs*0.1),fs,[1000 7000])/bandpower(cache((r-1)*fs*0.1+1:r*fs*0.1),fs,[200 1000])>4 && ...
                bandpower(cache((r-1)*fs*0.1+1:r*fs*0.1),fs,[1000 7000])/bandpower(cache((r-1)*fs*0.1+1:r*fs*0.1),fs,[200 1000])<1000
                Mark(r)=1;
            else
                Mark(r)=0;
            end
            if r>7 
                if length(find(Mark(r-7:r)>0))>4
                    ifSong=1; break;
                end
            end
            r=r+1;
        end
    end
    q=q+1;
    if q>length(START)
        break;
    end
end
return 