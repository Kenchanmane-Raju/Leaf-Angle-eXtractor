%showstep7_script.m
%   This script shows the objects for step 7, final image threshold
% load handles
handles = guidata(handles.output);

% update instruction text
set(handles.instruction_text,'String',handles.step7_instruction);

% set final threshold slider parameters
set(handles.finalthreshold_slider,'Value',handles.finalthreshold);

% set threshold edit paramters
set(handles.finalthreshold_edit,'String',handles.finalthreshold);

% show objects
set(handles.finalthreshold_slider,'Visible','on');
set(handles.finalthreshold_edit,'Visible','on');
set(handles.undo7_pushbutton,'Visible','on');
set(handles.continue7_pushbutton,'Visible','on');
set(handles.thresholdedit_text,'Visible','on');

% show default binary image
handles.finalframe_BW = threshold_func(handles.finalframe, handles.finalthreshold, handles.sharpenradius, handles.rgb_channel, handles.invert_TF);
axes(handles.axes1);
imshow(handles.finalframe_BW);

% show rectangles
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;

% update handles
guidata(handles.output,handles);