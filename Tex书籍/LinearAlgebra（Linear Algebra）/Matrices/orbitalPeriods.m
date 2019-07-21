% planetary orbital periods via SVD.  AJR Nov 2014
% from Holt, 2013, p.40
format bank
dp=[
      57.91     87.97
     108.21    224.70
     149.60    365.26
     227.94    686.97
     778.55   4332.59
    1433.45  10759.22
    2870.67  30687.15
    4498.54  60190.03
];
% semi-major axis in Gigametres
d=dp(:,1)
% period in days
p=dp(:,2) 
loglog(d,p,'o'), hold on
xlabel('distance (Gigametres)')
ylabel('orbital period (days)')
n=7
A=[ones(n,1) log10(d(1:n))]
[U,S,V]=svd(A)
r=2 % rank
% predict white females
format short
z=U'*log10(p(1:n))
y=z(1:r)./diag(S(1:r,1:r))
x=V*y
xSlosh=A\log10(p(1:n))
loglog(d,10.^(x(1)+x(2)*log10(d))), hold off
%print -depsc2 orbitalPeriods

