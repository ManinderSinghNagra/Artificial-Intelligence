function varargout = code_final(varargin)
% CODE_FINAL MATLAB code for code_final.fig
%      CODE_FINAL, by itself, creates a new CODE_FINAL or raises the existing
%      singleton*.
%
%      H = CODE_FINAL returns the handle to a new CODE_FINAL or the handle to
%      the existing singleton*.
%
%      CODE_FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CODE_FINAL.M with the given input arguments.
%
%      CODE_FINAL('Property','Value',...) creates a new CODE_FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before code_final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to code_final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help code_final

% Last Modified by GUIDE v2.5 29-Aug-2015 15:27:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @code_final_OpeningFcn, ...
                   'gui_OutputFcn',  @code_final_OutputFcn, ...
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


% --- Executes just before code_final is made visible.
function code_final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to code_final (see VARARGIN)

% Choose default command line output for code_final
handles.output = hObject;
set(handles.pushbutton5,'visible','off')
set(handles.text3,'visible','off')
set(handles.edit2,'visible','off')
set(handles.pushbutton3,'visible','off')
set(handles.pushbutton4,'visible','off')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes code_final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = code_final_OutputFcn(hObject, eventdata, handles) 
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
clc
clear all
warning('off')
match_template = [];

msgbox('Initial Command Executed Successfully')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton5,'visible','on')
set(handles.text3,'visible','on')
set(handles.edit2,'visible','on')



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% ====== MATCHING =========== 
% usr = inputdlg('How Many Images you want to Test ?');
% usr = str2num(cell2mat(usr));

for varr = 1:1
%%--  Read input image

[aa,bb] =  uigetfile('*.jpg','SELECT IMAGE TO MATCH');
cc  =  strcat(bb,aa);
img = imread(cc);
img = imresize(img,[800 600]);
axes(handles.axes1),imshow(img)
pause(.2)

%%----Create Detector

stdsize = 176;
thresholdParts = 1;
thresholdFace = 1;
 
nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];

detector.stdsize = stdsize;
detector.detector = cell(5,1);

for k=1:4
 minSize = int32([stdsize/5 stdsize/5]);
 minSize = [max(minSize(1),mins(k,1)), max(minSize(2),mins(k,2))];
 detector.detector{k} = vision.CascadeObjectDetector(char(nameDetector(k)), 'MergeThreshold', thresholdParts, 'MinSize', minSize);
 ext_sep{k} = step(detector.detector{k}, img);
end

detector.detector{5} = vision.CascadeObjectDetector('FrontalFaceCART', 'MergeThreshold', thresholdFace);
ext_sep{5} = step(detector.detector{5}, img);

%%-----Detect Parts

thick=4;
X = img;
% Detect parts
bbox1 = step(detector.detector{1}, X);
bbox2 = step(detector.detector{2}, X);
bbox3 = step(detector.detector{3}, X);
bbox4 = step(detector.detector{4}, X);
bbox5 = step(detector.detector{5}, X);
bbox = step(detector.detector{5}, X);

bbsize = size(bbox);
partsNum = zeros(size(bbox,1),1);
save data1 bbox

%%%%%%%%%%%%%%%%%%%%%%% detect parts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];

stdsize = detector.stdsize;

