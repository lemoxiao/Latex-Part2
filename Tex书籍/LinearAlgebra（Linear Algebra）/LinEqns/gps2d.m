% GPS determines location in 2D, for secIntro
% AJR Mar 2015
data=[25 29 10;20 17 19;17 13 18];
%data=[25 7 30;26 10 30;29 20 27]; % most sensitive to errors
%data=[25 11 29;26 28 15;20 16 21];
%data=[20 22 12;26 16 24;29 26 21];
%data=[17 12 21;25 10 29;26 27 15]  % should be 17 11 20
%data=[17 11 20;25 10 29;26 27 15]  

ls=data(:,1);xs=data(:,2);ys=data(:,3);
A=[-2*xs(1:2)+2*xs(3) -2*ys(1:2)+2*ys(3)]
b=ls(1:2).^2-xs(1:2).^2-ys(1:2).^2-ls(3)^2+xs(3)^2+ys(3)^2
x=A\b

sval=svd(A)'
err=0.01
format bank
for k=1:4
xs=data(:,2)+err*randn(3,1); 
ys=data(:,3)+err*randn(3,1); 
ls=data(:,1)+err*randn(3,1);
Ad=[-2*xs(1:2)+2*xs(3) -2*ys(1:2)+2*ys(3)]
bd=ls(1:2).^2-xs(1:2).^2-ys(1:2).^2-ls(3)^2+xs(3)^2+ys(3)^2
xd=(Ad\bd)'
end
format short
