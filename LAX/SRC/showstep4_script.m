%showstep4_script.m
%   This script shows the objects for step 4, select leaves

% update the instruction text
set(handles.instruction_text,'String',[handles.step4a_instruction handles.step4b_instruction])

% show objects for select-leaves step
set(handles.continue4_pushbutton,'Visible','on');
set(handles.undo4_pushbutton,'Visible','on');

% show initial frame
axes(handles.axes1);
imshow(handles.initialframe);

