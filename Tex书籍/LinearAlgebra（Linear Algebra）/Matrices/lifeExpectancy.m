% life expectancy via SVD.  AJR Nov 2014
% from http://www.infoplease.com/ipa/A0005140.html
format bank
year=(1951:10:2011)'
wm=[66.3;67.5;67.9;70.8;72.9;75.0;76.3]
wf=[72.0;74.2;75.5;78.2;79.6;80.2;81.1]
plot(year,wf,'o',year,wm,'+'), hold on
xlabel('year'), ylabel('life expectancy M/F')
legend(2,'female','male')
% measure time in decades
t=(year-1951)/10;
A=[ones(length(t),1) t]
[U,S,V]=svd(A)
r=2 % rank
% predict white females
z=U'*wf
y=z(1:r)./diag(S(1:r,1:r))
x=V*y
plot(year,x(1)+x(2)*t), hold off
wf2021=x(1)+x(2)*7
%print -depsc2 lifeExpectancy

format short
