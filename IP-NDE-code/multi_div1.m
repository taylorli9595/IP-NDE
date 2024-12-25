function I=multi_div1(I,q,sigma,alpha)
I=double(I);

bx=I(:,[2:end end])-I;
by=I([2:end end],:)-I;

fx=I-I(:,[1 1:end-1]);
fy=I-I([1 1:end-1],:);

ng=ceil(6*sigma)+1;
Gaussian=fspecial('gaussian',[ng ng],sigma);
Is=abs(imfilter(I,Gaussian));
Iss=(Is./max(Is(:))).^(q);
%Iss=(Is.*Is).^(0.5*q);

termx=((bx.^2+minmod(by,fy).^2).^(alpha/2))+1;
term1=bx./termx;
term11=term1.*Iss;
term2=by./((by.^2+minmod(bx,fx).^2).^(alpha/2)+1);
term22=term2.*Iss;

I1=term11-term11(:,[1 1:end-1]);
I2=term22-term22([1 1:end-1],:);

  
I=I1+I2;
end
