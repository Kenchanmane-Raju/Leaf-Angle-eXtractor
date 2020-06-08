function [ cropped_image ] = crop_func( i, img_array, w, h, x, y )
%croppedframe_func.m
%   This function crops images after the initial frame

img = img_array{i};

% find upper left corner for crop
x1 = x-w/2;
y1 = y-h;

% crop the plant
cropped_image = imcrop(img,[x1 y1 w h]);

end

