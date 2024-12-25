function Is=multi_div2(I,Id, q,sigma,alpha,lamba,k)
I=double(I);
Id=double(Id);

bx=I(:,[2:end end])-I;
by=I([2:end end],:)-I;

% fx=I-I(:,[1 1:end-1]);
% fy=I-I([1 1:end-1],:);

ng=ceil(6*sigma)+1;
Gaussian=fspecial('gaussian',[ng ng],sigma);
Is=imfilter(I,Gaussian);%G*u
Is1=abs(Is);
Iss=(Is1./max(Is1(:))).^(q);
%Iss=(Is.*Is).^(0.5*q);

bxs=Is(:,[2:end end])-Is;
bys=Is([2:end end],:)-Is;

bxd=Id(:,[2:end end])-Id;
byd=Id([2:end end],:)-Id;

fxs=Is-Is(:,[1 1:end-1]);
fys=Is-Is([1 1:end-1],:);

termx=k*lamba*(bxs.^2+minmod(bys,fys).^2).^(alpha/2)+k*(1-lamba)*(bxd.^2+minmod(byd,fys).^2).^(alpha/2)+1;
term1=bx./termx;
term11=term1.*Iss;
term2=by./(lamba*(bys.^2+minmod(bxs,fxs).^2).^(alpha/2)+(1-lamba)*(byd.^2+minmod(bxd,fxs).^2).^(alpha/2)+1);
term22=term2.*Iss;

I1=term11-term11(:,[1 1:end-1]);
I2=term22-term22([1 1:end-1],:);
  
Is=I1+I2;
end