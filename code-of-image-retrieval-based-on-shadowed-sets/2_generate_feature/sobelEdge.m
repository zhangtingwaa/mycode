clear all; 
close all;

for i=987:987
%     img = imread(['./dataset/corelTrain/',num2str(i-1), '.jpg']);
%     imag = imread(['./dataset/mapTrain/',num2str(i-1), '_stage2.png']);
 img = imread(['./dataset/coreTest/',num2str(i-1), '.jpg']);
 imag = imread(['./dataset/mapTest/',num2str(i-1), '_stage2.png']);

subplot(161);
imshow(img);title('原图'); 
subplot(162);
imshow(imag);title('显著图'); 

temp = imag;
BW = roicolor(temp,128,255);
BW = uint8(BW);
[m,n] = size(temp); 
ind = find(BW == 0);
temp(ind) = 0; 
ind = find(BW == 1);
temp(ind) = 255;
subplot(163);imshow(temp);title('硬化分'); 


mean_corner = double(imag(1,1)+imag(1,2)+imag(2,1)+imag(2,2)+imag(end-1,1)+imag(end,1)+imag(end-1,2)+imag(end,2)+imag(1,end-1)+imag(1,end)+imag(2,end-1)+imag(2,end)+imag(end-1,end-1)+imag(end-1,end)+imag(end,end-1)+imag(end,end))/16;
vague = max(1,mean_corner)*10;
BW = roicolor(imag,vague,255);
BW = uint8(BW);
[m,n] = size(imag); 
ind5 = find(BW == 0);
ind6 = find(BW == 1);
mask = imag;
mask(ind5) = 0; 
mask(ind6) = 255; 
subplot(164);imshow(im2uint8(mask));title('按倍数划分'); 
   

[high,width] = size(imag);  
F2 = double(imag);        
U = double(imag);       
uSobel = rgb2gray(img);      
for i = 2:high - 1  
    for j = 2:width - 1
        Gx = (U(i+1,j-1) + 2*U(i+1,j) + F2(i+1,j+1)) - (U(i-1,j-1) + 2*U(i-1,j) + F2(i-1,j+1));
        Gy = (U(i-1,j+1) + 2*U(i,j+1) + F2(i+1,j+1)) - (U(i-1,j-1) + 2*U(i,j-1) + F2(i+1,j-1));
        uSobel(i,j) = sqrt(Gx^2 + Gy^2); 
    end
end 

total = sum(sum(uSobel));
count = numel(uSobel(uSobel~=0));
thred = min(254,floor(3*total/count));
uSobel(uSobel<thred) = 0;

subplot(165);imshow(im2uint8(uSobel));title('边缘检测');  


ind2 = find(uSobel>0);
% [m,n] = find(uSobel>0);
thred2 = sum(imag(ind2))/numel(imag(ind2));
ind3 = find(imag>thred2);
imag(ind3)=255;
ind4 = find(imag<=thred2);
imag(ind4)=0;
subplot(166);imshow(imag,[]);title('结果');
end