for k=1:4
 if( k == 1 )
  region = [1,int32(stdsize*2/3); 1, int32(stdsize*2/3)];
 save data2 region
 elseif( k == 2 )
  region = [int32(stdsize/3),stdsize; 1, int32(stdsize*2/3)];
 save data3 region
 elseif( k == 3 )
  region = [1,stdsize; int32(stdsize/3), stdsize];
  save data4 region
 elseif( k == 4 )
  region = [int32(stdsize/5),int32(stdsize*4/5); int32(stdsize/3),stdsize];
  save data5 region
 else
  region = [1,stdsize;1,stdsize];
 end

 bb = zeros(bbsize);
 for i=1:size(bbox,1)
  XX = X(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
  XX = imresize(XX,[stdsize, stdsize]);
  XX = XX(region(2,1):region(2,2),region(1,1):region(1,2),:);
  
  b = step(detector.detector{k},XX);
  ext_pos{i,1} = b; 
  if( size(b,1) > 0 )
   partsNum(i) = partsNum(i) + 1;
   
   if( k == 1 )
    b = sortrows(b,1);
   elseif( k == 2 )
    b = flipud(sortrows(b,1));
   elseif( k == 3 )
    b = flipud(sortrows(b,2));
   elseif( k == 4 )
    b = flipud(sortrows(b,3));
   end
   
   ratio = double(bbox(i,3)) / double(stdsize);
   b(1,1) = int32( ( b(1,1)-1 + region(1,1)-1 ) * ratio + 0.5 ) + bbox(i,1);
   b(1,2) = int32( ( b(1,2)-1 + region(2,1)-1 ) * ratio + 0.5 ) + bbox(i,2);
   b(1,3) = int32( b(1,3) * ratio + 0.5 );
   b(1,4) = int32( b(1,4) * ratio + 0.5 );
   
   bb(i,:) = b(1,:);
  end
 end
 bbox = [bbox,bb];
 save rr bbox
 p = ( sum(bb') == 0 );
 bb(p,:) = [];
end


%%%%%%%%%%%%%%%%%%%%%%% draw faces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bbox = [bbox,partsNum];
bbox(partsNum<=2,:)=[];
 if(isempty(bbox==1) ==1)
    msgbox('Not a Human Expression')
    break
 end

if( thick >= 0 )
 t = (thick-1)/2;
 t0 = -int32(ceil(t));
 t1 = int32(floor(t));
else
 t0 = 0;
 t1 = 0;
end

bbX = X;
boxColor = [[0,0,0]; [0,0,255]; [0,0,255]; [255,0,0]; [0,255,0]; ];
for k=5:-1:1
 shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',boxColor(k,:)); 
 for i=t0:t1
  bb = int32(bbox(:,(k-1)*4+1:k*4));
  bb(:,1:2) = bb(:,1:2)-i;
  bb(:,3:4) = bb(:,3:4)+i*2;
  save tst bb shapeInserter
  bbX = step(shapeInserter, bbX, bb);
 end

end
save yy bbX

%%---%%%%%%% Faces %%%%%%%%%%%%%%%%%%%%%%
if( nargout > 2 )
 faces = cell(size(bbox,1),1);
 bbfaces = cell(size(bbox,1),1);
 for i=1:size(bbox,1)
  faces{i,1} = X(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
  bbfaces{i,1} = bbX(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
 
 end
end

%%----Show combined Result
axes(handles.axes2),imshow(bbX);

global bbfaces
 for i=1:size(bbfaces,1)
%  figure;imshow(bbfaces{i});
end


%%---- Seprate Each Section from Image
LBP =[];
% load rr
  
for i=1:size(bbfaces,1)
% subplot(2,3,1),imshow(bbfaces{i});
end


New_img1  = img(bbox(2):bbox(2)+bbox(4),bbox(1):bbox(1)+bbox(3),:);
axes(handles.axes3),imshow(New_img1)
title('FACE SEGMENTED')

New_img2  = img(bbox(6):bbox(6)+bbox(8),bbox(5):bbox(5)+bbox(7),:);
axes(handles.axes4),imshow(New_img2)
title('LEFT EYE SEGMENTED')

New_img3  = img(bbox(10):bbox(10)+bbox(12),bbox(9):bbox(9)+bbox(11),:);
axes(handles.axes5),imshow(New_img3)
title('RIGHT EYE SEGMENTED')

New_img4  = img(bbox(14):bbox(14)+bbox(16),bbox(13):bbox(13)+bbox(15),:);
axes(handles.axes6),imshow(New_img4)
title('MOUTH SEGMENTED')

New_img5  = img(bbox(18):bbox(18)+bbox(20),bbox(17):bbox(17)+bbox(19),:);
axes(handles.axes7),imshow(New_img5)
title('NOSE SEGMENTED')


%%---------------- LBP for Face -------------
LBP =[];
    input_image = New_img1;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%----LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z1= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img1)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%       
%       subplot(2,3,6),plot(z1)

%        axes(handles.axes8),imshow([])
%        axes(handles.axes8),imshow(uint8(LBP))
%        axes(handles.axes13),plot(z1)
        save rr1 LBP
     axes(handles.axes8),imshow(uint8(LBP))
     pause(.2)
     axes(handles.axes13),plot(z1)
      pause(.2)
      %%---------------- LBP for LEFT EYE -------------
LBP = [];
    input_image = New_img2;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%-----LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z2= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img2)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%       
%       subplot(2,3,6),plot(z2)
save rr1 LBP
       axes(handles.axes9),imshow(uint8(LBP))
       pause(.2)
       axes(handles.axes14),plot(z2)
       pause(.2)

      %%---------------- LBP for RIGHT EYE -------------
   LBP =[];
    input_image = New_img3;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%------LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z3= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img3)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%       
%       subplot(2,3,6),plot(z3)

       axes(handles.axes10),imshow(uint8(LBP))
       pause(.2)
       axes(handles.axes15),plot(z3)
       
       pause(.2)
       
      %%---------------- LBP for MOUTH -------------
    LBP =[];
    input_image = New_img4;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%------LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z4= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img4)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%       
%       subplot(2,3,6),plot(z4)
      
      axes(handles.axes11),imshow(uint8(LBP))
      pause(.2)
       axes(handles.axes16),plot(z4)
       pause(.2)
       

      %%---------------- LBP for NOSE -------------
    LBP = [];
    input_image = New_img5;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%------LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z5= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img5)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%       
