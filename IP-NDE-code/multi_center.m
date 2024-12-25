function Is=multi_center(I,q,sigma,alpha)
I=double(I);

bx = (I(:,[2:end end])-I(:,[1 1:end-1]))/2;
by = (I([2:end end],:)-I([1 1:end-1],:))/2;

% fx=I-I(:,[1 1:end-1]);
% fy=I-I([1 1:end-1],:);

ng=ceil(6*sigma)+1;
Gaussian=fspecial('gaussian',[ng ng],sigma);
Is=imfilter(I,Gaussian);
Is1=abs(Is);
Iss=(Is1./max(Is1(:))).^(q);
%Iss=(Is.*Is).^(0.5*q);

bxs = (Is(:,[2:end end])-Is(:,[1 1:end-1]))/2;
bys = (Is([2:end end],:)-Is([1 1:end-1],:))/2;
 
term=((bxs.^2+bys.^2).^(alpha/2))+1;
s1=(bx./term).*Iss;
s2=(by./term).*Iss;

I1 = (s1(:,[2:end end])-s1(:,[1 1:end-1]))/2;
I2 = (s2([2:end end],:)-s2([1 1:end-1],:))/2;
Is=I1+I2;