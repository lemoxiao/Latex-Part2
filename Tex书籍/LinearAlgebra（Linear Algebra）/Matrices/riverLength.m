% river length via SVD.  AJR Feb 2015
% VI Arnold, Math Understanging of Nature, p.154
% length is in km, area in km^2, Hack's exponent = 0.58
% Here predict length=1.53(area)^0.58
format bank
river=['Moscow'
'Protva'
'Vorya'
'Dubna'
'Istra'
'Nara'
'Pakhra'
'Skhodnya'
'Volgusha'
'Pekhorka'
'Setun'
'Yauza']
length=[502;275;99;165;112;156;129;47;40;42;38;41]
area=[17640;4640;1160;5474;2120;2170;2720;259;265;513;187;452]
loglog(area,length,'o'), hold on
xlabel('area (km^2)'), ylabel('length (km)')
% using area in km^2
A=[ones(size(area)) log10(area)]
[U,S,V]=svd(A)
r=2 % rank
% predict area-length power law
z=U'*log10(length)
y=z(1:r)./diag(S(1:r,1:r))
x=V*y
plot(area,10.^(x(1)+x(2)*log10(area))), hold off
%print -depsc2 riverLength

format short
