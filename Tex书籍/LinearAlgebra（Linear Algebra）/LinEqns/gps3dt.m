% GPS determines location in space-time, for secSolve
% AJR Mar 2015
switch 2
case 1 % worked example
data=[6 12 23 12
  13 20 12 12
  17 14 10 10
  8 21 10 10
  22 9 8 12]; 
case 2 % singular case
data=[17 11 17 9
19 12 14 9
20 10 9 7
9 13 21 9
7 24 8 9]; 
case 3 % OK
data=[17 11 17 9
11 20 14 9
20 10 9 7
9 13 21 9
7 24 8 9]; 
case 4 % OK
data=[11 12 18 30
18 6 19 32
11 19 9 30
9 10 22 32
23 3 9 30]; 
end

%data=data(randperm(5),:)
  
%data(ceil(5*rand),ceil(4*rand))+=1e-5 % gets 10m accuracy or so

ts=data(:,4);xs=data(:,1);ys=data(:,2);zs=data(:,3);
A=[-2*xs(1:4)+2*xs(5) -2*ys(1:4)+2*ys(5) -2*zs(1:4)+2*zs(5) -2*ts(1:4)+2*ts(5) ]
b=ts(1:4).^2-xs(1:4).^2-ys(1:4).^2-zs(1:4).^2 ...
  -ts(5)^2+xs(5)^2+ys(5)^2+zs(5)^2
checkrcond=rcond(A)
x=A\b
radius=norm(x(1:3))

%metres=(x-[2;4;4;9])*1e6

sval=svd(A)'
err=0.01
format bank
for k=1:4
ts=data(:,4)+err*randn(5,1);
xs=data(:,1)+err*randn(5,1);
ys=data(:,2)+err*randn(5,1);
zs=data(:,3)+err*randn(5,1);
Ad=[-2*xs(1:4)+2*xs(5) -2*ys(1:4)+2*ys(5) -2*zs(1:4)+2*zs(5) -2*ts(1:4)+2*ts(5) ];
bd=ts(1:4).^2-xs(1:4).^2-ys(1:4).^2-zs(1:4).^2 ...
  -ts(5)^2+xs(5)^2+ys(5)^2+zs(5)^2;
xd=(Ad\bd)';
xreg=((Ad'*Ad+0.1*eye(4))\(Ad'*bd))'
end
format short
