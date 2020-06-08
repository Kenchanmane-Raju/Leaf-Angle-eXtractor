%showstep6_script.m
%   This script shows the objects for step 6, final image selection

% load handles
handles = guidata(handles.output);

% update instruction text
set(handles.instruction_text,'String',handles.step6_instruction);

% show objects from select-final-frame step
set(handles.finalframe_slider,'Visible','on');
set(handles.undo6_pushbutton,'Visible','on');
set(handles.continue6_pushbutton,'Visible','on');

% set the parameters for the final frame slider
set(handles.finalframe_slider,'Min',handles.initialframe_num,'Max',numel(handles.img_array),'Value',handles.initialframe_num,'SliderStep',[1/numel(handles.img_array) 10/numel(handles.img_array)]);

% set default value for final frame
handles.finalframe_num = handles.initialframe_num;

% show the default final frame
handles.finalframe = crop_func(handles.finalframe_num, handles.img_array, handles.img_cropwidth ,handles.img_cropheight, handles.stalk_x, handles.stalk_y); 
axes(handles.axes1);
imshow(handles.finalframe);   % display frame and rectangles
hold on;
for n = 1:numel(handles.rect_array)
    rectangle('Position',handles.rect_array{n},'EdgeColor','r','LineWidth',2);
end
hold off;

% update handles
guidata(handles.output,handles);