%       subplot(2,3,6),plot(z5)
      
       axes(handles.axes12),imshow(uint8(LBP))
       pause(.2)
       axes(handles.axes17),plot(z5)
       pause(.2)
       
      match_template_modified = {z1 z2 z3 z4 z5};
      
      
      %%------Matching 
%     out1=[];
%     out2=[];
%     out3=[];
%     out4=[];
%       for k =1:4
%       
% c1 = corr2(cell2mat(match_template{1,k}(2)),cell2mat(match_template_modified(1)));
% c2 = corr2(cell2mat(match_template{1,k}(2)),cell2mat(match_template_modified(2)));
% c3 = corr2(cell2mat(match_template{1,k}(2)),cell2mat(match_template_modified(3)));
% c4 = corr2(cell2mat(match_template{1,k}(2)),cell2mat(match_template_modified(4)));
% 
% out1 = [out1 c1];
% out2 = [out2 c1];
% out3 = [out3 c1];
% out4 = [out4 c1];
% [r,t]= max([sum(out1) sum(out2) sum(out3) sum(out4)]);
% if(t==1)
%     out = out1;
% elseif(t==2)   
%         out = out2;
% elseif(t==2)  
%         out = out3;
% elseif(t==2)  
%         out = out4;
% end
global val match_template c1 pos
save tsst match_template match_template_modified
for k =1:4
c1(1,k) = corr2(match_template{1,k}{1,5},match_template_modified{1,5});
end
out =c1;
pos = find(out == max(out));
      
     save datafile match_template match_template_modified c1
    
end
msgbox('Testing Completed')
set(handles.pushbutton4,'visible','on')

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pos
if(pos==1)
   msgbox('PERSON BEHAVIOUR IS NORMAL')
   
elseif(pos==2)
    msgbox('PERSON BEHAVIOUR IS HAPPY')
    
elseif(pos==3)
    msgbox('PERSON BEHAVIOUR IS ANGRY')
    
elseif(pos==4)
    msgbox('PERSON BEHAVIOUR IS SAD')
    
end
    


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global val
val = get(handles.edit2,'String');
val = str2num(val);
for loop_cntrl = 1:val
   combine = strcat(num2str(loop_cntrl),'.jpg');
   param =  imread(combine);
% [aa,bb] =  uigetfile('*.jpg');
% cc  =  strcat(bb,aa);
img = param;
% [aa,bb] =  uigetfile('*.jpg');
% cc  =  strcat(bb,aa);
% img = imread(cc);
 img = imresize(img,[800 600]);
axes(handles.axes1),imshow(img)
pause(.2)
%% Create Detector

stdsize = 176;
thresholdParts = 1;
thresholdFace = 1;
 
nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];

detector.stdsize = stdsize;
detector.detector = cell(5,1);

for k=1:4
 minSize = int32([stdsize/5 stdsize/5]);
 minSize = [max(minSize(1),mins(k,1)), max(minSize(2),mins(k,2))];
 detector.detector{k} = vision.CascadeObjectDetector(char(nameDetector(k)), 'MergeThreshold', thresholdParts, 'MinSize', minSize);
 ext_sep{k} = step(detector.detector{k}, img);
end

detector.detector{5} = vision.CascadeObjectDetector('FrontalFaceCART', 'MergeThreshold', thresholdFace);
ext_sep{5} = step(detector.detector{5}, img);

%% Detect Parts

