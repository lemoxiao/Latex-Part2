% one layer neural network via SVD.  AJR Dec 2014
format bank
n=5
t=linspace(0,6,n)'
s=sort(sin(rand(1,n)*pi/2).^2)'
plot(t,s,'o'),hold on
m=7
d=linspace(1,5,m)
[D,T]=meshgrid(d,t)
A=1 ./(1+exp(T-D))
[U,S,V]=svd(A)
r=min(m,n) % rank
z=U'*s
y=z(1:r)./diag(S(1:r,1:r))
x=V(:,1:r)*y
%condy=condest(A),xSlosh=A\t
[D,T]=meshgrid(d,linspace(0,6));
ss=(1 ./(1+exp(T-D)))*x;
plot(T(:,1),ss), hold off
%print -depsc2 neuralNetwork

