% read and process the Ada picture 249x178
% hide a message
rgb=imread('Lovelace_Ada.jpg');
size(rgb)
A=mean(rgb,3);
[m,n]=size(A)
[U,S,V]=svd(A); 
s=diag(S);
%figure(2)
%colormap('gray') p=0; for k=2 .^(1:6) p=p+1;subplot(2,3,p)
%imagesc(U(:,1:k)*S(1:k,1:k)*V(:,1:k)') title(['rank '
%num2str(k)]) axis equal, axis off end


% encode info
% 0.95 and 0.03 give 40-60 good bits
r=32, rat0=0.96, rat1=0.03 
x=(rand(n-r,1)>0.5); % hidden info
x=[0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 1 1 0 0 0 1 0 0 0 0 1 1 0 1 0 0 0 1 1 1 1]';
sx=[s(1:r);s(r)*cumprod(rat0+rat1*x)];
rx=length(sx);
B=(U(:,1:rx)*diag(sx)*V(:,1:rx)');
minmax=[min(B(:)) max(B(:))]
B=round(255*(B-minmax(1))/diff(minmax));
[Q,D,R]=svd(B);
d=diag(D);
subplot(2,3,1)
colormap('gray')
imagesc(B)
%title('hidden message')
axis equal, axis off
%print -depsc2 steganographic
imwrite(B/255,'steganographic.png')

%figure(1),semilogy(s,'o',sx,'+',d,'x')

y=(diff(log(d(r:rx)))-log(rat0))/rat1;
thebad=find(round(y)~=x)

