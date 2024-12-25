clear all
close all
Io=imread('Image\Multi_N2.bmp');

if(ndims(Io) == 3)
    Io = rgb2gray(Io);
end;% 选择一个颜色矩阵,并且变成双浮点型的,这一步没有可能报错.
figure(1), imshow(Io,'Border','tight');
Io=double(Io);
[m,n]=size(Io);
% x={1/(m):1/(m):1};
% 
% for i=1:m
%  x{i}=Io(i,:);%对Io
% end
TFORM.tdata.Tinv=[1/m    0         0
     0    1/n         0
     0 0    1.0000]
 tform = maketform('affine',TFORM.tdata.Tinv);

IB=imread('rice.png');
 IBT=imtransform(IB,tform);
  imshow(IBT)
