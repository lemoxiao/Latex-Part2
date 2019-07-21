% read and process the Ada picture 249x178
rgb=imread('Lovelace_Ada.jpg');
size(rgb)
A=mean(rgb,3);
[U,S,V]=svd(A); 
figure(1)
s=diag(S);
semilogy(s,'o')
ylabel('singular values')
rank5=max(find(s>0.05*s(1)))
rank1=max(find(s>0.01*s(1)))
%print -depsc2 'lovelacesing'
%matlab2tikz('lovelacesing.tex')
figure(2)
colormap('gray')
p=0;
for k=2 .^(1:6)
  p=p+1;subplot(2,3,p)
  imagesc(U(:,1:k)*S(1:k,1:k)*V(:,1:k)')
  title(['rank ' num2str(k)])
  axis equal, axis off
end
%print -depsc2 'lovelacerank'
