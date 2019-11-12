function [ angledata ] = wiltanalysis_func(img_array, rect_array, initialframe, finalframe, initiallevel, finallevel, sharpenradius, rgb_channel, invert_TF, x, y, w, h )
%wiltanalysis_func.m
%   This function generates an array of angle data for a series of
%   consecutive images of a maize plant

% find upper left corner for crop
x1 = x-w/2;
y1 = y-h;

% find integer value for initial and final frame
initialframe = round(initialframe);
finalframe = round(finalframe);

% determine number of steps
steps = finalframe-initialframe;

% preallocate memory for angle data
angledata = zeros(numel(rect_array),steps);

% set up variable BW threshold
variablethreshold = linspace(initiallevel,finallevel,steps+1);

leaf_num = numel(rect_array);

% intial string for waitbar
waitstr = sprintf(' Analyzing leaf 1 of %d, Please Wait...',leaf_num);

% start waitbar at 0th iteration
wb = waitbar(0,waitstr);


for r = 1:leaf_num;
    for j = initialframe:finalframe
        currentstep = j-initialframe+1;
        
        % round array of rectangles to prevent pixel values which are not
        % integers
        rect = round(rect_array{r});
        
        % open current image in sequence
        I = img_array{j};

        % crop the plant
        cropped = imcrop(I,[x1 y1 w h]);

        % find threshold value that corresponds to current step
        level = variablethreshold(currentstep);
        
        % convert to BW image
        BW = threshold_func(cropped, level, sharpenradius, rgb_channel, invert_TF);

        % preallocate memory for new image of only leaf
        BW2 = zeros(size(BW));

        for k = rect(2):rect(2)+rect(4)
            for l = rect(1):rect(1)+rect(3)
                BW2(k,l) = BW(k,l);
            end
        end

        % change BW image to the specific area of interest
        BW = BW2;

        % find and label connected components
        L = bwlabel(BW, 8);
        % find area and orientation
        STATS = regionprops(L,'Area');

        % find the area of all of the connected components (number of pixels per
        % component
        area = [STATS.Area];

        % find which component has the largest area
        [~,Idx] = max(area);

        % use only the largest of the connected components
        for k = 1:h+1
            for l = 1:w+1
                if L(k,l) == Idx
                    L(k,l) = 1;
                else
                    L(k,l) = 0;
                end
            end
        end
        
        % pull angle data from STATS
        STATS2 = regionprops(L,'Orientation');
        
        if isempty(STATS2);
            Angles = NaN;

         % left and right side angle calculation
        elseif rect(1) <= w/2
            Angles = 90 + STATS2.Orientation;
        else
            Angles = 90 - STATS2.Orientation;
        end

        % if foreign object is blocking leaf
        if isempty(Angles);
            Angles = NaN;
        end
        
        % save wilt angle data for current loop iteration
        angledata(r,currentstep) = Angles;

        % update waitbar and waitbar string
        waitstr = sprintf(' Analyzing leaf %d of %d, Please Wait...',r,leaf_num);
        waitbar(currentstep/(steps),wb,waitstr); 
    end
    
% // Below is code which would plot and save individual figures for all
% leaves under evaluation.  It is no longer used.

%    t = 1:1:size(allAngles(:,1));
    % create scatterplot of wilt angle data
%    fig(r) = figure( 'Name', 'Wilt Angle versus Frame Count' );
%    set(gcf, 'Visible', 'off')
 %   s = 10;
 %   h1 = scatter( t, allAngles, s, 'MarkerEdgeColor','k','MarkerFaceColor','k');

    % Label axes
%    xlabel( 'Frame Count' );
 %   ylabel( 'Wilt Angle' );
 %   xlim('auto');
 %   ylim([0 90]);
 %   grid on
    %figurefilename = sprintf('WiltData_leaf%d_%s.fig',r,datestr(now,'yyyymmdd_HHMMSS'));
    %savefig(fig(r),figurefilename);
  
end
% close waitbar
close(wb);

