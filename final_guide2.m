function varargout = final_guide2(varargin)
% FINAL_GUIDE2 MATLAB code for final_guide2.fig
%      FINAL_GUIDE2, by itself, creates a new FINAL_GUIDE2 or raises the existing
%      singleton*.
%
%      H = FINAL_GUIDE2 returns the handle to a new FINAL_GUIDE2 or the handle to
%      the existing singleton*.
%
%      FINAL_GUIDE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL_GUIDE2.M with the given input arguments.
%
%      FINAL_GUIDE2('Property','Value',...) creates a new FINAL_GUIDE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final_guide2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final_guide2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final_guide2

% Last Modified by GUIDE v2.5 09-May-2019 11:02:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final_guide2_OpeningFcn, ...
                   'gui_OutputFcn',  @final_guide2_OutputFcn, ...
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


% --- Executes just before final_guide2 is made visible.
function final_guide2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final_guide2 (see VARARGIN)

% Choose default command line output for final_guide2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes final_guide2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final_guide2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1. UPLOAD FILES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Upload the MRI image in DICOM or NIfTI format

% --- Executes on button press in Upload_MRI.
function Upload_MRI_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_MRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


clc

%folders directory information
dir=pwd;  %GUIDE_final 
inp_dir=[dir,'/input']; %input 
DicToNii_dir=[dir,'/dicom2nii']; % Dicom to NIfTI converter function

opt_MRI=get(handles.painel1,'SelectedObject')
x_MRI=get(opt_MRI,'String')



if x_MRI=='NIfTI' %If the MRI image has NIfTI format
    [filename, pathname] = uigetfile('*.nii?, ?Pick the file');  %Chose the file
    copyfile([pathname, filename], inp_dir) %Copy the file to the input folder
    cd(inp_dir) %change the directory
    movefile(filename,'MRI.nii.gz') %Rename the MRI input image to 'MRI.nii.gz'
    cd(dir) %change the directory
else %If the MRI image has DICOM format
    [filename, pathname] = uigetfile('*.dcm?, ?Pick the file'); %Chose the file
    copyfile([pathname, filename], DicToNii_dir) %Copy the file to the converter function folder
    cd(DicToNii_dir) %change the directory
    dicm2nii(filename,DicToNii_dir,'nii.gz') %convert to NIfTI format
    [filename, pathname] = uigetfile('*.nii?, ?Pick the file'); %pick the converted file
     movefile(filename,'MRI.nii.gz') %rename the MRI input image to 'MRI.nii.gz'
     movefile([DicToNii_dir,'/MRI.nii.gz'],[inp_dir,'/MRI.nii.gz']) %copy the file to the input folder
     cd(dir)
end

   

    




%Upload the CT image in DICOM or NIfTI format

% --- Executes on button press in Upload_CT.
function Upload_CT_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_CT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Upl
clc

%directory information
dir=pwd;  %GUIDE_final directory
inp_dir=[dir,'/input']; %input directory
DicToNii_dir=[dir,'/dicom2nii']; % Dicom to NIfTI converter function directory

opt_CT=get(handles.painel2,'SelectedObject')
x_CT=get(opt_CT,'String')



if x_CT=='NIfTI' %If the MRI image has NIfTI format
    [filename, pathname] = uigetfile('*.nii?, ?Pick the file');  %Chose the file
    copyfile([pathname, filename], inp_dir) %Copy the file to the input folder
    cd(inp_dir) %change the directory
    movefile(filename,'CT.nii.gz') %Rename the MRI input image to 'MRI.nii.gz'
    cd(dir) %change the directory
else %If the MRI image has DICOM format
    [filename, pathname] = uigetfile('*.dcm?, ?Pick the file'); %Chose the file
    copyfile([pathname, filename], DicToNii_dir) %Copy the file to the converter function folder
    cd(DicToNii_dir) %change the directory
    dicm2nii(filename,DicToNii_dir,'nii.gz') %convert to NIfTI format
    [filename, pathname] = uigetfile('*.nii?, ?Pick the file'); %pick the converted file
     movefile(filename,'CT.nii.gz') %rename the MRI input image to 'MRI.nii.gz'
     movefile([DicToNii_dir,'/CT.nii.gz'],[inp_dir,'/CT.nii.gz']) %copy the file to the input folder
     cd(dir)
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2. BRAIN EXTRACTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in go_BET.
function go_BET_Callback(hObject, eventdata, handles)
% hObject    handle to go_BET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc

%direcory information
dir=pwd; %GUI
bet_dir=[dir,'/do_BET']; %BET

fit=get(handles.slider1_FIT,'Value'); %fractinal intensity threshold value
FIT=num2str(fit);

MRI_path=[dir,'/input/MRI.nii.gz']; %MRI path name

cd(bet_dir) %change directory

%open, write and close a script file for brain extraction
fileID=fopen('bet_script.sh','w');
str_aux = ['#!/bin/sh\nbet ',MRI_path,' /Users/lopeselodie/Desktop/',... 
    'GUIDE_final2/do_BET/MRI_brain -f ',  FIT,' -g 0 -m'];
fprintf(fileID,str_aux);
fclose(fileID);

%run the sh file
system('sh /Users/lopeselodie/Desktop/GUIDE_final2/do_BET/bet_script.sh')  


cd(dir) %change the directory
display('ready')








% --- Executes on slider movement.
function slider1_FIT_Callback(hObject, eventdata, handles)
% hObject    handle to slider1_FIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
maxSliderValue1 = get(handles.slider1_FIT, 'Max');
minSliderValue1 = get(handles.slider1_FIT, 'Min');
theRange1 = maxSliderValue1 - minSliderValue1;
steps1 = [1/theRange1, 1/theRange1];
set(handles.slider1_FIT, 'SliderStep', steps1);
val_FIT=hObject.Value;
val_FIT=roundn (val_FIT, -1);
val_FIT=num2str(val_FIT);
set(handles.FIT_value,'String',val_FIT);

