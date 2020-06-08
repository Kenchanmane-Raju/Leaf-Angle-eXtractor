function [ img ] = finalframe_func( i, img_array, x1, y1, w, h )
%finalframe_func.m
%   This function takes an input number for the frame and the crop
%   parameters and returns the image of the final frame

i = round(i);
img = img_array{i};

img = imcrop(img,[x1 y1 w h]);

end

