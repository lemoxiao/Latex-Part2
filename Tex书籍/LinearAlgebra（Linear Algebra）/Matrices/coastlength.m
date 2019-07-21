% west coast britain length vs measure via SVD.  AJR Feb 2015
% Digitised: Mandelbrot, Fractal Geometry of Nature, Plate 33
% Predicts coast=4980*stick^(-0.26)
format bank
stick=[  10.4
         30.2
         99.6
        202.
        532.
        933. ]
coast=[ 2845
        2008
        1463
        1138
         929
         914 ]
loglog(stick,coast,'o'), hold on
xlabel('measuring stick (km)'), ylabel('coast length (km)')
A=[ones(size(stick)) log10(stick)]
[U,S,V]=svd(A)
r=2 % rank
% predict stick-coast power law
z=U'*log10(coast)
y=z(1:r)./diag(S(1:r,1:r))
x=V*y
plot(stick,10.^(x(1)+x(2)*log10(stick))), hold off
%print -depsc2 metabolism

format short
