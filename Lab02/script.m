%% Quesiton 1
close all
clear
I = double(imread("kodim19-256.png"))/255.0;
mask = (1/20.25)*[1 2.5 1; 2.5 6.25 2.5; 1 2.5 1];
IO = conv2(I, mask, 'same');

h = tiledlayout(1,3, 'TileSpacing','Compact','Padding','Compact');
nexttile
imshow(mask)
title("Convolution Mask")
nexttile
imshow(I)
title("Image Before Convolution")
nexttile
imshow(IO)
title("Image After Convolution")
exportgraphics(h, 'report/Images/ConvdImageIO.png', 'BackgroundColor','none')


%% Question 1 Seperable filters
close all
clear
I = double(imread("kodim19-256.png"))/255.0;
org_mask = (1/20.25)*[1 2.5 1; 2.5 6.25 2.5; 1 2.5 1];
row_filter = (1/4.5)*[1 2.5 1];
col_filter = (1/4.5)*[1; 2.5; 1];

h = tiledlayout(1,3, 'TileSpacing','Compact','Padding','Compact');
ax1 = nexttile;
IO = conv2(I, org_mask, 'same');
imshow(IO)
title("Conv with Mask")

ax2 = nexttile;
sep_out = conv2(conv2(I, col_filter, 'same'), row_filter, 'same');
imshow(sep_out)
title("Conv with Seperable Masks")

ax3 = nexttile;
histogram(abs(sep_out - IO));
title("Histogram of the Errors")

ax3.PlotBoxAspectRatio = ax1.PlotBoxAspectRatio;
mean_abs_err = mean(mean(abs(sep_out - IO)));
exportgraphics(h, 'report/Images/SepConvdImageIO.png', 'BackgroundColor','none')
%% Question 2 Image Gradient
close all
clear
I = double(imread("kodim19-256.png"))/255.0;
horz_grad_mask = [0 -1 0; 0 0 0; 0 1 0];
vert_grad_mask = [0 0 0; -1 0 1; 0 0 0];
mask = (1/20.25)*[1 2.5 1; 2.5 6.25 2.5; 1 2.5 1];
IO = conv2(I, mask, 'same');
Ix = conv2(IO, horz_grad_mask, 'same');
Iy = conv2(IO, vert_grad_mask, 'same');
grad_mag = normalize(Ix.^2 + Iy.^2, 'range');
h = tiledlayout(1,3, 'TileSpacing','Compact','Padding','Compact');
nexttile
imshow(Ix+0.5)
title("Horizontal Gradient")
nexttile
imshow(Iy+0.5)
title("Vertical Gradient")
nexttile
imshow(grad_mag)
title("Gradient Magnitude")
exportgraphics(h, 'report/Images/ImageGradients.png', 'BackgroundColor','none')
%% Question 3 Downsampling
close all
clear
I = double(imread("kodim19-256.png"))/255.0;
mask = (1/20.25)*[1 2.5 1; 2.5 6.25 2.5; 1 2.5 1];
IO = conv2(I, mask, 'same');



h = tiledlayout(1,3, 'TileSpacing','compact','Padding','compact');
h.Parent.WindowState = 'maximized';
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);

ax1 = nexttile;
imshow(I)
title("Original Image")

ax2 = nexttile;
imshow(I(1:2:end, 1:2:end))
title("Downsampled Image")

ax3 = nexttile;
imshow(IO(1:2:end, 1:2:end))
title("Downsampled Image after Lowpass Filter")

ax2.PlotBoxAspectRatio = ax1.PlotBoxAspectRatio;
ax3.PlotBoxAspectRatio = ax1.PlotBoxAspectRatio;
exportgraphics(h, 'report/Images/DownsampledImages.png', 'BackgroundColor','none')
%% Question 4 Unsharp Mask
close all
clear
I = double(imread("kodim19-256.png"))/255.0;
mask = (1/20.25)*[1 2.5 1; 2.5 6.25 2.5; 1 2.5 1];
IO = conv2(I, mask, 'same');
a1 = 2.0; 
a2 = 4.7;
a3 = 10;

h = tiledlayout(1,3, 'TileSpacing','compact','Padding','compact');
nexttile
imshow(I + a1.*(I - IO))
title("$\alpha$ = "+num2str(a1), 'Interpreter','latex')

nexttile
imshow(I + a2.*(I - IO))
title("$\alpha$ = "+num2str(a2), 'Interpreter','latex')

nexttile
imshow(I + a3.*(I - IO))
title("$\alpha$ = "+num2str(a3), 'Interpreter','latex')
exportgraphics(h, 'report/Images/SharpenedImages.png', 'BackgroundColor','none')


% alpha = 1:0.01:10;
% nImages = length(alpha);
% 
% fig = figure('WindowState','fullscreen');
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
% v = VideoWriter("UnsharpenMask.mp4", 'MPEG-4');
% open(v)
% for idx = 1:nImages
%     Iout = I + alpha(idx).*(I - IO);
%     set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
%     imshow(Iout)
%     title("Unsharpen Mask $\alpha$ = " + num2str(alpha(idx)), 'Interpreter','latex')
%     drawnow
%     frame = getframe(fig);
%     writeVideo(v,frame)
% end
% 
% close(v)
% close all