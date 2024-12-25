function [IM_SSIM,IM_MAE,PSNRR,u]=multi_1(Io,In,Id,iter,dt,sigma,alpha,q, lamba,k)

% Id = Id + 20*randn(size(Id));

%得到图像大小
[Ny,Nx]=size(Io); 

a=5;
a1=5;
b=5;
b1=5;
ep=0.00001;

J =In;

for i=1:iter
    


% fx=I-I(:,[1 1:end-1]);
% fy=I-I([1 1:end-1],:);

% ng=ceil(6*sigma)+1;
% Gaussian=fspecial('gaussian',[ng ng],sigma);
% Is=imfilter(I,Gaussian);%G*u
Is = imgaussian(J,sigma,4*sigma);
Is1=abs(Is);

Iss=(Is1./max(Is1(:))).^(q);
% Iss=(abs(Id)./max(Id(:))).^(q);


bx=J(:,[2:end end])-J;
by=J([2:end end],:)-J;

% fx=I-I(:,[1 1:end-1]);
% fy=I-I([1 1:end-1],:);

bxs=Is(:,[2:end end])-Is;
bys=Is([2:end end],:)-Is;

fxs=Is-Is(:,[1 1:end-1]);
fys=Is-Is([1 1:end-1],:);

bxd=Id(:,[2:end end])-Id;
byd=Id([2:end end],:)-Id;
fxd=Is-Id(:,[1 1:end-1]);
fyd=Is-Id([1 1:end-1],:);

termx=k*lamba*(bxs.^2+minmod(bys,fys).^2).^(alpha/2)+k*(1-lamba)*(bxd.^2+minmod(byd,fyd).^2).^(alpha/2)+1;
term1=bx./termx;
term11=term1.*Iss;
term2=by./(k*lamba*(bys.^2+minmod(bxs,fxs).^2).^(alpha/2)+k*(1-lamba)*(byd.^2+minmod(bxd,fxd).^2).^(alpha/2)+1);
term22=term2.*Iss;

I1=term11-term11(:,[1 1:end-1]);
I2=term22-term22([1 1:end-1],:);
  
J_1=I1+I2;

J=J+dt.*J_1;%%%灰度探测和边界探测乘积EFDM


u=max(J-ep,0);
%u=max(In(:))*u;
%  figure(100),
%  imshow(uint8(u))
 J_loc=u(a:(Ny-a1),b:(Nx-b1));
   I_original_loc=Io(a:(Ny-a1),b:(Nx-b1));
   PSNRR(i)=Mpsnr(J_loc,I_original_loc);
   NowPSNR=PSNRR(i)
   NowSNR=snr(J_loc,I_original_loc)
   IM_MAE(i)=M_MAE(J_loc,I_original_loc);
    NowMAE=M_MAE(J_loc,I_original_loc)
   [mssim,map]=ssim(J_loc,I_original_loc);
   IM_SSIM(i) = mssim;
    Now_ssim=mssim
%toc
%t=t+toc;    
%   count = count + 1;
%    
%    J_loc=u(a:(Ny-a1),b:(Nx-b1));
%    I_original_loc=Io(a:(Ny-a1),b:(Nx-b1));
%    PSNRR(count)=Mpsnr(J_loc,I_original_loc);
%    NowPSNR=PSNRR(count)
%    NowSNR=snr(J_loc,I_original_loc)
%    IM_MAE(count)=M_MAE(J_loc,I_original_loc);
%     NowMAE=M_MAE(J_loc,I_original_loc)
%   count = count + 1;
% 
%     count     

end;   