thick=4;
X = img;
% Detect parts
bbox1 = step(detector.detector{1}, X);
bbox2 = step(detector.detector{2}, X);
bbox3 = step(detector.detector{3}, X);
bbox4 = step(detector.detector{4}, X);
bbox5 = step(detector.detector{5}, X);
bbox = step(detector.detector{5}, X);

bbsize = size(bbox);
partsNum = zeros(size(bbox,1),1);
save data1 bbox
%%%%%%%%%%%%%%%%%%%%%%% detect parts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];

stdsize = detector.stdsize;

for k=1:4
 if( k == 1 )
  region = [1,int32(stdsize*2/3); 1, int32(stdsize*2/3)];
 save data2 region
 elseif( k == 2 )
  region = [int32(stdsize/3),stdsize; 1, int32(stdsize*2/3)];
 save data3 region
 elseif( k == 3 )
  region = [1,stdsize; int32(stdsize/3), stdsize];
  save data4 region
 elseif( k == 4 )
  region = [int32(stdsize/5),int32(stdsize*4/5); int32(stdsize/3),stdsize];
  save data5 region
 else
  region = [1,stdsize;1,stdsize];
 end

 bb = zeros(bbsize);
 for i=1:size(bbox,1)
  XX = X(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
  XX = imresize(XX,[stdsize, stdsize]);
  XX = XX(region(2,1):region(2,2),region(1,1):region(1,2),:);
  
  b = step(detector.detector{k},XX);
  ext_pos{i,1} = b; 
  if( size(b,1) > 0 )
   partsNum(i) = partsNum(i) + 1;
   
   if( k == 1 )
    b = sortrows(b,1);
   elseif( k == 2 )
    b = flipud(sortrows(b,1));
   elseif( k == 3 )
    b = flipud(sortrows(b,2));
   elseif( k == 4 )
    b = flipud(sortrows(b,3));
   end
   
   ratio = double(bbox(i,3)) / double(stdsize);
   b(1,1) = int32( ( b(1,1)-1 + region(1,1)-1 ) * ratio + 0.5 ) + bbox(i,1);
   b(1,2) = int32( ( b(1,2)-1 + region(2,1)-1 ) * ratio + 0.5 ) + bbox(i,2);
   b(1,3) = int32( b(1,3) * ratio + 0.5 );
   b(1,4) = int32( b(1,4) * ratio + 0.5 );
   
   bb(i,:) = b(1,:);
  end
 end
 bbox = [bbox,bb];
 save rr bbox
 p = ( sum(bb') == 0 );
 bb(p,:) = [];
end


%%%%%%%%%%%%%%%%%%%%%%% draw faces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bbox = [bbox,partsNum];
bbox(partsNum<=2,:)=[];

if(isempty(bbox==1) ==1)
    msgbox('Not a Human Expression')
    break
end

if( thick >= 0 )
 t = (thick-1)/2;
 t0 = -int32(ceil(t));
 t1 = int32(floor(t));
else
 t0 = 0;
 t1 = 0;
end

bbX = X;
boxColor = [[0,0,0]; [0,0,255]; [0,0,255]; [255,0,0]; [0,255,0]; ];
for k=5:-1:1
 shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',boxColor(k,:)); 
 for i=t0:t1
  bb = int32(bbox(:,(k-1)*4+1:k*4));
  bb(:,1:2) = bb(:,1:2)-i;
  bb(:,3:4) = bb(:,3:4)+i*2;
  save tst bb shapeInserter
  bbX = step(shapeInserter, bbX, bb);
 end
 
end
save yy bbX

%%%%%%%%%%%%%%%%%%%%%%% Faces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if( nargout > 2 )
 faces = cell(size(bbox,1),1);
 bbfaces = cell(size(bbox,1),1);
 for i=1:size(bbox,1)
  faces{i,1} = X(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
  bbfaces{i,1} = bbX(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
 
 end
end

%% Show combined Result
axes(handles.axes2),imshow(bbX);
pause(.2)

global bbfaces
 for i=1:size(bbfaces,1)
%  figure;imshow(bbfaces{i});
end


%% Seprate Each Section from Image

% load rr
  
for i=1:size(bbfaces,1)
% figure,imshow(bbfaces{i});
end

New_img1  = img(bbox(2):bbox(2)+bbox(4),bbox(1):bbox(1)+bbox(3),:);
axes(handles.axes3),imshow(New_img1)
title('FACE SEGMENTED')
pause(.2)

New_img2  = img(bbox(6):bbox(6)+bbox(8),bbox(5):bbox(5)+bbox(7),:);
axes(handles.axes4),imshow(New_img2)
title('LEFT EYE SEGMENTED')
pause(.2)

New_img3  = img(bbox(10):bbox(10)+bbox(12),bbox(9):bbox(9)+bbox(11),:);
axes(handles.axes5),imshow(New_img3)
title('RIGHT EYE SEGMENTED')
pause(.2)

New_img4  = img(bbox(14):bbox(14)+bbox(16),bbox(13):bbox(13)+bbox(15),:);
axes(handles.axes6),imshow(New_img4)
title('MOUTH SEGMENTED')
pause(.2)

New_img5  = img(bbox(18):bbox(18)+bbox(20),bbox(17):bbox(17)+bbox(19),:);
axes(handles.axes7),imshow(New_img5)
title('NOSE SEGMENTED')
pause(.2)

%%---------------- LBP for Face -------------
LBP =[];
    input_image = New_img1;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%---LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z1= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img1)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
      
%       axes(handles.axes8),imshow([])
%       imshow(LBP,[]);
      axes(handles.axes8),imshow(uint8(LBP))
      pause(.2)
%       subplot(2,3,6),plot(z1)
     axes(handles.axes13), plot(z1)
     pause(.2)
      
      %%--------------- LBP for LEFT EYE -------------
LBP = [];
    input_image = New_img2;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%--- LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z2= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img2)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%       
%        axes(handles.axes9),imshow([])
%       imshow(LBP,[]);
      
%       subplot(2,3,6),plot(z2)

      axes(handles.axes9),imshow(uint8(LBP))
      pause(.2)
      axes(handles.axes14), plot(z2)
      pause(.2)
      
      %%--------------- LBP for RIGHT EYE -------------
   LBP =[];
    input_image = New_img3;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%-- LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z3= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img3)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%       
%       
%       subplot(2,3,6),plot(z3)
% axes(handles.axes10),imshow(uint8(LBP))
%       axes(handles.axes10),imshow(LBP,[]);
      axes(handles.axes10),imshow(uint8(LBP))
      pause(.2)
      axes(handles.axes15),plot(z3)
      pause(.2)
      
      %%--------------- LBP for MOUTH -------------
    LBP =[];
    input_image = New_img4;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%-- LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z4= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     
%       subplot(2,3,[2 5]),imshow(New_img4)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%            
%       subplot(2,3,6),plot(z4)

   axes(handles.axes11),imshow(uint8(LBP))
   pause(.2)
      axes(handles.axes16),plot(z4)
   pause(.2)
      
      %%---------------- LBP for NOSE -------------
    LBP = [];
    input_image = New_img5;

        disp('Feature Extraction using LBP............')
    
img_part=[];

ac=[];

ac1  = [] ;

i1 = 1;

j1 = 1;

 I2 =input_image;

    w=size( input_image,1);     

    h=size( input_image,2);  
    
    %%-- LBP LOGIC
    
    for i=2:w-1   
      for j=2:h-1    
         J0=I2(i,j);   
          I3(i-1,j-1)=I2(i-1,j-1)>J0;  
            I3(i-1,j)=I2(i-1,j)>J0;   
          I3(i-1,j+1)=I2(i-1,j+1)>J0;  
            I3(i,j+1)=I2(i,j+1)>J0;     
          I3(i+1,j+1)=I2(i+1,j+1)>J0;    
            I3(i+1,j)=I2(i+1,j)>J0;      
          I3(i+1,j-1)=I2(i+1,j-1)>J0;     
            I3(i,j-1)=I2(i,j-1)>J0;       
          LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;          
       end  
    end 
     z5= imhist(uint8(LBP));

% figure,
%       for i=1:size(bbfaces,1)
%       subplot(2,3,[1 4]),imshow(bbfaces{i});
%       end
%     pause(.2)
%       subplot(2,3,[2 5]),imshow(New_img5)
%       
%       subplot(2,3,3),imshow([])
%       imshow(LBP,[]);
%       
%        
%       
%       subplot(2,3,6),plot(z5)

   axes(handles.axes12),imshow(uint8(LBP))
   pause(.2)
   axes(handles.axes17),plot(z5)
      pause(.2)
      
      global match_template
      match_template{1,loop_cntrl}  = {z1 z2 z3 z4 z5};
end
set(handles.pushbutton3,'visible','on')
