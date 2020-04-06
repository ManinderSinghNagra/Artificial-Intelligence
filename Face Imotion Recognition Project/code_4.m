function varargout = code_4(varargin)
% CODE_4 MATLAB code for code_4.fig
%      CODE_4, by itself, creates a new CODE_4 or raises the existing
%      singleton*.
%
%      H = CODE_4 returns the handle to a new CODE_4 or the handle to
%      the existing singleton*.
%
%      CODE_4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CODE_4.M with the given input arguments.
%
%      CODE_4('Property','Value',...) creates a new CODE_4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before code_4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to code_4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help code_4

% Last Modified by GUIDE v2.5 01-Mar-2014 16:42:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @code_4_OpeningFcn, ...
                   'gui_OutputFcn',  @code_4_OutputFcn, ...
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


% --- Executes just before code_4 is made visible.
function code_4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to code_4 (see VARARGIN)

% Choose default command line output for code_4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes code_4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = code_4_OutputFcn(hObject, eventdata, handles) 
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
%%  Create a detector object.
faceDetector = vision.CascadeObjectDetector;

%% Read input image.
[aa,bb] =  uigetfile('*.jpg');
cc  =  strcat(bb,aa);
I = imread(cc);
axes(handles.axes1)
imshow(I)

%% Detect faces.
bboxes = step(faceDetector, I);


%% Display detected faces.
IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Deatected_Face');
axes(handles.axes2), imshow(IFaces), title('Detected faces');


%% ---- Detect Face Emotion -------

[rrow,ccol] = size(bboxes) ;

for ii = 1:rrow
    
eval(['Face_' num2str(ii) '_length' '=' 'bboxes(ii,3)'])
eval(['Face_' num2str(ii) '_width' '=' 'bboxes(ii,4)'])

eval(['Face_' num2str(ii) '_AREA' '=' '(bboxes(ii,3)*bboxes(ii,4))'])

pause(1);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
%% --- Camera operated Commands --

vid = videoinput('winvideo', 1, 'YUY2_640x480');
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 10;
start(vid)   % start camera

%% ------ LOGIC ----- 

% call face Detector
faceDetector = vision.CascadeObjectDetector();

% continous loop
for k=1:inf
data = getsnapshot(vid);
bbox = step(faceDetector, data);
imout = insertObjectAnnotation(data,'rectangle',bbox,'Detected_Face');
axes(handles.axes4)
imshow(imout);

end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
stop(vid)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exit
