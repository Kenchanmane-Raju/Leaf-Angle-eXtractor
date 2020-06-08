function [ BW ] = threshold_func( input_image, level, sharpenradius, rgb_channel, invert_TF )
%threshold_func.m
%   This function takes a RGB input image and a threshold level and generates a
%   binary image

% use user defined channel
I = input_image(:,:,rgb_channel);

% sharpen image
I = imsharpen(I,'radius',sharpenradius);

% histogram adaptive equalization
I = adapthisteq(I,'range','full','clipLimit',0.99,'Distribution','uniform');

% invert colors so that the plant is active object
if invert_TF == 1
    I = imcomplement(I);
end

% change to binary image
BW = im2bw(I,level);

end

