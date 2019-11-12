%showwelcome_script.m
% This script shows all of the objects on the welcome screen

set(handles.welcome_text,'Visible','on');
set(handles.welcomedescription_text,'Visible','on');
set(handles.newproject_pushbutton,'Visible','on');


% load welcome image
handles.welcome_image = sprintf('welcome_image.jpg');
axes(handles.axes5);
imshow(imread(handles.welcome_image));