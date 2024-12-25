function  [IM_MAE,PSNRR,u]=regular_PM(Io,In,tau,iter,sigma)
In=double(In);
[Ny,Nx]=size(In); 

a=5;
a1=5;
b=5;
b1=5;
ep=0.00001;
Is=In;
for i=1:iter
Is=Is+regular_div(Is,sigma).*tau;
u=max(Is-ep,0);

% figure(100),
% imshow(uint8(u))
 J_loc=u(a:(Ny-a1),b:(Nx-b1));
   I_original_loc=Io(a:(Ny-a1),b:(Nx-b1));
   PSNRR(i)=Mpsnr(J_loc,I_original_loc);
   NowPSNR=PSNRR(i)
   NowSNR=snr(J_loc,I_original_loc)
   IM_MAE(i)=M_MAE(J_loc,I_original_loc);
    NowMAE=M_MAE(J_loc,I_original_loc)
    i
end

