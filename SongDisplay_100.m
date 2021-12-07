function varargout = SongDisplay_100(varargin)
% SONGDISPLAY_100 MATLAB code for SongDisplay_100.fig
%      SONGDISPLAY_100, by itself, creates a new SONGDISPLAY_100 or raises the existing
%      singleton*.
%
%      H = SONGDISPLAY_100 returns the handle to a new SONGDISPLAY_100 or the handle to
%      the existing singleton*.
%
%      SONGDISPLAY_100('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SONGDISPLAY_100.M with the given input arguments.
%
%      SONGDISPLAY_100('Property','Value',...) creates a new SONGDISPLAY_100 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SongDisplay_100_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SongDisplay_100_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SongDisplay_100

% Last Modified by GUIDE v2.5 27-Apr-2021 10:23:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SongDisplay_100_OpeningFcn, ...
                   'gui_OutputFcn',  @SongDisplay_100_OutputFcn, ...
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


% --- Executes just before SongDisplay_100 is made visible.
function SongDisplay_100_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SongDisplay_100 (see VARARGIN)

% Choose default command line output for SongDisplay_100
handles.output = hObject;
global im filename
% Update handles structure
guidata(hObject, handles);

if ~isempty(varargin)
    filename=varargin{1};
    [data,fs]=audioread(filename);
    [s,f,t]=spectrogram(data,fix(fs/100),fix(fs/111),4096,fs,'yaxis');
    sonogram_im=abs(s(f<10000&f>150,:));
    [px,py]=gradient(sonogram_im);
    im=((px/5).^2+py.^2).^0.5.*(px/5+py)./abs(px/5+py);
    imshow(flip(im(:,1:min(3000,size(im,2)))*4+0.5),'parent',handles.axes1,'XData',[0 min(30,size(im,2)/100)],'YData',[0 9]);
    colormap(gray(256));
    axis off;
    set(handles.slider1,'Max',max(size(im,2)-2999,1));
    set(handles.slider1,'Min',1);
    set(handles.slider1,'SliderStep',[0.005 0.01]);
    set(handles.slider1,'Value',1);
end

% UIWAIT makes SongDisplay_100 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SongDisplay_100_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global im;
sliderPos=get(handles.slider1,'Value');
im_l=fix(sliderPos);
im_r=min(im_l+2999,size(im,2));
im_len=im_r-im_l+1;
imshow(flip(im(:,im_l:im_r)*4+0.5),'parent',handles.axes1,'XData',[0 im_len/100],'YData',[0 9]);
colormap(gray(256));
axis off;


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global im;
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename im
img=erase(filename,'.wav');
imgfilename=[img '.png'];
[cache,path]=uiputfile('*.png','Please input the name of picture to be saved',imgfilename);
if (cache)
    im_d=gray2ind(im*4+0.5,256);
    imwrite(flip(im_d),gray(256),[path '\' cache]);
    imgfilename=cache;
end
