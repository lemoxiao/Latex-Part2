% matabolism vs mass via SVD.  AJR Feb 2015
% Data digitised from Max Kleiber (1947) Body size and metabolic rate
% Physiological Reviews 27:511-541
% bw=body weight (kg), hp=heat production (kcal/day)
% Predicts hp=62*bw^0.78
format bank
animal=['mouse'
'rat'
'cat'
'dog'
'goat'
'sheep'
'cow'
'elephant']
bw=[ 1.95e-2
     2.70e-1
     3.62e+0
     1.28e+1
     2.58e+1
     5.20e+1
     5.34e+2
     3.56e+3 ]
hp=[ 3.06e+0
     2.61e+1
     1.56e+2
     4.35e+2
     7.50e+2
     1.14e+3
     7.74e+3
     4.79e+4 ]
loglog(bw,hp,'o'), hold on
xlabel('body weight (kg)'), ylabel('heat production (kcal/day)')
A=[ones(size(bw)) log10(bw)]
[U,S,V]=svd(A)
r=2 % rank
% predict area-length power law
z=U'*log10(hp)
y=z(1:r)./diag(S(1:r,1:r))
x=V*y
plot(bw,10.^(x(1)+x(2)*log10(bw))), hold off
%print -depsc2 metabolism

format short
