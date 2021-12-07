%---------------------------------------------------------------------------------------
%   Song Preview ver 2.08
%
%   Aug 20 2020: global variable 'new_destination' added, to remember the folder path to
%       store newly cut song bouts.
%   Aug 26 2020: new 'expand' button added. it locates and visilizes the parent song file 
%       where the current selected song bout was cut, so that user can change the current 
%       bout by re-select mannually in the sonogram.
%   Aug 31 2020: when viewing parent song files, now daughter bouts will be
%       indicated with a red square.
%   Sep 8 2020: 'clear' button added. it deletes all the daughter bouts
%       made from the current parent song file. so that new bouts can be
%       made manually.
%   Oct 1 2020: key press on 'c' will utilize the 'clear' button function.
%   Oct 10 2020: Hotplot for pretty visualization.
%   Apr 7 2021: function of 'expand' button modified. 'Hotplot' now gives
%       spectral derivative plot in the colormap of bone. (*NOT scaled)
%   Apr 27 2021: 'Hotplot' now uses another GUI, SongDisplay, for better
%       visualization and image export. 'shuffle' button added, which
%       shuffles the list of wav files.
%
%---------------------------------------------------------------------------------------

function varargout = SongPreview_208(varargin)
% SONGPREVIEW_208 MATLAB code for SongPreview_208.fig
%      SONGPREVIEW_208, by itself, creates a new SONGPREVIEW_208 or raises the existing
%      singleton*.
%
%      H = SONGPREVIEW_208 returns the handle to a new SONGPREVIEW_208 or the handle to
%      the existing singleton*.
%
%      SONGPREVIEW_208('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SONGPREVIEW_208.M with the given input arguments.
%
%      SONGPREVIEW_208('Property','Value',...) creates a new SONGPREVIEW_208 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SongPreview_208_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SongPreview_208_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SongPreview_208

% Last Modified by GUIDE v2.5 27-Apr-2021 12:59:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SongPreview_208_OpeningFcn, ...
                   'gui_OutputFcn',  @SongPreview_208_OutputFcn, ...
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


% --- Executes just before SongPreview_208 is made visible.
function SongPreview_208_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SongPreview_208 (see VARARGIN)

% Choose default command line output for SongPreview_208
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(hObject,'toolbar','figure');
% set(hObject,'menubar','figure');
%initialize parameters
global fileList fileList_select current_select sampleRate
fileList = {};
fileList_select = {};
current_select = {};
sampleRate = 44100; %sampling rate of .wav files

% UIWAIT makes SongPreview_208 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SongPreview_208_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global current_select;
contents = cellstr(get(hObject, 'String'));
filename = contents{get(hObject, 'Value')};
if (filename)
    current_select = filename;
    showsonogram(handles);
end


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_dir.
function button_dir_Callback(hObject, eventdata, handles)
% hObject    handle to button_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fileList fileList_select current_select new_destination
pathName = uigetdir;
if (pathName)
    new_destination=pathName;
    cd(pathName);
    fileList_select={};
    fileDIR = dir([pathName '/*.wav']);
    fileList = sort_nat({fileDIR.name});
    set(handles.text3,'String',pathName);
    set(handles.listbox1,'String',fileList);
    set(handles.listbox2,'String',fileList_select);
    set(handles.listbox1,'Value',1);
    set(handles.listbox2,'Value',1);
    current_select = {};
end

% --- Executes on button press in button_move.
function button_move_Callback(hObject, eventdata, handles)
% hObject    handle to button_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fileList_select
if ~isempty(fileList_select)
    pathName = uigetdir('move selected files to folder');
    if (pathName)
        for i=1:length(fileList_select)
            movefile(fileList_select{i},pathName);
        end
        fileList_select = {};
        set(handles.listbox2,'String',fileList_select);
        set(handles.listbox2,'value',1);
    end
end


% --- Executes on button press in button_del.
function button_del_Callback(hObject, eventdata, handles)
% hObject    handle to button_del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fileList_select
if ~isempty(fileList_select)
    selection = questdlg('Confirm to delete these files?','Confirm Delete',...
        'Confirm','Cancel','Cancel');
    switch selection
        case 'Confirm'
            recycle('on');
            for i=1:length(fileList_select)
                delete(fileList_select{i});
            end
            fileList_select = {};
            set(handles.listbox2,'String',fileList_select);
            set(handles.listbox2,'value',1);
        case 'Cancel'
    end
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
global current_select;
contents = cellstr(get(hObject, 'String'));
if length(contents)>0
    filename = contents{get(hObject, 'Value')};
    current_select = filename;
    showsonogram(handles);
end


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_add.
function button_add_Callback(hObject, eventdata, handles)
% hObject    handle to button_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global current_select fileList fileList_select
% if isempty(current_select)
%     return;
% end
% idx_l = get(handles.listbox1,'value');
% if idx_l == length(fileList) && length(fileList)>1
%     idx_l=idx_l-1;
% end
% idx_r = get(handles.listbox2,'value');
% if idx_r == length(fileList_select) && length(fileList_select)>1
%     idx_r = idx_r-1;
% end
% if isempty(find(ismember(fileList_select,current_select)));
%     fileList_select{end+1}= current_select;
%     fileList = fileList(find(~ismember(fileList,current_select)));
%     set(handles.listbox1,'Value',idx_l);
% else
%     fileList_select = fileList_select(find(~ismember(fileList_select,current_select)));
%     if isempty(find(ismember(fileList,current_select)))
%         fileList{end+1} = current_select;
%     end
%     set(handles.listbox2,'Value',idx_r);
% end
% fileList = sort(fileList);
% fileList_select = sort(fileList_select);
% 
% set(handles.listbox1,'String',fileList);
% set(handles.listbox2,'String',fileList_select);
% 
% current_select = {};

% --- Executes on button press in button_playsound.
function button_playsound_Callback(hObject, eventdata, handles)
% hObject    handle to button_playsound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current_select;
if (current_select)
    [soundData,fs] = audioread(current_select);
    sound(soundData,fs);
end


% --- Executes on key press with focus on listbox1 and none of its controls.
function listbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global current_select fileList fileList_select
switch eventdata.Key 
    case 'm' 
        if ~isempty(current_select)
            idx = get(hObject,'Value');
            fileList_select{end+1} = fileList{idx};
            fileList(idx) = [];
            if idx>1 && length(fileList)<idx
                set(hObject,'Value',idx-1)
            end
            set(hObject,'String',fileList);
            fileList_select = sort_nat(fileList_select);
            set(handles.listbox2,'String',fileList_select);
            if ~isempty(fileList)
                current_select = fileList{get(hObject,'Value')};
                showsonogram(handles);
            else
                current_select = {};
            end
        end
    case 'c'
        if (current_select)
            filename=current_select;
            if isfolder('Bouts')
                daughter_file=dir(['Bouts\' erase(filename,'.wav') '*.wav']);
                daughter_filename={daughter_file.name};
                    if ~isempty(daughter_filename) 
                        for i=1:length(daughter_filename)
                            delete(['Bouts\' daughter_filename{i}]);
                        end
                        showsonogram(handles);
                    end
            end
        end
end


% --- Executes on key press with focus on listbox2 and none of its controls.
function listbox2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global current_select fileList fileList_select
switch eventdata.Key 
    case 'm' 
        if ~isempty(current_select)
            idx = get(hObject,'Value');
            fileList{end+1} = fileList_select{idx};
            fileList_select(idx) = [];
            if idx>1 && length(fileList_select)<idx
                set(hObject,'Value',idx-1)
            end
            set(hObject,'String',fileList_select);
            fileList = sort_nat(fileList);
            set(handles.listbox1,'String',fileList);
            if length(fileList_select)>0
                current_select = fileList_select{get(hObject,'Value')};
                showsonogram(handles);
            else
                current_select = {};
            end
        end
end


% --- Executes on button press in pushbutton_cut.
function pushbutton_cut_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current_select
if ~isempty(current_select)
    h_select=drawrectangle(handles.axes1);
    if isvalid(h_select)
         selection = questdlg('Confirm to trim this song?','Confirm',...
        'Confirm','Cancel','Cancel');
        switch selection
            case 'Confirm'
            [songdata,fs]=audioread(current_select);
            newxlim=h_select.Position([1,3]);
            cache=fix(max(length(songdata)*newxlim(1)/3.5,1)):fix(min(length(songdata),(newxlim(1)+newxlim(2))*length(songdata)/3.5));
            delete(current_select);
            audiowrite(current_select,songdata(cache),fs);
            showsonogram(handles);
            case 'Cancel'
        end
    end
    delete(h_select);
end
        


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current_select
global new_destination
if ~isempty(current_select)
    h_select=drawrectangle(handles.axes1);
    if isvalid(h_select)
         selection = questdlg('Confirm to make new bout file?','Confirm',...
        'Confirm','Cancel','Cancel');
        switch selection
            case 'Confirm'
            [songdata,fs]=audioread(current_select);
            newxlim=h_select.Position([1,3]);
            cache=fix(max(length(songdata)*newxlim(1)/3.5,1)):fix(min(length(songdata),(newxlim(1)+newxlim(2))*length(songdata)/3.5));
            selpath=uigetdir(new_destination,'where to put the new file?');
            if selpath
                newFile=[selpath '\' erase(current_select,'.wav') '_' num2str(fix(cache(1)*2/fs)/2) '.wav'];
                audiowrite(newFile,songdata(cache),fs);
                new_destination=selpath;
            end
            case 'Cancel'
        end
    end
    delete(h_select);
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fileList current_select
if ~isempty(current_select) && get(handles.listbox1,'Value')<length(fileList)
    post_song=fileList{get(handles.listbox1,'Value')+1};
    splits=strsplit(post_song,'_');
    if length(splits)==8 && str2num(erase(splits{8},'.wav'))==0
        [boutdata,fs]=audioread(post_song);
        [cache,fs]=audioread(current_select);
        boutdata=[cache;boutdata];
        newFigure=figure();
        newAx=axes(newFigure,'box','off');
        [s,f,t]=spectrogram(boutdata,fix(fs/100),fix(fs/125),512,fs,'yaxis');
        sonogram_im=abs(s(f<12000&f>300,:));
        imshow(flip(sonogram_im),'Parent',newAx,'XData',[0 10],'YData',[0 1]);
        colormap(flip(gray));
        xticks([0:10/(length(boutdata)/fs*2):10]);
        yticks([]);
        xticklabels([]);
        xlabel('500ms / tick')
        axis on;
        newFigure.WindowState='maximized';
        selection = questdlg('Confirm to merge these two files?','Confirm',...
            'Confirm','Cancel','Cancel');
        switch selection
            case 'Confirm'
                delete(current_select);
                audiowrite(current_select,boutdata,fs);
                delete(post_song);
%                 fileDIR = dir('*.wav');
%                 fileList = sort_nat({fileDIR.name});
                fileList(get(handles.listbox1,'Value')+1)=[];
                set(handles.listbox1,'String',fileList);
                close(newFigure);
                showsonogram(handles);
            case 'Cancel'
                close(newFigure);
        end
    end
end


% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current_select;
if (current_select)
    filename=current_select;
    if isfolder('Bouts')
        daughter_file=dir(['Bouts\' erase(filename,'.wav') '*.wav']);
        daughter_filename={daughter_file.name};
        if ~isempty(daughter_filename) 
            for i=1:length(daughter_filename)
                delete(['Bouts\' daughter_filename{i}]);
            end
            showsonogram(handles);
        end
    end
end

function showsonogram(handles)
global current_select;
if (current_select)
    filename=current_select;
    [soundData,fs] = audioread(filename);
    [s,f,t]=spectrogram(soundData,fix(fs/100),fix(fs/130),1024,fs,'yaxis');
    sonogram_im=abs(s(f<12000&f>300,:));
    imshow(flip(sonogram_im),'Parent',handles.axes1,'XData',[0 3.5],'YData',[0 1]);
    colormap(flip(gray));
%     colormap(hot(256));
    xticks([0:3.5/(length(soundData)/fs*2):3.5]);
    yticks([]);
    xticklabels([]);
    xlabel('500ms / tick');
    axis on;
    if isfolder('Bouts')
        daughter_file=dir(['Bouts\' erase(filename,'.wav') '*.wav']);
        daughter_filename={daughter_file.name};
        for i=1:length(daughter_filename)
            [boutData,fs]=audioread(['Bouts\' daughter_filename{i}]);
            offsetstr=split(erase(daughter_filename{i},'.wav'),'_');
            offset=str2num(offsetstr{end})*fs;
            [r,lags]=xcorr(boutData,soundData);
            r=r(find(lags<fs/2-offset+1 & lags>-fs/2-offset-1));
            lags=lags(find(lags<fs/2-offset+1 & lags>-fs/2-offset-1));
            [M,I]=max(r);
            drawrectangle(handles.axes1,'color',[0.5 0 0],'position',[3.5/length(soundData)*abs(lags(I)) 0 3.5/length(soundData)*length(boutData) 1]);
        end
    end
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current_select;
if ~isempty(current_select)
    SongDisplay_100(current_select);
%     filename=current_select;
%     [data,fs]=audioread(filename);
%     
%     [s,f,t]=spectrogram(data,fix(fs/100),fix(fs/111),4096,fs,'yaxis');
%     sonogram_im=abs(s(f<10000&f>150,:));
%     newFigure=figure();
%     [px,py]=gradient(sonogram_im);
%     im=((px/5).^2+py.^2).^0.5.*(px/5+py)./abs(px/5+py);
%     im=rescale(im);
%     im=imadjust(im,]);

%     imshow(flip(im*4+0.5),'border','tight');
%     image(flip(im*4+0.5));
    
%     [Image,f,t]=zftftb_pretty_sonogram(data,fs,'len', 20,'overlap',18,'filtering',200);
%     Image=Image(find(f<10000&f>350),:);f=f(f<10000&f>350);
    
%     newAx=axes(newFigure,'box','off');
%     imagesc(t,f,Image);
%     set(gca, 'ydir', 'normal');
    % c=gray(256);c=flipud(c);
    % colormap(c);
%     colormap(bone);
%     axis([0 1.5 350 10000]);
%     pbaspect([1.5 1 1]);
%     axis off;
%     figure;
%     imshow(Image*1.5);
%     colormap(hot(256));
%     set(gca, 'ydir', 'normal');
%     newFigure.WindowState='maximized';
end


% --- Executes on button press in pushbutton_shuffle.
function pushbutton_shuffle_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_shuffle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fileList current_select
if ~isempty(fileList)
    cache=strsplit(fileList{1},'_');
    if cache{1}=='S'
        selection = questdlg('Do you want to un-shuffle the files?','Confirm',...
        'Confirm','Cancel','Cancel');
        switch selection
            case 'Confirm'
                recycle('off');
                for i=1:length(fileList)
                    newname=strsplit(fileList{i},'_');
                    newname(1:2)=[];
                    newname=join(newname,'_');
                    movefile(fileList{i},newname{1});
                end
                fileDIR = dir('*.wav');
                fileList = sort_nat({fileDIR.name});
                fileList = sort_nat(fileList);
                set(handles.listbox1,'String',fileList);
                set(handles.listbox1,'Value',1);
                current_select = {};
            case 'Cancel'
        end
    else
        selection = questdlg('Do you want to shuffle the files?','Confirm',...
        'Confirm','Cancel','Cancel');
        switch selection
            case 'Confirm'
                recycle('off');
                newsequence=randperm(length(fileList));
                for i=1:length(newsequence)
                    movefile(fileList{i},['S_' num2str(newsequence(i)) '_' fileList{i}]);
                end
                fileDIR = dir('*.wav');
                fileList = sort_nat({fileDIR.name});
                fileList = sort_nat(fileList);
                set(handles.listbox1,'String',fileList);
                set(handles.listbox1,'Value',1);
                current_select = {};
            case 'Cancel'
        end
    end
end
        
