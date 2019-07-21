% read and process the Euler picture
rgb=imread('euler1737.png');
A=double(rgb(:,:,1));
[U,S,V]=svd(A); 
figure(1)
s=diag(S);
loglog(1:276,s(1:276),'o')
ylabel('singular values')
print -depsc2 'euler1737sing'
%matlab2tikz('euler1737sing.tex')
figure(2)
colormap('gray')
ranks=[3 10 30 277];
for p=1:4
  k=ranks(p)
  subplot(2,2,p)
  imagesc(U(:,1:k)*S(1:k,1:k)*V(:,1:k)')
  title(['rank ' num2str(k)])
  axis equal, axis off
end
print -depsc2 'euler1737rank'
