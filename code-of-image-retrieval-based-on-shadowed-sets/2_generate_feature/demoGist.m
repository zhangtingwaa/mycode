% Load image (this image is not square)
img2 = imread('ren.jpg');
img = img2;
img2map = imread('renmap.png');
BW = roicolor(img2map,128,255);
% mean_corner = double(img2map(1,1)+img2map(1,2)+img2map(2,1)+img2map(2,2)+img2map(end-1,1)+img2map(end,1)+img2map(end-1,2)+img2map(end,2)+img2map(1,end-1)+img2map(1,end)+img2map(2,end-1)+img2map(2,end)+img2map(end-1,end-1)+img2map(end-1,end)+img2map(end,end-1)+img2map(end,end))/16;
% vague = max(1,mean_corner)*10;
% BW = roicolor(img2map,vague,255);
% BW = uint8(BW);
[m,n] = size(img2map); 
ind = find(BW == 0);
img2([ind, ind + (m * n), ind + (m * n) * 2]) = 0; 

% Parameters:
clear param 
%param.imageSize. If we do not specify the image size, the function LMgist
%   will use the current image size. If we specify a size, the function will
%   resize and crop the input to match the specified size. This is better when
%   trying to compute image similarities.
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;

% Computing gist requires 1) prefilter image, 2) filter image and collect
% output energies
[gist2, param] = LMgist(img2, '', param);

% % Visualization
figure
subplot(121)
imshow(img2)
title('input')
subplot(122)
showGist(gist2, param)
title('Descriptor')

% Visualization
% figure
% subplot(121)
% imshow(BW)
% title('input')
% subplot(122)
% imshow(img2)
% title('output')



