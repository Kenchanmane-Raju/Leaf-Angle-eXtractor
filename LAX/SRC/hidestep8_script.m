% hidestep8_script.m
%   This script hides the objects from step 8 

% hide objects
set(get(handles.axes3,'children'),'Visible','off');
set(get(handles.axes4,'children'),'Visible','off');
set(handles.startanalysis_pushbutton,'Visible','off');
set(handles.undo8_pushbutton,'Visible','off');