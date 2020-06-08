%hidestep2_script.m
%   This script hides the objects from step 2

% hide objects from the inital frame selection step [Step 2]
set(handles.initialframe_slider,'Visible','off');
set(handles.continue2_pushbutton,'Visible','off');
set(handles.undo2_pushbutton,'Visible','off');
set(handles.instruction_text,'Visible','off');
set(get(handles.axes1,'children'),'Visible','off');
