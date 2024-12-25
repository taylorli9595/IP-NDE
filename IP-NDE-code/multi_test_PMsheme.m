clear all
close all
clc
% load('SAR_image2/L1/texture2_L1.mat');
% Id = imread('result_HTNet/texture2_L1adv.png');
% load('SAR_image2/L4/texture2_L4.mat');
% Id = imread('result_HTNet/texture2_L4adv.png');
% load('SAR_image2/L10/texture2_L10.mat');
% Id = imread('result_HTNet/texture2_L10adv.png');


% 
% load('SAR_image2/L1/aerial_L1.mat');
% Id = imread('result_HTNet/aerial_L1adv.png');
% load('SAR_image2/L4/aerial_L4.mat');
% Id = imread('result_HTNet/aerial_L4adv.png');
% load('SAR_image2/L10/aerial_L10.mat');
% Id = imread('result_HTNet/aerial_L10adv.png');

% load('SAR_image2/L1/aerial_L1.mat');
% Id = imread('result_HTNet/aerial_L1htnet.png');%%%%对抗图像用更好的先验
%alpha=1.4;q=1.0;dt=0.2;iter=108; sigma=0.7,lamba=0,k=0.3;%div2, aerial_L1   24.9086 0.6322


% load('SAR_image2/L1/lena_L1.mat');
% Id = imread('result_HTNet/lena_L1adv.png');
% load('SAR_image2/L4/lena_L4.mat');
% Id = imread('result_HTNet/lena_L4adv.png');
% load('SAR_image2/L10/lena_L10.mat');
% Id = imread('result_HTNet/lena_L10adv.png');

% 
% load('SAR_image2/L1/satellite1_L1.mat');
% Id = imread('result_HTNet/satellite1_L1adv.png');
% load('SAR_image2/L4/satellite1_L4.mat');
% Id = imread('result_HTNet/satellite1_L4adv.png');
load('SAR_image2/L10/satellite1_L10.mat');
Id = imread('result_HTNet/satellite1_L10adv.png');


% load('SAR_test_mat/lena_L4.mat');
% Id = imread('result_HTNet/lena_L4_ours.png');
% load('SAR_test_mat/satellite1_L4.mat');
% Id = imread('result_HTNet/satellite1_L4_ours.png');
% load('SAR_test_mat/satellite2_L4.mat');
% Id = imread('result_HTNet/satellite2_L4_ours.png');

% load('SAR_test_mat/synthetic_L4.mat');
% Id = imread('result_HTNet/synthetic_L4_ours.png');


% load('SAR_image2/L1/Article3_L1.mat');
% Id = imread('result_HTNet/Article3_L1adv.png');

Io = Io;
In = INoisy;
adv_n = Adv_N;
if(ndims(Io) == 3)
    Io = rgb2gray(Io);
end
if(ndims(Id) == 3)
    Id = rgb2gray(Id);
end;% 选择一个颜色矩阵,并且变成双浮点型的,这一步没有可能报错.
figure(1), imshow(Io,[],'Border','tight');
figure(2), imshow(Id,[],'Border','tight');
Io=double(Io)*255.0;
Id=double(Id);
In = double(In)*255.0;
adv_n=double(adv_n)*255.0;
 [RI CI] = size(Io);
%%%%%%%%%%%%%%%%%%%%%%%%%%
%下面是IP-NDE的参数%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  alpha=1.2;q=1.0;dt=0.2;iter=63; sigma=0.7,lamba=0.05,k=0.2;%div2, texture2 %L1 16.7457   0.5232
% alpha=1.1;q=1.0;dt=0.2;iter=32; sigma=0.4,lamba=0.01,k=0.2;%div2, texture2 % L4 19.5771  0.7447
%  alpha=1.4;q=1.1;dt=0.2;iter=62; sigma=0.5,lamba=0.1,k=0.3;%div2, texture2 %L10  21.7313  0.8468

%  alpha=1.4;q=1.0;dt=0.2;iter=125; sigma=0.7,lamba=0.1,k=0.3;%div2, aerial_L1   24.9086 0.6322
%  alpha=1.1;q=1.2;dt=0.2;iter=93; sigma=0.2,lamba=0.06,k=0.3;%div2, aerial_L4   27.4745 0.7856
% alpha=1.4;q=1.3;dt=0.2;iter=134; sigma=0.2,lamba=0.1,k=0.3;%div2, aerial_L10   29.3763  0.8585

