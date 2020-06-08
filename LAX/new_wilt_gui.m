 function varargout = new_wilt_gui(varargin)
% NEW_WILT_GUI MATLAB code for new_wilt_gui.fig
%      NEW_WILT_GUI, by itself, creates a new NEW_WILT_GUI or raises the existing
%      singleton*.
%
%      H = NEW_WILT_GUI returns the handle to a new NEW_WILT_GUI or the handle to
%      the existing singleton*.
%
%      NEW_WILT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEW_WILT_GUI.M with the given input arguments.
%
%      NEW_WILT_GUI('Property','Value',...) creates a new NEW_WILT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before new_wilt_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to new_wilt_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help new_wilt_gui

% Last Modified by GUIDE v2.5 12-Jul-2014 19:25:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @new_wilt_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @new_wilt_gui_OutputFcn, ...
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


% --- Executes just before new_wilt_gui is made visible.
function new_wilt_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to new_wilt_gui (see VARARGIN)

% Choose default command line output for new_wilt_gui
handles.output = hObject;

% add source files to path
addpath(genpath('SRC'));

% load ISU logo
isu_logo = sprintf('ISU_logo.png');
axes(handles.axes2);
imshow(imread(isu_logo));

% make visible the objects from Welcome Screen
showwelcome_script;
set(handles.header_text,'Visible','on');

% Set the instruction strings for each of the steps
handles.step2a_instruction = 'Move Slider to Select Start Time for Analysis';
handles.step2b_instruction = 'Select Bottom Center of Plant of Interest';
handles.step3_instruction = 'Adjust Width and Height Sliders to Capture Plant';
handles.step4a_instruction = {'Drag Rectangles Around Individual Leaves'};
handles.step4b_instruction = {'Ensure Rectangles DO NOT include stalk'};
handles.step5_instruction = 'Adjust Threshold Slider to Clearly Define Leaves';
handles.step6_instruction = 'Move Slider to Select Final Frame';
handles.step7_instruction = 'Adjust Threshold Slider to Clearly Define Leaves';
handles.step8_instruction = 'Press "Start Analysis" to Initialize Wilt Analysis';
handles.step9_instruction = 'Choose "Export Data" to save .csv file';

% set some default values that user will change during analysis
handles.initialframe_num = 1;       % default first frame
handles.img_cropwidth = 300;        % default crop width
handles.img_cropheight = 500;       % default crop height
handles.initialthreshold = 0.65;    % default initial threshold
handles.finalthreshold = 0.65;      % default final threshold
handles.invert_TF = 1;              % default invert image
handles.rgb_channel = 3;            % default RGB channel
handles.sharpenradius = 0.1;        % default sharpen radius

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes new_wilt_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = new_wilt_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in newproject_pushbutton.
function newproject_pushbutton_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% user selects timelapse images location
img_directory = uigetdir('','Select Timelapse Folder');

% img_array_func saves all images in user selected directory into a cell
% array 
handles.img_array = img_array_func(img_directory);

% hide welcome screen objects
hidewelcome_script;

% show initial frame selection objects [Advance to Step 2]
showstep2_script;

% update handles
guidata(handles.output,handles);


% --- Executes on slider movement.
function initialframe_slider_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% display frame as defined by slider
handles.initialframe_num = round(get(hObject,'Value'));    % get slider value (framecount)
handles.initialframe = handles.img_array{handles.initialframe_num};
axes(handles.axes1);
imshow(handles.initialframe);   % display frame

% update handles
guidata(handles.output,handles);


% --- Executes during object creation, after setting all properties.
function initialframe_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initialframe_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in undo2_pushbutton.
function undo2_pushbutton_Callback(hObject, eventdata, handles)
% hide objects from the select-initial-frame step 
hidestep2_script;

% make visible the objects from Welcome Screen
showwelcome_script;

% clear the image array
clearvars handles.img_array;


