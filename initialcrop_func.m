function [ cropped_image, x, y ] = initialcrop_func( i, img_array, w, h )
%croppedframe_func.m
%   This function requests user to select bottom of a stalk in order to
%   isolate a single plant for analysis

img = img_array{i};

% coordinates that user selects for base of stalk
[x, y] = ginput(1);

% round location to nearest whole integer representation
x = round(x);
y = round(y);

% find upper left corner for crop
x1 = x-w/2;
y1 = y-h;

% crop the plant
cropped_image = imcrop(img,[x1 y1 w h]);

end

