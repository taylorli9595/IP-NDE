function [IM_SSIM,IM_MAE,PSNRR,u]=multi_3(Io,In,Id,iter,dt,sigma1,sigma2,alpha,q, lamba,k)

%  Id = Id + 20*randn(size(Id));

%得到图像大小
[Ny,Nx]=size(Io); 

a=5;
a1=5;
b=5;
b1=5;
ep=0.00001;

J =In;

for i=1:iter
    


Is = imgaussian(J,sigma1,4*sigma1);
Ism = imgaussian(J,sigma2,4*sigma2);
Is1=abs(Ism);

Iss=(Is1./max(Is1(:))).^(alpha);
% Iss=(abs(Id)./max(Id(:))).^(q);

    cnx = J([1 1:end-1],:) - J;
    csx =J([2:end end],:) - J;
    cwx = J(:, [1 1:end-1]) -J;
    cex =J(:, [2:end end]) - J;
    
    cns = Is([1 1:end-1],:) - Is;
    css =Is([2:end end],:) - Is;
    cws = Is(:, [1 1:end-1]) -Is;
    ces =Is(:, [2:end end]) - Is;
    
    cnd = Id([1 1:end-1],:) - Id;
    csd=Id([2:end end],:) - Id;
    cwd = Id(:, [1 1:end-1]) -Id;
    ced =Id(:, [2:end end]) - Id;

      div = 1./(1 + k*lamba * abs(cns).^q + k*(1-lamba) * abs(cnd).^q) .* cnx...
          + 1./(1 + k*lamba * abs(css).^q + k*(1-lamba) * abs(csd).^q) .* csx...
          + 1./(1 + k*lamba * abs(cws).^q + k*(1-lamba) * abs(cwd).^q) .*  cwx...
          + 1./(1 + k*lamba * abs(ces).^q + k*(1-lamba) * abs(ced).^q) .* cex;

J_1= Iss.*div;
  
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
  

end;   