%  alpha=1.3;q=1.4;dt=0.2;iter=747; sigma=0.9,lamba=0.1,k=0.7;%div2, Lena_L1  24.5638   0.7979 
%  alpha=1.0;q=1.5;dt=0.2;iter=269; sigma=0.5,lamba=0.1,k=0.3;%div2, Lena_L4  26.6396   0.8676
%  alpha=1.2;q=1.4;dt=0.2;iter=128; sigma=0.5,lamba=0.1,k=0.3;%div2, Lena_L10    28.3831 0.9015

%  alpha=0.9;q=1.1;dt=0.2;iter=51; sigma=0.7,lamba=0.2,k=0.1;%div2, satellite1_L1  21.37   
%  alpha=0.9;q=1.0;dt=0.2;iter=27; sigma=0.4,lamba=0.25,k=0.1;%div2, satellite1_L4  23.89  
 alpha=0.9;q=1.0;dt=0.2;iter=39; sigma=0.2,lamba=0.08,k=0.3;%div2, satellite1_L10    25.88




% alpha=1.0;q=0.8;
% dt=0.24;iter=200; sigma=1,lamba=0;
% alpha=0.7;q=0.7;
% dt=0.24;iter=55; sigma=1;
% alpha=1.5;q=2.0;
% dt=0.24;iter=3500; sigma=1,lamba=0;%div2, texture1

% alpha=1.4;q=1.0;dt=0.2;iter=2000; sigma=0.7,lamba=1,k=0.01;%div2, aerial_L1   24.9086 0.6322
%%  
tic;
[SSIMAll, IM_MAE,PSNRAll,J]=multi_2(Io,adv_n,Id,iter,dt,sigma,alpha,q,lamba,k);
%[IM_MAE,PSNRAll,J]=regular_PM(Io,In,dt,iter,sigma);
time = toc

image_M1=sprintf('result/aerial_L1_DE_PM.png');
imwrite(uint8(J),image_M1);

figure(3), imshow(In,[],'Border','tight');
figure(4), imshow(uint8(In),'Border','tight');
figure(5);
x=1:length(PSNRAll);
plot(x,PSNRAll);
title('PSNRAll');

figure(10);
x=1:length(IM_MAE);
plot(x,IM_MAE);
title('IM_{MAE}');
% J_Z=uint8(J);
% imwrite(J_Z,'Result.bmp','bmp')
% figure(6), imshow(J_Z,'Border','tight');

figure(6), imshow(uint8(J),'Border','tight');
% J_Z=double(J_Z);
% 
% res1=Io-J_Z;
% res2=In./(J+0.000000001);
% res3=J./(Io+0.000000001)-1;

SNROriginal=snr(In,Io)
PSNROriginal=Mpsnr(In,Io)
[MaxPSNR,IndexPSNR]=max(PSNRAll)
[MaxSSIM,IndexSSIM]=max(SSIMAll)
[MinMAE,IndexMAE]=min(IM_MAE)
GOOD=MaxPSNR-PSNROriginal

[Ny,Nx]=size(J); 
x=1:Nx;
level=fix(Ny/3);
y=J(level,:);
y1=Io(level,:);
y2=In(level,:);
y3=Id(level,:);

figure(7);
plot(x,y,x,y1);
title('SmoothImage And OriginalImage')
legend('att-HTNet prior','OriginalImage');


% figure(7);
% subplot(4,1,1); plot(x,y,x,y1);
% title('SmoothImage And OriginalImage')
% legend('SmoothImage','OriginalImage');
% subplot(4,1,2); plot(x,y3,x,y1);
% title('HTnet And OriginalImage')
% legend('HTnet','OriginalImage');
% subplot(4,1,3); plot(x,y,x,y3);
% legend('SmoothImage','HTnet');
% title('HTnet And SmoothImage')
% subplot(4,1,4); plot(x,y,x,y1,x,y3);
% title('NoiseImage , OriginalImage,Htnetadv')
% legend('SmoothImage','OriginalImage','Htnetadv');



axis tight;
set(gca, 'box', 'on')
figure(8);
subplot(3,2,1); imshow(uint8(Io),[]);
title('OriginalImage')
subplot(3,2,2); imshow(uint8(In),[]);
title('NoiseImage')
subplot(3,2,3); imshow(uint8(J),[]);
title('SmoothImage')
subplot(3,2,4); imshow(In./(J+0.000000001),[]);
title('res')
subplot(3,2,5); imshow(uint8(Id),[]);
title('Id')
%%%%%%%%%%%%%保存结果
saveas(8,'results.jpg');



truesize(8)



