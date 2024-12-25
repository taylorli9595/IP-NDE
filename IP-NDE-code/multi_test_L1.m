clear all
close all
clc
load('SAR_test_mat/texture2_L1.mat');
Id = imread('result_HTNet/texture2_L1_ours.png');

% load('SAR_test_mat/texture1_L4.mat');
% Id = imread('result_HTNet/texture1_L4_ours.png');
% load('SAR_test_mat/lena_L4.mat');
% Id = imread('result_HTNet/lena_L4_ours.png');
% load('SAR_test_mat/satellite1_L4.mat');
% Id = imread('result_HTNet/satellite1_L4_ours.png');
% load('SAR_test_mat/satellite2_L4.mat');
% Id = imread('result_HTNet/satellite2_L4_ours.png');
% load('SAR_test_mat/synthetic_L4.mat');
% Id = imread('result_HTNet/synthetic_L4_ours.png');


Io = I;
In = f;
if(ndims(Io) == 3)
    Io = rgb2gray(Io);
end;% 选择一个颜色矩阵,并且变成双浮点型的,这一步没有可能报错.
figure(1), imshow(Io,[],'Border','tight');
Io=double(Io);
Id=double(Id);
 [RI CI] = size(Io);
alpha=1.3;q=1.6;dt=0.24;iter=3000; sigma=1,lamba=0.1,k=1;%div2, texture2
% alpha=1.2;q=1.6;dt=0.24;iter=18; sigma=1,lamba=0,k=0.005;%div2, texture2
% alpha=1.5;q=2.0;dt=0.24;iter=2370; sigma=1,lamba=0;%div2, texture1
% alpha=1.0; q=1.1;dt=0.24;iter=194; sigma=1,lamba=0;%div2, aerial
% alpha=1.3; q=1.2;dt=0.24;iter=465; sigma=1,lamba=0;%div2, lena
% alpha=0.9; q=0.9;dt=0.24;iter=119; sigma=1,lamba=0;%satellite1
% alpha=1.2; q=1.2;dt=0.24;iter=403; sigma=1,lamba=0;%satellite2
% alpha=1.1; q=1.5;dt=0.24;iter=2000; sigma=1,lamba=0.5;%synthetic

% alpha=1.0;q=0.8;
% dt=0.24;iter=200; sigma=1,lamba=0;
% alpha=0.7;q=0.7;
% dt=0.24;iter=55; sigma=1;
% alpha=1.5;q=2.0;
% dt=0.24;iter=3500; sigma=1,lamba=0;%div2, texture1
%%  
tic;
[IM_MAE,PSNRAll,J]=multi(Io,In,Id,iter,dt,sigma,alpha,q,lamba,k);
%[IM_MAE,PSNRAll,J]=regular_PM(Io,In,dt,iter,sigma);
toc;
image_M1=sprintf('result/synthetic_L1_DE.png');
imwrite(uint8(J),image_M1);

figure(2), imshow(In,[],'Border','tight');
figure(3), imshow(uint8(In),'Border','tight');
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
subplot(4,1,1); plot(x,y,x,y1);
title('SmoothImage And OriginalImage')
legend('SmoothImage','OriginalImage');
subplot(4,1,2); plot(x,y3,x,y1);
title('HTnet And OriginalImage')
legend('HTnet','OriginalImage');
subplot(4,1,3); plot(x,y,x,y3);
legend('SmoothImage','HTnet');
title('HTnet And SmoothImage')
subplot(4,1,4); plot(x,y,x,y1,x,y2,x,y3);
title('NoiseImage And OriginalImage')



axis tight;
set(gca, 'box', 'on')
figure(8);
subplot(3,2,1); imshow(uint8(Io));
title('OriginalImage')
subplot(3,2,2); imshow(uint8(In));
title('NoiseImage')
subplot(3,2,3); imshow(uint8(J));
title('SmoothImage')
subplot(3,2,4); imshow(In./(J+0.000000001),[]);
title('res')
subplot(3,2,5); imshow(uint8(Id),[]);
title('Id')
%%%%%%%%%%%%%保存结果
saveas(8,'results.jpg');



truesize(8)