% --- Executes on button press in continue2_pushbutton.
function continue2_pushbutton_Callback(hObject, eventdata, handles)
% hide objects from select-initial-frame step
hidestep2cont_script;

% show objects from select-plant step [Advance to Step 3]
showstep3cont_script;
 

% --- Executes on slider movement.
function cropheight_slider_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% read slider value as crop height
handles.img_cropheight = round(get(hObject,'Value'));

% run crop function
handles.initialframe = crop_func(handles.initialframe_num, handles.img_array, handles.img_cropwidth, handles.img_cropheight, handles.stalk_x, handles.stalk_y);

% update cropped image
axes(handles.axes1);
imshow(handles.initialframe);

% update handles
guidata(handles.output,handles);


% --- Executes during object creation, after setting all properties.
function cropheight_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cropheight_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function cropwidth_slider_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% read slider value as crop height
handles.img_cropwidth = round(get(hObject,'Value'));

% run crop function
handles.initialframe = crop_func(handles.initialframe_num, handles.img_array, handles.img_cropwidth, handles.img_cropheight, handles.stalk_x, handles.stalk_y);

% update cropped image
axes(handles.axes1);
imshow(handles.initialframe);

% update handles
guidata(handles.output,handles);


% --- Executes during object creation, after setting all properties.
function cropwidth_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cropwidth_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in continue3_pushbutton.
function continue3_pushbutton_Callback(hObject, eventdata, handles)
% Hide objects from select-initial-frame step, but retain current frame
hidestep3_script;

% Show objects from select-leaves step, 
showstep4_script;

% run select leaves script
selectleaves_script;


% --- Executes on button press in undo3_pushbutton.
function undo3_pushbutton_Callback(hObject, eventdata, handles)
% This button routes user to the select initial-frame-step

% hide objects from crop-frame step
hidestep3_script;

% show objects from select-initial-frame step
showstep2_script;


% --- Executes on button press in continue4_pushbutton.
function continue4_pushbutton_Callback(hObject, eventdata, handles)
% Hide objects from the select-leaves step
hidestep4_script;

%show the objects from the initial-thresholding step
showstep5_script;


% --- Executes on button press in undo4_pushbutton.
function undo4_pushbutton_Callback(hObject, eventdata, handles)
% Hide objects from the select-leaves step
hidestep4_script;

% show objects from crop-frame step
showstep3_script;


% --- Executes on button press in undo5_pushbutton.
function undo5_pushbutton_Callback(hObject, eventdata, handles)
% because this bring user back to the selecting leaves, we must first clear
% the array of rectangles around the leaves
clearvars handles.rect_array

% hide objects from the initial threshold step
hidestep5_script;

% show objects from the select leaves step
showstep4_script;

% run the select leaves script
selectleaves_script;


% --- Executes on button press in continue5_pushbutton.
function continue5_pushbutton_Callback(hObject, eventdata, handles)
% hide objects from the initial-threshold step
hidestep5_script;

% show objects from the select-final-frame step
showstep6_script;


% --- Executes on slider movement.
function initialthreshold_slider_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% find threshold as defined by slider
handles.initialthreshold = get(hObject,'Value');

% convert to string and update edit text field
initial_threshold_str = num2str(handles.initialthreshold);
set(handles.initialthreshold_edit,'String', initial_threshold_str);

% determine binary image based on threshold value
handles.initialframe_BW = threshold_func(handles.initialframe, handles.initialthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);

% update handles (to store threshold and BW image)
guidata(handles.output,handles);

% show binary image and rectangles
axes(handles.axes1);
imshow(handles.initialframe_BW);
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;


% --- Executes during object creation, after setting all properties.
function initialthreshold_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initialthreshold_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sharpenradius_slider_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% find sharpen as defined by slider in log form
handles.sharpenradius = get(hObject,'Value');

% determine binary image based on sharpen radius
handles.initialframe_BW = threshold_func(handles.initialframe, handles.initialthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);

% update handles (to store threshold and BW image)
guidata(handles.output,handles);

