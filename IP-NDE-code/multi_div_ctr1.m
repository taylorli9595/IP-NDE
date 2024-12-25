function Is=multi_div_ctr1(I,q,sigma,k,alpha)
%%
%新的边界探测函数1/(1+k(grad(G*U/M)^(q)*255)^(alpha))
%对比它与正则化PM的效果

I=double(I);

bx=I(:,[2:end end])-I;
by=I([2:end end],:)-I;

% fx=I-I(:,[1 1:end-1]);
% fy=I-I([1 1:end-1],:);

ng=ceil(6*sigma)+1;
Gaussian=fspecial('gaussian',[ng ng],sigma);
Is=imfilter(I,Gaussian);
U=abs(Is./max(Is(:))).^(q);
Iss=U.*255;
%Iss=(Is.*Is).^(0.5*q);

bxs=Iss(:,[2:end end])-Iss;
bys=Iss([2:end end],:)-Iss;

fxs=Iss-Iss(:,[1 1:end-1]);
fys=Iss-Iss([1 1:end-1],:);

termx=((bxs.^2+minmod(bys,fys).^2).^(alpha/2)).*k+1;
term1=bx./termx;
term2=by./((bys.^2+minmod(bxs,fxs).^2).^(alpha/2).*k+1);

I1=term1-term1(:,[1 1:end-1]);
I2=term2-term2([1 1:end-1],:);
  
Is=I1+I2;
end