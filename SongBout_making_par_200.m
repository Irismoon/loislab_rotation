%   Song Bout Making (parallel working) ver 1.02
%   Aug 2020
%   Sep 2020 optimized algorism; bug fixed
%   !!!Requies Parallel Computing Toolbox!!!

function varargout = SongBout_making(varargin)
% SONGBOUT_MAKING MATLAB code for SongBout_making.fig
%      SONGBOUT_MAKING, by itself, creates a new SONGBOUT_MAKING or raises the existing
%      singleton*.
%  
%      H = SONGBOUT_MAKING returns the handle to a new SONGBOUT_MAKING or the handle to
%      the existing singleton*.
%
%      SONGBOUT_MAKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SONGBOUT_MAKING.M with the given input arguments.
%
%      SONGBOUT_MAKING('Property','Value',...) creates a new SONGBOUT_MAKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SongBout_making_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SongBout_making_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SongBout_making

% Last Modified by GUIDE v2.5 29-Apr-2021 07:54:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SongBout_making_OpeningFcn, ...
                   'gui_OutputFcn',  @SongBout_making_OutputFcn, ...
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


% --- Executes just before SongBout_making is made visible.
function SongBout_making_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SongBout_making (see VARARGIN)

% Choose default command line output for SongBout_making
handles.output = hObject;
recycle('off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SongBout_making wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SongBout_making_OutputFcn(hObject, eventdata, handles) 
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
    set(handles.text11,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nNo. of bouts:    '])));
    set(handles.text2,'String',folder);
else
    set(handles.text2,'String','');
    set(handles.text11,'string',compose(string(['     /     ' '\nNo. of bouts:    '])));
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text12,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nNo. of bouts:    '])));
    set(handles.text3,'String',folder);
else
    set(handles.text3,'String','');
    set(handles.text12,'string',compose(string(['     /     ' '\nNo. of bouts:    '])));
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text13,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nNo. of bouts:    '])));
    set(handles.text4,'String',folder);
else
    set(handles.text4,'String','');
    set(handles.text13,'string',compose(string(['     /     ' '\nNo. of bouts:    '])));
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text14,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nNo. of bouts:    '])));
    set(handles.text5,'String',folder);
else
    set(handles.text5,'String','');
    set(handles.text14,'string',compose(string(['     /     ' '\nNo. of bouts:    '])));
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text15,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nNo. of bouts:    '])));
    set(handles.text6,'String',folder);
else
    set(handles.text6,'String','');
    set(handles.text15,'string',compose(string(['     /     ' '\nNo. of bouts:    '])));
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text16,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nNo. of bouts:    '])));
    set(handles.text7,'String',folder);
else
    set(handles.text7,'String','');
    set(handles.text16,'string',compose(string(['     /     ' '\nNo. of bouts:    '])));
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text17,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nNo. of bouts:    '])));
    set(handles.text8,'String',folder);
else
    set(handles.text8,'String','');
    set(handles.text17,'string',compose(string(['     /     ' '\nNo. of bouts:    '])));
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir('', 'Select Folder to Clean');
if folder
    cd(folder);
    set(handles.text18,'string',compose(string(['     / ' num2str(length(dir('*.wav'))) '\nNo. of bouts:    '])));
    set(handles.text9,'String',folder);
else
    set(handles.text9,'String','');
    set(handles.text18,'string',compose(string(['     /     ' '\nNo. of bouts:    '])));
end


% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text19,'Value',0);
set(handles.startbutton,'ForegroundColor','r');
if length(get(handles.text2,'String'))
    SongCleaning(hObject,handles);
end
set(handles.startbutton,'ForegroundColor','k');


% --- Executes on button press in stopbutton.
function stopbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stopbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.startbutton,'ForegroundColor','k');
set(handles.text19,'Value',1);

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

poolobj=gcp('nocreate');
if isempty(poolobj)
    poolobj=parpool;
    poolsize=poolobj.NumWorkers;
else
    poolsize=poolobj.NumWorkers;
end

poolsize=poolsize*2;

StopNum=str2double(get(handles.edit1,'String'));

