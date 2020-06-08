%showstep8_script.m
%   This script shows the objects for step 8, confirm wilt period

% hide axes 1
set(get(handles.axes1,'children'),'Visible','off');

% modify instruction text 
set(handles.instruction_text,'String',handles.step8_instruction);

% show objects
set(handles.axes3,'Visible','on');
set(handles.axes4,'Visible','on');
set(handles.startanalysis_pushbutton,'Visible','on');
set(handles.undo8_pushbutton,'Visible','on');

% show initial frame
axes(handles.axes3);
imshow(handles.initialframe_BW);
hold on;
% show rectangles
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;

% show final frame
axes(handles.axes4);
imshow(handles.finalframe_BW);
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
