function [ img_array ] = img_array_func(img_directory )
%img_array_func.m
%   This function loads all .jpg images from a folder into an array


if ispc  % is the computer running the application pc?
    c = '\';
elseif isunix % is the computer unix based?
    c = '/';
else
    c = '/';
end


if img_directory ~= 0;
    img_files = dir(fullfile(img_directory,'*.jpg'));
    %[~, idx] = sort([img_files.datenum]);  % create index based on the
    %date created
    idx = [1:1:numel(img_files)];  % use default sort
    imgs_num = numel(idx);

    h = waitbar(0, 'Reading Images, Please Wait...');
    for n = 1:imgs_num;   % for all indexed images
        img_array{n} = imread([img_directory c img_files(idx(n)).name]);  % load images in order of the sort
        waitbar(n/imgs_num);
    end
    close(h)
end

end

