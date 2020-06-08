%selectleaves_script.m
% This script has user select the leaves for investigation by drawing
% rectangles around each leaf of interest.  The user must select ONLY the
% leaf, not the stalk.  This is because the angle is calculated by
% ananlyzing the connected component.  If the stalk is included as part of
% the connected component the angle data will be incorrect.

% draw rectangles around leaves of interest
% user may draw rectangles around as many leaves as they wish
n = 0;
button = 'Yes';
while 0 == strcmp('No',button)
    
    if strcmp('Yes',button)
        n = n+1;
        rect = round(getrect(handles.axes1));
        try
            rectangle('Position',rect,'EdgeColor','r','LineWidth',2);
            button = questdlg('Select Another Leaf?','Leaf Selector','Yes','No','Undo','No');
            rect_array{n} = rect;
        catch
            button = 'Yes';
            n = n-1;
        end
    end
    
    if n == 0   % This covers case where user mashes undo to delete all rectangles
        button = 'Yes';
    end
    
    if strcmp('Undo',button);
        rect_array(n) = [];
        n = n-1;
       
        % update displayed image
        axes(handles.axes1);
        imshow(handles.initialframe);
        try
            hold on;
            for j = 1:numel(rect_array)
                rectangle('Position',rect_array{j},'EdgeColor','r','LineWidth',2);
            end
            hold off;
        catch
        end
        button = questdlg('Select Another Leaf?','Leaf Selector','Yes','No','Undo','No');
    end
end
handles.rect_array = rect_array;

% update handles to store rectangle data
guidata(handles.output,handles);