function I=regular_div(I,sigma)

I=double(I);
bx=I(:,[2:end end])-I;
by=I([2:end end],:)-I;

% fx=I-I(:,[1 1:end-1]);
% fy=I-I([1 1:end-1],:);

ng=ceil(6*sigma)+1;
Gaussian=fspecial('gaussian',[ng ng],sigma);
Is=imfilter(I,Gaussian);

%Iss=(Is.*Is).^(0.5*q);

bxs=Is(:,[2:end end])-Is;
bys=Is([2:end end],:)-Is;

fxs=Is-Is(:,[1 1:end-1]);
fys=Is-Is([1 1:end-1],:);

termx=((bxs.^2+minmod(bys,fys).^2))+1;
term1=bx./termx;
term2=by./((bys.^2+minmod(bxs,fxs).^2)+1);


I1=term1-term1(:,[1 1:end-1]);
I2=term2-term2([1 1:end-1],:);

  
I=I1+I2;
end