% show binary image and rectangles
axes(handles.axes1);
imshow(handles.initialframe_BW);
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;


% --- Executes during object creation, after setting all properties.
function sharpenradius_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sharpenradius_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function initialthreshold_edit_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% get user input from edit text
handles.initialthreshold = str2double( get(hObject,'String') );

% if value is outside of range default to max or min
if handles.initialthreshold > 1 
    handles.initialthreshold = 1;
    set(handles.initialthreshold_edit,'String','1');
elseif handles.initialthreshold < 0 
    handles.initialthreshold = 0;
    set(handles.initialthreshold_edit,'String','0');
end

% set slider to value input by user
set(handles.initialthreshold_slider,'Value',handles.initialthreshold)

% determine binary image based on threshold value
handles.initialframe_BW = threshold_func(handles.initialframe, handles.initialthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);

% update handles (to store threshold and BW image)
guidata(handles.output,handles);

% show binary image and rectangles
axes(handles.axes1);
imshow(handles.initialframe_BW);
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;


% --- Executes during object creation, after setting all properties.
function initialthreshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initialthreshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rgbchannel_popupmenu.
function rgbchannel_popupmenu_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% get value for color channel from pop-up-menu
handles.rgb_channel = get(hObject,'Value');

% determine binary image based on threshold value
handles.initialframe_BW = threshold_func(handles.initialframe, handles.initialthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);

% show binary image and rectangles
axes(handles.axes1);
imshow(handles.initialframe_BW);
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;

% update handles
guidata(handles.output,handles);


% --- Executes during object creation, after setting all properties.
function rgbchannel_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rgbchannel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function finalframe_slider_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% display frame as defined by slider
handles.finalframe_num = round(get(hObject,'Value'));   % get slider value (framecount)
handles.finalframe = crop_func(handles.finalframe_num, handles.img_array, handles.img_cropwidth ,handles.img_cropheight, handles.stalk_x, handles.stalk_y);  % crop frame
axes(handles.axes1);
imshow(handles.finalframe);   % display frame and rectangles
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;

% update handles
guidata(handles.output,handles);


% --- Executes during object creation, after setting all properties.
function finalframe_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to finalframe_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in undo6_pushbutton.
function undo6_pushbutton_Callback(hObject, eventdata, handles)
%hide step 6 objects
hidestep6_script;

%show the objects from the initial-thresholding step
showstep5_script;


% --- Executes on button press in continue6_pushbutton.
function continue6_pushbutton_Callback(hObject, eventdata, handles)
%hide step 6 objects
hidestep6_script;

%show step 7 objecst
showstep7_script;


% --- Executes on button press in undo7_pushbutton.
function undo7_pushbutton_Callback(hObject, eventdata, handles)
% hide objects from final-frame-threshold step
hidestep7_script;

%show objects from select-final-frame step
showstep6_script;


% --- Executes on button press in continue7_pushbutton.
function continue7_pushbutton_Callback(hObject, eventdata, handles)
% hide objects from final-frame-threshold step
hidestep7_script;

% show objects from start-wilt-analysis step
showstep8_script;


% --- Executes on slider movement.
function finalthreshold_slider_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% find threshold as defined by slider
handles.finalthreshold = get(hObject,'Value');

% convert to string and update edit text field
final_threshold_str = num2str(handles.finalthreshold);
set(handles.finalthreshold_edit,'String', final_threshold_str);

% determine binary image based on threshold value
handles.finalframe_BW = threshold_func(handles.finalframe, handles.finalthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);

% update handles (to store threshold and BW image)
guidata(handles.output,handles);

% show binary image and rectangles
axes(handles.axes1);
imshow(handles.finalframe_BW);
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;


% --- Executes during object creation, after setting all properties.
function finalthreshold_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to finalthreshold_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function finalthreshold_edit_Callback(hObject, eventdata, handles)
% get user input from edit text
handles.finalthreshold = str2double( get(hObject,'String') );

