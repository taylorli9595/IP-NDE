clear all
close all
clc
load('adv_sar/TSX.mat');
Id = imread('adv_sar/TSXhtnet.png');

In = INoisy;
adv_n = INoisy;

if(ndims(Id) == 3)
    Id = rgb2gray(Id);
end;% 选择一个颜色矩阵,并且变成双浮点型的,这一步没有可能报错.
figure(1), imshow(adv_n,[],'Border','tight');
figure(2), imshow(Id,[],'Border','tight');
Id=double(Id);
In = double(In)*255.0;
adv_n=double(adv_n)*255.0;
%%%%%%%%%%%%%%%%%%%%%%%%%%
%下面是IP-NDE的参数%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alpha=1.2;q=1.3;dt=0.2;iter=125; sigma=0.8,lamba=0,k=0.3;

%%  
tic;
[J]=multi_2_sar(adv_n,Id,iter,dt,sigma,alpha,q,lamba,k);
%[IM_MAE,PSNRAll,J]=regular_PM(Io,In,dt,iter,sigma);
time = toc
%J=(J-min(J(:)))./(max(J(:))-min(J(:)))*255;
image_M1=sprintf('result/Tsx_sar_nde.png');
imwrite(uint8(J),image_M1);
 SI = SpeckleIndex(J)
 qualityscore = brisque(J)
% x=1:length(PSNRAll);
% plot(x,PSNRAll);
% title('PSNRAll');
% 
% figure(10);
% x=1:length(IM_MAE);
% plot(x,IM_MAE);
% title('IM_{MAE}');
J_Z=uint8(J);
% imwrite(J_Z,'Result.bmp','bmp')

figure(3), imshow(J_Z,[],'Border','tight');

figure(4), imshow(uint8(J),'Border','tight');
J_Z=double(J_Z);
% 

[Ny,Nx]=size(J); 
x=1:Nx;
level=fix(Ny/3);
y=J_Z(level,:);
y2=In(level,:);
y3=Id(level,:);

figure(7);
plot(x,y,x,y2);
title('SmoothImage And OriginalImage')
legend('att-HTNet prior','OriginalImage');





