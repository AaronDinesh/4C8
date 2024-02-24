%% Section 1
close all
clear
%1.1
pic = double(imread("lab1-dist\kodim07.png"))/255.0;
graypic = rgb2gray(pic);

figure
subplot(1,2,1)
imshow(pic)
title("Kodim07.png")

subplot(1,2,2)
imshow(graypic)
title("Grayscale Kodim07.png")

%1.2
brightpic = pic + (128.0/255.0);

t = tiledlayout(1,2, 'TileSpacing','Compact','Padding','Compact');
nexttile
imshow(pic)
title("Grayscale Kodim07.png")

nexttile
imshow(brightpic)
title("Added 128 to Kodim07.png")
exportgraphics(t, 'report/Images/Kodim07Add128.png', 'BackgroundColor','none')


%1.3
darkpic = pic - (128.0/255.0);

g = tiledlayout(1,2, 'TileSpacing','Compact','Padding','Compact');
nexttile
imshow(pic)
title("Grayscale Kodim07.png")

nexttile
imshow(darkpic)
title("Subtracted 128 from Kodim07.png")
exportgraphics(g, 'report/Images/Kodim07Sub128.png', 'BackgroundColor','none')

%% Section 2
close all
clear

%2.1
pic = double(imread("lab1-dist\tennis.png"))/255.0;
t = tiledlayout(1,3, 'TileSpacing','Compact','Padding','Compact');
nexttile
histogram(pic(:, : , 1))
title("Histogram of R component")

nexttile
histogram(pic(:, : , 2))
title("Histogram of G component")

nexttile
histogram(pic(:, : , 3))
title("Histogram of B component")
exportgraphics(t, 'report/Images/TennisHistogramsRGB.png', 'BackgroundColor','none')

picycbcr = rgb2ycbcr(pic);
h = tiledlayout(1,2, 'TileSpacing','Compact','Padding','Compact');
nexttile
imshow(pic)
title("Tennis.png in the RGB Colorspace")
nexttile
imshow(picycbcr)
title("Tennis.png in the YCbCr Colorspace")
exportgraphics(h, 'report/Images/TennisRGBvsYCbCr.png', 'BackgroundColor','none')

g = tiledlayout(1,3, 'TileSpacing','Compact','Padding','Compact');
nexttile
histogram(picycbcr(:, : , 1))
title("Histogram of Y component")

nexttile
histogram(picycbcr(:, : , 2))
title("Histogram of Cb component")

nexttile
histogram(picycbcr(:, : , 3))
title("Histogram of Cr component")
exportgraphics(g, 'report/Images/TennisHistogramsYCbCr.png', 'BackgroundColor','none')
%% Section 3
close all
clear
pic = double(imread("lab1-dist\tennis.png"))/255.0;

%3.0
redmask = pic(:,:,1) >= 0.275 & pic(:,:,1) <= 0.33; % good to go
greenmask = pic(:,:, 2) >= 0.50 & pic(:,:,2) <= 0.625; % good to go
bluemask = pic(:,:,3) >= 0.66 & pic(:,:,3) <= 0.71;
mask = redmask & greenmask | bluemask;
mask = cat(3, mask, mask, mask);

g = tiledlayout(1,3, 'TileSpacing','Compact','Padding','Compact');
nexttile
imshow(pic)
title("Original Image")

nexttile
imshow(mask(:, :, 1))
title("Mask of Court")

nexttile
imshow(pic.*mask)
title("Masked Court")
exportgraphics(g, 'report/Images/SegmentedTennisCourt.png', 'BackgroundColor','none')
%% Section 4
close all
clear
%4.1
imageA = imread("lab1-dist\kodim23a.png");
imageB = imread("lab1-dist\kodim23b.png");
range = 0:255;

cdfRedA = cumsum(histcounts(imageA(:,:, 1), 256,'Normalization', 'probability'));
cdfGreenA = cumsum(histcounts(imageA(:,:, 2), 256,'Normalization', 'probability'));
cdfBlueA = cumsum(histcounts(imageA(:,:, 3), 256, 'Normalization', 'probability'));

cdfRedB = cumsum(histcounts(imageB(:,:, 1), 256, 'Normalization', 'probability'));
cdfGreenB = cumsum(histcounts(imageB(:,:, 2), 256, 'Normalization', 'probability'));
cdfBlueB = cumsum(histcounts(imageB(:,:, 3), 256, 'Normalization', 'probability'));

g = tiledlayout(3,1, 'TileSpacing','Compact','Padding','Compact');

nexttile
plot(range, cdfRedA , range, cdfRedB)
title("CDF of Red Component")
xlim([0 255])
legend({"ImageA", "ImageB"})

nexttile
plot(range, cdfGreenA , range, cdfGreenB)
title("CDF of Green Component")
xlim([0 255])
legend({"ImageA", "ImageB"})

nexttile
plot(range, cdfBlueA, range, cdfBlueB)
title("CDF of Blue Component")
xlim([0 255])
legend({"ImageA", "ImageB"})
exportgraphics(g, 'report/Images/KodimCumHistograms.png', 'BackgroundColor','none')

Rw = 255*182/150;
Gw = 255*167/150;
Bw = 255*150/150;

transformMat = [255/Rw 0 0; 0 255/Gw 0; 0 0 255/Bw];

transformedImage = zeros(size(imageB));

imageBDouble = double(imageB)/255.0;

for i=1:size(imageB, 1)
    for j=1:size(imageB, 2)
        transformedImage(i, j, :) = transformMat * permute(imageBDouble(i, j, :), [3, 2, 1]);
    end
end

t = tiledlayout(1,2, 'TileSpacing','Compact','Padding','Compact');

nexttile
imshow(imageA)
title("Image A")

nexttile
imshow(imageB)
title("ImageB")
exportgraphics(t, 'report/Images/KodimImages.png', 'BackgroundColor','none')


h = tiledlayout(1,2, 'TileSpacing','Compact','Padding','Compact');

nexttile
imshow(imageA)
title("Image A")

nexttile
imshow(transformedImage)
title("Transformed ImageB")
exportgraphics(h, 'report/Images/KodimTransformed.png', 'BackgroundColor','none')

averageAbsDiff = mean(abs((double(imageA)/255.0)-transformedImage), 3);

x = tiledlayout(1,1,'TileSpacing','Compact','Padding','Compact');
nexttile
surf(averageAbsDiff, 'LineStyle','none')
title("Average Absolute Error between Transformed Kodim23b and Kodim23a")
view(0, -90)
c = colorbar;
c.Label.String = 'Average absolute Error';
xlim([0 size(transformedImage, 2)])
ylim([0 size(transformedImage, 1)])
exportgraphics(x, 'report/Images/KodimTransformedAAE.png', 'BackgroundColor','none')



