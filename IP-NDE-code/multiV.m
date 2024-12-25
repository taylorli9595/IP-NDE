%%ГЫаддыЩљжежЙЬѕМў

function y=multiV(u,f)
[m n]=size(u);
v=zeros(m,n);
for i=1:m
    for j=1:n
        if u(i,j)~=0
            v(i,j)=f(i,j)/u(i,j)-1;
        end
    end
end
y=sum(sum(v.^2))/(m*n);

