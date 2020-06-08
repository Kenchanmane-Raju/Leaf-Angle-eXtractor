%hidewelcome_script.m
% This script hides all of the objects on the welcome screen

set(handles.welcome_text,'Visible','off');
set(handles.welcomedescription_text,'Visible','off');
set(handles.newproject_pushbutton,'Visible','off');
set(get(handles.axes5,'children'),'Visible','off');
