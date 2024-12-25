function [IM_MAE,PSNRR,u]=multi(Io,In,Id,iter,dt,sigma,alpha,q, lamba,k)
In=double(In);
%得到图像大小
[Ny,Nx]=size(Io); 

a=5;
a1=5;
b=5;
b1=5;
ep=0.00001;
Is=In;
Gn = Id;
% Is=max(In./(max(max(In))),ep);%f归一化
%t=0;

for i=1:iter
i    
%tic    
%  Is=Is+dt.*multi_div2(Is,Gn,q,sigma,alpha,lamba,k);%%%灰度探测和边界探测乘积EFDM
Is=Is+dt.*multi_div4(Is,Gn,q,sigma,alpha,lamba,k);%%%灰度探测和边界探测乘积EFDM
% Is=Is+dt.*multi_div_EM(Is,q,sigma,k,alpha);
%Is=Is+dt.*multi_div_ctr(Is,q,sigma,k,alpha);
% Is=Is+dt.*multi_div_ctr2(Is,sigma,alpha);

u=max(Is-ep,0);
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