% --- Executes during object creation, after setting all properties.
function slider1_FIT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1_FIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3. CO-REGISTRATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in go_CR.
function go_CR_Callback(hObject, eventdata, handles)
% hObject    handle to go_CR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc

%directory information
dir=pwd;
cr_dir=[dir,'/registration'];
inp_dir=[dir,'/input'];
bet_dir=[dir,'/do_BET'];
fsldir='/usr/local/fsl'; %%%%%% CHANGE HERE

cd(cr_dir) %change directory

%Creation of a txt file with the directory information
fileID=fopen('dir_info.txt','w');
str_aux = ['cr_dir="',cr_dir ,'"\ninp_dir="', inp_dir, '"\nbet_dir="',bet_dir, '"\nfsldir="',fsldir,'"'];
fprintf(fileID,str_aux);
fclose(fileID);

opt_CR=get(handles.painel_CR,'SelectedObject') %Chose the type of registration
x_CR=get(opt_CR,'String')

%cd(cr_dir)

system(['sh CR_',x_CR,'.sh']) %Run the shell script for registration files


cd(dir) %change directory
display('Ready')
    
    
    
    
    
    
function Thr_Callback(hObject, eventdata, handles)
% hObject    handle to Thr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Thr as text
%        str2double(get(hObject,'String')) returns contents of Thr as a double


% --- Executes during object creation, after setting all properties.
function Thr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Thr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4. ELECTRODES SEGMENTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in do_seg.
function do_seg_Callback(hObject, eventdata, handles)
% hObject    handle to do_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc

%directory information
dir=pwd;
cr_dir=[dir,'/registration'];
inp_dir=[dir,'/input'];
bet_dir=[dir,'/do_BET'];
seg_dir=[dir,'/segmentation'];
out_dir=[dir,'/output'];


IT=get(handles.Thr,'String'); %intensity threshold value



cd(seg_dir) %change directory

%open, write, close and run the shell script for fslmaths threshold
fileID=fopen('intensity_threshold.sh','w');
str_aux = ['#!/bin/sh\nfslmaths ',cr_dir,'/MRI_CT.nii.gz -thr ', IT , ' -bin ',seg_dir,'/CT_seg.nii.gz'];
fprintf(fileID,str_aux);
fclose(fileID);
system('sh intensity_threshold.sh')


%open, write, close and run the shell script for fslmaths multiplication
fileID=fopen('multiplication.sh','w');
str_aux = ['#!/bin/sh\nfslmaths ',bet_dir,'/MRI_brain.nii.gz -mul ', seg_dir,'/CT_seg.nii.gz ', seg_dir,'/CT_seg_mul.nii.gz'];
fprintf(fileID,str_aux);
fclose(fileID);
system('sh multiplication.sh')

cd(dir) %change directory 

display('Ready')

%copy the output files to the output folder
copyfile([bet_dir,'/MRI_brain.nii.gz'], out_dir) 
copyfile([seg_dir,'/CT_seg_mul.nii.gz'],out_dir)


% --- Executes on button press in do_plot.
function do_plot_Callback(hObject, eventdata, handles)
% hObject    handle to do_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
dir=pwd;
cr_dir=[dir,'/registration'];
inp_dir=[dir,'/input'];
bet_dir=[dir,'/do_BET'];
seg_dir=[dir,'/segmentation'];
out_dir=[dir,'/output'];



opt_plot=get(handles.what_plot,'SelectedObject')
xplot=get(opt_plot,'String')

fileID=fopen('go_plot.sh','w');

if xplot=='Image1'
    str_aux=['#!/bin/sh\nfsleyes ',inp_dir,'/MRI.nii.gz ',inp_dir,'/CT.nii.gz'];
elseif xplot=='Image2'
    str_aux=['#!/bin/sh\nfsleyes ',inp_dir,'/MRI.nii.gz ',bet_dir,'/MRI_brain.nii.gz'];
elseif xplot=='Image3'
    str_aux=['#!/bin/sh\nfsleyes ',cr_dir,'/MRI_CT.nii.gz '];
else
    str_aux=['#!/bin/sh\nfsleyes ',cr_dir,'/MRI_CT.nii.gz ',seg_dir,'/CT_seg_mul.nii.gz'];
end
    
    

fprintf(fileID,str_aux);
fclose(fileID);
system('sh go_plot.sh')

copyfile([bet_dir,'/MRI_brain.nii.gz'], out_dir) %
copyfile([seg_dir,'/CT_seg_mul.nii.gz'],out_dir)






    


%%%%%%%%%%%%%%%%%%%%%%%%%%%% 5. VISUALIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in FP.
function FP_Callback(hObject, eventdata, handles)
% hObject    handle to FP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc

%Folders directory information
dir=pwd; %GUI 
cr_dir=[dir,'/registration']; %Co-registration 
inp_dir=[dir,'/input']; %Input
bet_dir=[dir,'/do_BET'];  %BET .
seg_dir=[dir,'/segmentation']; %Segmentation 
out_dir=[dir,'/output']; %Output 


%open, write, clode and run the visualization sh file
fileID=fopen('go_plot.sh','w');
str_aux = ['#!/bin/sh\nfsleyes ',seg_dir,'/CT_seg_mul.nii.gz ',bet_dir,'/MRI_brain.nii.gz'];
fprintf(fileID,str_aux);
fclose(fileID);
system('sh go_plot.sh')
