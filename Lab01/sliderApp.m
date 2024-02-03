% function sliderApp
% pic = double(imread("lab1-dist\tennis.png"))/255.0;
% fig = uifigure("Position", [100 100 300 250]);
% g = uigridlayout(fig);
% g.RowHeight = {'1x', 'fit'};
% g.ColumnWidth = {'1x'};
% 
% ax = uiaxes(g);
% imshow(ax, pic)
% 
% 
% end

close all
clear


rangeSliderApp

function rangeSliderApp
fig = uifigure;
g = uigridlayout(fig);
g.RowHeight = {'1x'};
g.ColumnWidth = {'1x'};
pic = double(imread("lab1-dist\tennis.png"))/255.0;
ax = uiaxes(g);

redThresh = [0 1];
greenThresh = [0 1];
blueThresh = [0 1];


redslider = uislider(g, "range", Limits=[0 1]);
greenslider = uislider(g, "range", Limits=[0 1]);
blueslider = uislider(g, "range", Limits=[0 1]);

redslider.ValueChangingFcn = @(src,event) updateRedThreshold(src,event, redThresh, greenThresh, blueThresh, ax, pic);
greenslider.ValueChangingFcn = @(src,event) updateGreenThreshold(src,event, redThresh, greenThresh, blueThresh, ax, pic);
blueslider.ValueChangingFcn = @(src,event) updateBlueThreshold(src,event, redThresh, greenThresh, blueThresh, ax, pic);
end

function updateRedThreshold(src,event, redThresh, greenThresh, blueThresh, ax, picture)
val = event.Value;
redThresh = val;
updateImage(ax, redThresh, greenThresh, blueThresh, picture);
end

function updateGreenThreshold(src,event, redThresh, greenThresh, blueThresh, ax, picture)
val = event.Value;
greenThresh = val;
updateImage(ax, redThresh, greenThresh, blueThresh, picture);
end

function updateBlueThreshold(src,event, redThresh, greenThresh, blueThresh, ax, picture)
val = event.Value;
blueThresh = val;
updateImage(ax, redThresh, greenThresh, blueThresh, picture);
end

function updateImage(imageHandle, redThresh, greenThresh, blueThesh, picture)
    redmask = picture(:,:,1) >= redThresh(1) & picture(:,:,1) <= redThresh(2); % good to go
    greenmask = picture(:,:, 2) >= greenThresh(1) & picture(:,:,2) <= greenThresh(2); % good to go
    bluemask = picture(:,:,3) >= blueThesh(1) & picture(:,:,3) <= blueThesh(2);
    imshow(redmask & greenmask | bluemask, 'Parent', imageHandle);
    drawnow
end