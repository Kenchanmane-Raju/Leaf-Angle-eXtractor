%showstep3_script.m
%   This script shows the objects from step 3, as well as displaying the
%   initial cropped frame

% update instruction text
set(handles.instruction_text,'string',handles.step2b_instruction);

% show objects from the crop-frame step
set(handles.continue3_pushbutton,'Visible','on');
set(handles.undo3_pushbutton,'Visible','on');
set(handles.instruction_text,'string',handles.step3_instruction);
set(handles.instruction_text,'Visible','on');
set(handles.cropwidth_slider,'Visible','on');
set(handles.cropheight_slider,'Visible','on');

% show rgb of initial image
axes(handles.axes1);
imshow(handles.initialframe);