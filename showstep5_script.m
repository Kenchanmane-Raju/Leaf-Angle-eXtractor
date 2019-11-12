%showstep5_script.m
%   This script shows the objects for step 5, intial frame thresholding

% load handles
handles = guidata(handles.output);

% Update the instruction text
set(handles.instruction_text,'String',handles.step5_instruction);

% set threshold slider parameters
set(handles.initialthreshold_slider,'Value',handles.initialthreshold);

% set sharpen radius slider parameters
set(handles.sharpenradius_slider,'Value',handles.sharpenradius,'Min',0.001,'Max',15,'SliderStep',[1/1000 1/100]);

% set threshold edit paramters
set(handles.initialthreshold_edit,'String',handles.initialthreshold);

% set threshold edit, invert, and rgbchannel static-text strings
set(handles.thresholdedit_text,'String','Threshold Value');
set(handles.rgbchannel_text,'String','RGB Channel','Value',handles.rgb_channel);
set(handles.invert_checkbox,'Value',handles.invert_TF);

% Show initial-frame-thresholding objects
set(handles.initialthreshold_slider,'Visible','on');
set(handles.initialthreshold_edit,'Visible','on');
set(handles.rgbchannel_popupmenu,'Visible','on');
set(handles.rgbchannel_text,'Visible','on');
set(handles.thresholdedit_text,'Visible','on');
set(handles.invert_checkbox,'Visible','on');
set(handles.sharpenradius_slider,'Visible','on');
set(handles.continue5_pushbutton,'Visible','on');
set(handles.undo5_pushbutton,'Visible','on');

% generate initial binary image
handles.initialframe_BW = threshold_func(handles.initialframe, handles.initialthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);
axes(handles.axes1);
imshow(handles.initialframe_BW);

% show leaf selections
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;

% update handles
guidata(handles.output,handles);