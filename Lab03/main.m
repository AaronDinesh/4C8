%% Question 1 Image Entropy
close all
clear
I = double(imread('kodim19_512.png'));
entI = calcEntropy(I);
h = tiledlayout(1,2, 'TileSpacing','Compact','Padding','Compact');
nexttile
imshow(I, [])
title("Original Image $H_o$: "+num2str(entI), 'Interpreter','latex')
QStep = 15;
IQuant = round(I/QStep);
entIQuant = calcEntropy(IQuant);
nexttile
imshow(IQuant, [])
title("Quantized Image $H_{qi}$: "+num2str(entIQuant), 'Interpreter','latex')
exportgraphics(h, 'report/Images/QuantKodim.png', 'BackgroundColor','none')
psnrVal = psnr(IQuant, I, 255);
%% Quesiton 2 Haar Transform
close all
clear

I = double(imread('kodim19_512.png'));
IHarr = calcHaarLevel1(I);
QStep = 15;
IHarrQuant = round(IHarr/QStep);
Hqharr = calcEntropyHaar(IHarrQuant, 1);
h = tiledlayout(1,2, 'TileSpacing','Compact','Padding','Compact');
nexttile
imshow(I,[])
title("Original Image", 'Interpreter','latex')
nexttile
imshow(calcInvHaar(IHarrQuant,1),[])
title("Quantized Haar Level 1 Transform. $Q_{step} = $"+num2str(QStep), 'Interpreter','latex')
psnr(calcInvHaar(IHarrQuant,1), I, 255)
exportgraphics(h, 'report/Images/QuantHaarKodim.png', 'BackgroundColor','none')
%% Question 3 Rate Distorsion Curves
I = double(imread('kodim19_512.png'));
Qstep = [2,4,8,16,32,64,128];
for i = 1:1:length(Qstep)
    e(i) = calcEntropy(round(I/Qstep(i)));
    p(i) = psnr(round(I/Qstep(i)), I, 255);
end

g = tiledlayout(1,1, 'TileSpacing','Compact','Padding','Compact');
nexttile
plot(e, p, '-+')
title("R-D Curve for  No Transformation")
xlabel('Entropy in bits/pixel')
ylabel('PSNR (dB)')
exportgraphics(g, 'report/Images/RDNoTransform.png', 'BackgroundColor','none')

h = tiledlayout(1,1, 'TileSpacing','Compact','Padding','Compact');


nexttile
hold on
plot(e, p, '-+')
title("Rate-Distorsion Curve")
xlabel('Entropy in bits/pixel')
ylabel('PSNR (dB)')

for i = 1:1:length(Qstep)
    IHarr = calcHaarLevel1(I);
    IHarrQuant = round(IHarr/Qstep(i));
    eH1(i) = calcEntropyHaar(IHarrQuant, 1);
    pH1(i) = psnr(calcInvHaar(IHarrQuant, 1), calcInvHaar(IHarr, 1), 255);
end
plot(eH1, pH1, '-o')
legend(["No Transformation", "Haar Level 1"])
hold off
exportgraphics(h, 'report/Images/RDWithTransform.png', 'BackgroundColor','none')

%% Question 4 MultiLevel Haar
I = double(imread('kodim19_512.png'));

Qstep = [2,4,8,16,32,64,128];
h = tiledlayout(1,1, 'TileSpacing','Compact','Padding','Compact');
h.Parent.WindowState = 'maximized';
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
for j = 1:1:5
    for i = 1:1:length(Qstep)
        IHarr = calcHaar(I, j);
        IHarrQuant = round(IHarr/Qstep(i));
        eH1(j, i) = calcEntropyHaar(IHarrQuant, j);
        pH1(j, i) = psnr(calcInvHaar(IHarrQuant, j), calcInvHaar(IHarr, j), 255);
    end
end

nexttile
hold on
all_marks = {'o','+','*','.','x','s','d','^','v','>','<','p','h'};
for i=1:5
    plot(eH1(i, :), pH1(i, :), 'Marker', all_marks{mod(i,13)})
end

legend(["Haar Level 1","Haar Level 2","Haar Level 3","Haar Level 4","Haar Level 5"], 'FontSize', 13)

title("Rate-Distorsion Curve for Various Haar Levels", 'FontSize', 20)
xlabel('Entropy in bits/pixel', 'FontSize', 16)
ylabel('PSNR (dB)', 'FontSize', 16)
hold off

exportgraphics(h, 'report/Images/RDMultipleHaar.png', 'BackgroundColor','none')

