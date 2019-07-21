% Find pythagorean quadruplets and quintuplets
% AJR 12 Sep 2013
n=9
[a,b]=ndgrid(1:2*n);
x=sqrt(a.^2+b.^2);
j=find(abs(mod(x,1))<1e-9);
j=j((a(j)<=b(j)));
j=j(gcd(a(j),b(j))==1);
trips=[a(j),b(j),x(j)]

[a,b,c]=ndgrid(1:n);
x=sqrt(a.^2+b.^2+c.^2);
j=find(abs(mod(x,1))<1e-9);
j=j((a(j)<=b(j))&(b(j)<=c(j)));
j=j(gcd(a(j),b(j),c(j))==1);
quads=[a(j),b(j),c(j),x(j)]

[a,b,c,d]=ndgrid(1:n);
x=sqrt(a.^2+b.^2+c.^2+d.^2);
j=find(abs(mod(x,1))<1e-9);
j=j((a(j)<=b(j))&(b(j)<=c(j))&(c(j)<=d(j)));
j=j(gcd(a(j),b(j),c(j),d(j))==1);
quins=[a(j),b(j),c(j),d(j),x(j)]
