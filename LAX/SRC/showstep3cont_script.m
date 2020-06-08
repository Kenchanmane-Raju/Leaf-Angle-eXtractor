%showstep3cont_script.m
%   This script shows the objects from step 3, as well as displaying the
%   initial cropped frame

% load handles
handles = guidata(handles.output);

% update instruction text
set(handles.instruction_text,'string',handles.step2b_instruction);

% Run the initial crop frame function
[handles.initialframe, handles.stalk_x, handles.stalk_y] = initialcrop_func(handles.initialframe_num, handles.img_array, handles.img_cropwidth, handles.img_cropheight);
axes(handles.axes1);
imshow(handles.initialframe);

[img_ymax,img_xmax,~] = size(handles.img_array{handles.initialframe_num});

% set crop slider parameters
set(handles.cropwidth_slider,'Value',handles.img_cropwidth,'Min',1,'Max',img_xmax,'SliderStep',[5/img_xmax 25/img_xmax]);
set(handles.cropheight_slider,'Value',handles.img_cropheight,'Min',1,'Max',img_ymax,'SliderStep',[5/img_ymax 25/img_ymax]);

% show objects from the crop-frame step
set(handles.continue3_pushbutton,'Visible','on');
set(handles.undo3_pushbutton,'Visible','on');
set(handles.instruction_text,'string',handles.step3_instruction);
set(handles.instruction_text,'Visible','on');
set(handles.cropwidth_slider,'Visible','on');
set(handles.cropheight_slider,'Visible','on');

% update handles
guidata(handles.output,handles);

