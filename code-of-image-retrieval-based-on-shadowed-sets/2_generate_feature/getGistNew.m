%based on shadowed set
% Load image (this image is not square)
gistDescriptor = [];
for i=1:5000
    img = imread(['./dataset/corelTrain/',num2str(i-1), '.jpg']);
    img2map = imread(['./dataset/mapTrain/',num2str(i-1), '_stage2.png']);
    mean_corner = double(img2map(1,1)+img2map(1,2)+img2map(2,1)+img2map(2,2)+img2map(end-1,1)+img2map(end,1)+img2map(end-1,2)+img2map(end,2)+img2map(1,end-1)+img2map(1,end)+img2map(2,end-1)+img2map(2,end)+img2map(end-1,end-1)+img2map(end-1,end)+img2map(end,end-1)+img2map(end,end))/16;
    vague = max(1,mean_corner)*10;
    BW = roicolor(img2map,vague,255);
    BW = uint8(BW);
    [m,n] = size(img2map); 
    ind = find(BW == 0);
    img([ind, ind + (m * n), ind + (m * n) * 2]) = 0; 

    % Parameters:
    clear param 
    %param.imageSize. If we do not specify the image size, the function LMgist
    %   will use the current image size. If we specify a size, the function will
    %   resize and crop the input to match the specified size. This is better when
    %   trying to compute image similarities.
    param.orientationsPerScale = [8 8 8 8];
    param.numberBlocks = 4;
    param.fc_prefilt = 4;

    %Computing gist requires 1) prefilter image, 2) filter image and collect
    % output energies
    [gist, param] = LMgist(img, '', param);
    gistDescriptor = [gistDescriptor;gist];
    disp(i);
end

for i=0:999
    img = imread(['./dataset/coreTest/',num2str(i), '.jpg']);
    img2map = imread(['./dataset/mapTest/',num2str(i), '_stage2.png']);
    mean_corner = double(img2map(1,1)+img2map(1,2)+img2map(2,1)+img2map(2,2)+img2map(end-1,1)+img2map(end,1)+img2map(end-1,2)+img2map(end,2)+img2map(1,end-1)+img2map(1,end)+img2map(2,end-1)+img2map(2,end)+img2map(end-1,end-1)+img2map(end-1,end)+img2map(end,end-1)+img2map(end,end))/16;
    vague = max(1,mean_corner)*10;
    BW = roicolor(img2map,vague,255);
    BW = uint8(BW);
    [m,n] = size(img2map); 
    ind = find(BW == 0);
    img([ind, ind + (m * n), ind + (m * n) * 2]) = 0; 

    % Parameters:
    clear param 
    %param.imageSize. If we do not specify the image size, the function LMgist
    %   will use the current image size. If we specify a size, the function will
    %   resize and crop the input to match the specified size. This is better when
    %   trying to compute image similarities.
    param.orientationsPerScale = [8 8 8 8];
    param.numberBlocks = 4;
    param.fc_prefilt = 4;

    %Computing gist requires 1) prefilter image, 2) filter image and collect
    % output energies
    [gist, param] = LMgist(img, '', param);
    gistDescriptor = [gistDescriptor;gist];
    disp(i);
end

label1 = ones(100,1);
label = ones(100,1);

str = 'label';
for i=2:60
%     label_back = [str,num2str(i)];
    label_back = label1*i;
    label = [label;label_back];
end
gistDescriptor = [gistDescriptor label];
save('gistNew.mat','gistDescriptor')









