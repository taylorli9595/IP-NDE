function Is=multi_div_ctr2(I,sigma,alpha)
I=double(I);

bx=I(:,[2:end end])-I;
by=I([2:end end],:)-I;

% fx=I-I(:,[1 1:end-1]);
% fy=I-I([1 1:end-1],:);

ng=ceil(6*sigma)+1;
Gaussian=fspecial('gaussian',[ng ng],sigma);
Is=imfilter(I,Gaussian);
Is=abs(Is);
% Iss=(Is1./max(Is1(:))).^(q);
%Iss=(Is.*Is).^(0.5*q);

bxs=Is(:,[2:end end])-Is;
bys=Is([2:end end],:)-Is;

fxs=Is-Is(:,[1 1:end-1]);
fys=Is-Is([1 1:end-1],:);

termx=((bxs.^2+minmod(bys,fys).^2).^(alpha/2))+1;
term1=bx./termx;
term11=term1;
term2=by./((bys.^2+minmod(bxs,fxs).^2).^(alpha/2)+1);
term22=term2;

I1=term11-term11(:,[1 1:end-1]);
I2=term22-term22([1 1:end-1],:);
  
Is=I1+I2;
end