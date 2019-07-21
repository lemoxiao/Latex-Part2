% AJR, Feb 2016
x=dlmread('S06R02.txt');
sizex=size(x)
j=find(x(:,11)==1);
sizewalking=length(j)
dj=ceil(sizewalking/999)
k=j(1:dj:end);% subsample
%plot(x(k,1),x(k,2:7))

% choose a smaller window, here 639 in 10 secs, 1279 in 20 secs
k=j(find(abs(x(j,1)-335000)<5000));
windowk=length(k)
plot(x(k,1),x(k,2:7))
legend(num2str((2:7)'))

% use 3=Ankle (shank) acceleration - vertical [mg]
t=x(k,1)/1000; % in secs
y=(x(k,3)-mean(x(k,3)))/100; % in m/s^2
% subsample
ss=8
n=floor(length(y)/ss)
y=mean(reshape(y(1:ss*n),ss,n))';
t=t(4:ss:ss*n-4)-330;
% now window
w=14
A=hankel(y(1:w),y(w:end));
[U,S,V]=svd(A);
singValues=diag(S)
semilogy(singValues,'o')

% choose rank and form synthetic dataset
rnk=4
plot(U(:,1:rnk))
for i=1:3
A=U(:,1:rnk)*S(1:rnk,1:rnk)*V(:,1:rnk)';
z=round([A(:,1);A(end,2:end)']*100)/100; % series from edge of matrix
A=hankel(z(1:w),z(w:end));
[U,S,V]=svd(A);
end
singValues=diag(S)
plot(singValues,'o')
% plot raw data
plot(t,z,'o-')
xlabel('\text{time (secs)}')
ylabel('\text{acceleration (m/s/s)}')
matlab2tikz('exwgpwpd.ltx')


