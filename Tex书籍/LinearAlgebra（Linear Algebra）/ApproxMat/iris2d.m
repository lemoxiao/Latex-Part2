% 2D approximation to iris data
format bank
irisinfo
iris=iris(2:5:end,:)
meaniris=mean(iris(:,1:4))
A=iris(:,1:4)-ones(size(iris,1),1)*meaniris;
[U,S,V]=svd(A);
s=diag(S)
V=V
xy=A*V(:,1:2)
plot(xy(iris(:,5)==1,1),xy(iris(:,5)==1,2),'ro' ...
    ,xy(iris(:,5)==2,1),xy(iris(:,5)==2,2),'g+' ...
    ,xy(iris(:,5)==3,1),xy(iris(:,5)==3,2),'bx')