for p=1:8

    if ~isempty(folder{p})
        cd(folder{p});
        File=dir('*.wav');
        Filename={File.name};
        Filename=sort_nat(Filename);
        mkdir('Noises');
        mkdir('Bouts');
        n_song=0; i=0;
        
        switch p
            case 1
                set(handles.text11,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_song)])));

            case 2
                set(handles.text12,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_song)])));

            case 3
                set(handles.text13,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_song)])));

            case 4
                set(handles.text14,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_song)])));

            case 5
                set(handles.text15,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_song)])));

            case 6
                set(handles.text16,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_song)])));

            case 7
                set(handles.text17,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_song)])));

            case 8
                set(handles.text18,'string',compose(string([num2str(i) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_song)])));
        
        end
        Mark=[];
        for i=1:fix(length(Filename)/poolsize)+1
            parfor q=poolsize*(i-1)+1:min(poolsize*i,length(Filename))
                Mark(q)=CutBouts(Filename{q});
                if Mark(q)==0
                    movefile(Filename{q},'Noises');
                end
            end
            n_bouts=sum(Mark);
            switch p
                case 1
                    set(handles.text11,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_bouts)])));
                case 2
                    set(handles.text12,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_bouts)])));
                case 3
                    set(handles.text13,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_bouts)])));
                case 4
                    set(handles.text14,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_bouts)])));
                case 5
                    set(handles.text15,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_bouts)])));
                case 6
                    set(handles.text16,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_bouts)])));
                case 7
                    set(handles.text17,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_bouts)])));
                case 8
                    set(handles.text18,'string',compose(string([num2str(length(Mark)) ' / ' num2str(length(Filename)) '\nNo. of bouts:' num2str(n_bouts)])));
            end
            pause(0.001);
            
            
            
            if get(handles.text19,'Value')
                return
            end
            
            if StopNum && n_bouts>=StopNum
                break;
            end
        end
    end
end
set(handles.text19,'Value',0);

function noofbouts=CutBouts(Filename)
[songdata,fs]=audioread(Filename);
binsize=fix(fs/20);
songMark=[];boutMark=[0;0;0;0;0;0;0;0;0];

for j=1:fix(length(songdata)/binsize)
    if bandpower(songdata(binsize*(j-1)+1:binsize*j),fs,[1000 7000])/bandpower(songdata(binsize*(j-1)+1:binsize*j),fs,[200 1000])>2
        songMark(j)=1;
    else
        songMark(j)=0;
    end
end
j=10;
while j<=fix(length(songdata)/binsize)
    if length(find(songMark(j-9:j)==1))>5 && songMark(j)==1
        bouthead=find(songMark(j-9:j)==1,1)+j-10;
        bouttail=j;
        while bouthead>9
            if max(songMark(bouthead-9:bouthead-1))==0
                break;
            end
            bouthead=find(songMark(bouthead-9:bouthead-1)==1,1)+bouthead-10;
        end
        if bouthead<10
            bouthead=find(songMark(1:bouthead)==1,1);
        end
        while bouttail<fix(length(songdata)/binsize)-8
            if max(songMark(bouttail+1:bouttail+9))==0
                break;
            end
            bouttail=find(songMark(bouttail+1:bouttail+9)==1,1,'last')+bouttail;
        end
        if bouttail>fix(length(songdata)/binsize)-9
            bouttail=find(songMark(bouttail:end)==1,1,'last')+bouttail-1;
        end
        boutMark(bouthead:bouttail)=1;
        j=bouttail+1;
    else
        boutMark(j)=0;
        j=j+1;
    end
end

noofbouts=0;
if ~isempty(find(boutMark==1,1))
    
    Thresh=find(boutMark==1);

    if(Thresh(end)>length(songdata)/binsize-5)
        END=[Thresh(diff(Thresh)>=10);fix(length(songdata)/binsize)];
    else
        END=[Thresh(diff(Thresh)>=10);Thresh(end)];
    end
    
    START=[Thresh(1);Thresh(find(diff(Thresh)>=10)+1)];

    for q=1:length(START)
        if END(q)-START(q)>=5
            noofbouts=noofbouts+1;
            START(q)=max((START(q)-5)*binsize+1,1);
            END(q)=min((END(q)+4)*binsize,length(songdata));
            newFile=['Bouts\' erase(Filename,'.wav') '_' num2str(fix(START(q)*2/fs)/2) '.wav'];
            audiowrite(newFile,songdata(START(q):END(q)),fs);
        end
    end
end
   



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
