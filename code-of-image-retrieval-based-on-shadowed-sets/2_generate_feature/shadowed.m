clear all; 
close all;

gistDescriptor = [];
for i=1:5000
    img = imread(['./dataset/corelTrain/',num2str(i-1), '.jpg']);
    imag = imread(['./dataset/mapTrain/',num2str(i-1), '_stage2.png']);

   
    U = double(imag);       
    uSobel = rgb2gray(img);    
   
    grey = uSobel;
    
    grayPic=mat2gray(grey);
    [m,n]=size(grayPic);
    uSobel=grayPic;
    sobelNum=0;
    sobelThreshold=0.8;
    for j=2:m-1 
        for k=2:n-1
            sobelNum=abs(grayPic(j-1,k+1)+2*grayPic(j,k+1)+grayPic(j+1,k+1)-grayPic(j-1,k-1)-2*grayPic(j,k-1)-grayPic(j+1,k-1))+abs(grayPic(j-1,k-1)+2*grayPic(j-1,k)+grayPic(j-1,k+1)-grayPic(j+1,k-1)-2*grayPic(j+1,k)-grayPic(j+1,k+1));
            if(sobelNum > sobelThreshold)
                uSobel(j,k)=255;
            else
                uSobel(j,k)=0;
            end
        end
    end
  

% result1 = imag;
result2 = imag;
% img1 = img;
img2 = img;
ind2 = find(uSobel>1);
% thred2 = sum(imag(ind2))/numel(imag(ind2));
thred = sum(imag(ind2))/numel(imag(ind2))/2.5;

ind5 = find(imag>thred);
result2(ind5)=255;
ind6 = find(imag<=thred);
result2(ind6)=0;
indB = find(result2 == 0);
img2([indB, indB + (m * n), indB + (m * n) * 2]) = 0; 

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
    [gist, param] = LMgist(img2, '', param);
    gistDescriptor = [gistDescriptor;gist];
    disp(i);
end

for i=1:1000
    img = imread(['./dataset/coreTest/',num2str(i-1), '.jpg']);
    imag = imread(['./dataset/mapTest/',num2str(i-1), '_stage2.png']);
        
    U = double(imag);       
    uSobel = rgb2gray(img);    
    % subplot(153);
    grey = uSobel;
    % imshow(grey);title('»Ò¶ÈÍ¼'); 
    grayPic=mat2gray(grey);
    [m,n]=size(grayPic);
    uSobel=grayPic;
    sobelNum=0;
    sobelThreshold=0.8;
    for j=2:m-1 
        for k=2:n-1
            sobelNum=abs(grayPic(j-1,k+1)+2*grayPic(j,k+1)+grayPic(j+1,k+1)-grayPic(j-1,k-1)-2*grayPic(j,k-1)-grayPic(j+1,k-1))+abs(grayPic(j-1,k-1)+2*grayPic(j-1,k)+grayPic(j-1,k+1)-grayPic(j+1,k-1)-2*grayPic(j+1,k)-grayPic(j+1,k+1));
            if(sobelNum > sobelThreshold)
                uSobel(j,k)=255;
            else
                uSobel(j,k)=0;
            end
        end
    end

 
    % result1 = imag;
    result2 = imag;
    % img1 = img;
    img2 = img;
    ind2 = find(uSobel>1);
    % thred2 = sum(imag(ind2))/numel(imag(ind2));
    thred = sum(imag(ind2))/numel(imag(ind2))/2.5;

    ind5 = find(imag>thred);
    result2(ind5)=255;
    ind6 = find(imag<=thred);
    result2(ind6)=0;
    indB = find(result2 == 0);
    img2([indB, indB + (m * n), indB + (m * n) * 2]) = 0; 

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
    [gist, param] = LMgist(img2, '', param);
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
save('gist2.mat','gistDescriptor')