clear all
close all
Io=imread('Image\Multi_N2.bmp');

if(ndims(Io) == 3)
    Io = rgb2gray(Io);
end;% ѡ��һ����ɫ����,���ұ��˫�����͵�,��һ��û�п��ܱ���.
figure(1), imshow(Io,'Border','tight');
Io=double(Io);
[m,n]=size(Io);
% x={1/(m):1/(m):1};
% 
% for i=1:m
%  x{i}=Io(i,:);%��Io
% end
TFORM.tdata.Tinv=[1/m    0         0
     0    1/n         0
     0 0    1.0000]
 tform = maketform('affine',TFORM.tdata.Tinv);

IB=imread('rice.png');
 IBT=imtransform(IB,tform);
  imshow(IBT)
