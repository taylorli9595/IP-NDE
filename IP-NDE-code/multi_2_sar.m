function [J]=multi_2_sar(In,Id,iter,dt,sigma,alpha,q, lamba,k)

%  Id = Id + 20*randn(size(Id));

%得到图像大小

a=5;
a1=5;
b=5;
b1=5;
ep=0.06;

J =In;
MV=multiV(In,In);  %调停条件
i=1;
while MV<ep
Is = imgaussian(J,sigma,4*sigma);
Is1=abs(Is);

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

 MV=multiV(real(J),In);  
i=i+1;
end;   