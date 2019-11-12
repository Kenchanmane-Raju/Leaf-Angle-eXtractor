function [ img ] = initialframe_func( i, img_array )
%initialframe_func
%   uses input framecount and img_array to output the corresponding image
i = round(i);
img = img_array{i};

end

