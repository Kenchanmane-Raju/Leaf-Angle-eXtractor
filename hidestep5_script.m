%hidestep5_script.m
%   This script hides the objects for step 5, intial frame thresholding

% hide initial-frame-thresholding objects
set(handles.initialthreshold_slider,'Visible','off');
set(handles.initialthreshold_edit,'Visible','off');
set(handles.rgbchannel_popupmenu,'Visible','off');
set(handles.rgbchannel_text,'Visible','off');
set(handles.thresholdedit_text,'Visible','off');
set(handles.invert_checkbox,'Visible','off');
set(handles.sharpenradius_slider,'Visible','off');
set(handles.continue5_pushbutton,'Visible','off');
set(handles.undo5_pushbutton,'Visible','off');