% rank four teams after a round robin of six games
% generate the random results and solve the least square
% ratings via SVD.  AJR Nov 2014 -- Feb 2016
n=6
% find difference in game scores
rates=(n+1-(1:n))*0.5;
[i,j]=meshgrid(rates);
R=round(max(0,j-i)+randn(n));
R=R-min(R(:))+diag(nan(n,1));
scores=[nan 1:n;(1:n)' R]
R=R-R'
%
% form matrix and rhs from model 
[i,j]=meshgrid(1:n);
k=find(i>j);
l=length(k);
A=-sparse(1:l,i(k),1,l,n) ...
  +sparse(1:l,j(k),1,l,n);
A=full(A)
b=R(k)
%
% solve the svd problem
format bank
[U,S,V]=svd(A)
z=U'*b
r=sum(diag(S)>1e-8)
y=z(1:r)./diag(S(1:r,1:r))
x=V(:,1:r)*y
format short
