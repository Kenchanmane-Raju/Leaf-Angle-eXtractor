% defaultvars_script.m
%   This script sets default values for many variables

% load handles
handles = guidata(handles.output);

% set some default values that user will change during analysis
handles.initialframe_num = 1;       % default first frame
handles.img_cropwidth = 300;        % default crop width
handles.img_cropheight = 500;       % default crop height
handles.initialthreshold = 0.65;    % default initial threshold
handles.finalthreshold = 0.65;      % default final threshold
handles.invert_TF = 1;              % default invert image
handles.rgb_channel = 3;            % default RGB channel
handles.sharpenradius = 0.1;        % default sharpen radius

% Update handles structure
guidata(hObject, handles);