% if value is outside of range default to max or min
if handles.finalthreshold > 1 
    handles.finalthreshold = 1;
    set(handles.finalthreshold_edit,'String','1');
elseif handles.finalthreshold < 0 
    handles.finalthreshold = 0;
    set(handles.finalthreshold_edit,'String','0');
end

% set slider to value input by user
set(handles.finalthreshold_slider,'Value',handles.finalthreshold)

% determine binary image based on threshold value
handles.finalframe_BW = threshold_func(handles.finalframe, handles.finalthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);

% update handles (to store threshold and BW image)
guidata(handles.output,handles);

% show binary image and rectangles
axes(handles.axes1);
imshow(handles.finalframe_BW);
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;


% --- Executes during object creation, after setting all properties.
function finalthreshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to finalthreshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startanalysis_pushbutton.
function startanalysis_pushbutton_Callback(hObject, eventdata, handles)
% hide objects from the start-analysis step
hidestep8_script;

% load handles
handles = guidata(handles.output);

% perform wilt analysis
handles.wilt_data = wiltanalysis_func(handles.img_array, handles.rect_array, handles.initialframe_num, handles.finalframe_num, handles.initialthreshold, handles.finalthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF, handles.stalk_x, handles.stalk_y, handles.img_cropwidth, handles.img_cropheight);

% load post-analysis step
showstep9_script;

% update handles
guidata(handles.output,handles);


% --- Executes on button press in undo8_pushbutton.
function undo8_pushbutton_Callback(hObject, eventdata, handles)
% hide objects from the start-analysis step
hidestep8_script;

% show objects from final-threshold step
showstep7_script;


% --- Executes on button press in exportcsv_pushbutton.
function exportcsv_pushbutton_Callback(hObject, eventdata, handles)
[file,path] = uiputfile('*.csv','Save file');
csvwrite([path file], handles.wilt_data');

% --- Executes on button press in nextplant_pushbutton.
function nextplant_pushbutton_Callback(hObject, eventdata, handles)
% hide post-analysis step objects
hidestep9_script;

% clear variables
clearvars handles.rect_array handles.wilt_data
% NOTE: default slider vals are now updated to those selected by user for
% first plant under analysis.

% show select initial frame step
showstep2_script;


% --------------------------------------------------------------------
function about_pushtool_ClickedCallback(hObject, eventdata, handles)
% Build strings for the "about" messagebox
about_str1 = 'Dynamic Wilt Analysis Utility V1.00';
about_str2 = 'Last modified July 12, 2014';
about_str3 = 'Developers: Miles Adkins';
space = '';
about_str4 = 'This utility uses an input of time-lapse images, sorts the images by date created, and allows the user to crop an individual plant.';
about_str5 = 'The user then selects individual leaves for analysis. ';
about_str6 = 'Based on user input for threshold value the utility then determines the angle of the leaf with the stalk of the plant.';
about_str7 = 'The user has the ability to manipulate the output figure of wilt data or to export the data to a .csv file';

% msgbox is displayed when user clicks the question mark button
msgbox({about_str1 about_str2 about_str3 space space about_str4 space about_str5 about_str6 space about_str7},'About Dynamic Wilt Analysis Utility V1.00')

% --------------------------------------------------------------------
function new_pushtool_ClickedCallback(hObject, eventdata, handles)
% hide all possible objects
hideall_script;

% clear vars
clearvars handles.rect_array handles.wilt_data

% set default vars
defaultvars_script;

% show welcome screen objects
showwelcome_script;


% --- Executes on button press in invert_checkbox.
function invert_checkbox_Callback(hObject, eventdata, handles)
% load handles
handles = guidata(handles.output);

% get value from checkbox
handles.invert_TF = get(hObject,'Value');

% update binary image with invert criteria
handles.initialframe_BW = threshold_func(handles.initialframe, handles.initialthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);

% show binary image and rectangles
axes(handles.axes1);
imshow(handles.initialframe_BW);
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;

% update handles
guidata(handles.output,handles);
