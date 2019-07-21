% SVD approx to pixel alphabet
format bank
A=[ 0 0 1 0 0
    0 1 0 1 0
    1 0 0 0 1
    1 1 1 1 1
    1 0 0 0 1
    1 0 0 0 1
    1 0 0 0 1 ];
B=[ 1 1 1 1 0
    1 0 0 0 1
    1 0 0 0 1
    1 1 1 1 0
    1 0 0 0 1
    1 0 0 0 1
    1 1 1 1 0 ];
C=[ 0 1 1 1 0
    1 0 0 0 1
    1 0 0 0 0
    1 0 0 0 0
    1 0 0 0 0
    1 0 0 0 1
    0 1 1 1 0 ];
G=[ 0 1 1 1 0
    1 0 0 0 1
    1 0 0 0 0
    1 0 0 0 0
    1 0 0 1 1
    1 0 0 0 1
    0 1 1 1 0 ]; % good 4
K=[ 1 0 0 0 1
    1 0 0 1 0
    1 0 1 0 0
    1 1 0 0 0
    1 0 1 0 0
    1 0 0 1 0
    1 0 0 0 1 ]; % fair 4
L=[ 1 0 0 0 0
    1 0 0 0 0
    1 0 0 0 0
    1 0 0 0 0
    1 0 0 0 0
    1 0 0 0 0
    1 1 1 1 1 ];
Q=[ 0 1 1 1 0
    1 0 0 0 1
    1 0 0 0 1
    1 0 0 0 1
    1 0 1 0 1
    1 0 0 1 1
    0 1 1 1 1 ];
R=[ 1 1 1 1 0
    1 0 0 0 1
    1 0 0 0 1
    1 1 1 1 0
    1 0 1 0 0
    1 0 0 1 0
    1 0 0 0 1 ]; % fair 4
S=[ 0 1 1 1 0
    1 0 0 0 0
    1 0 0 0 0
    0 1 1 1 0
    0 0 0 0 1
    0 0 0 0 1
    1 1 1 1 0 ];

A=G, name='G'
fPgfImage([name '.ltx'],A);
[U,S,V]=svd(A)
s=diag(S)
%figure(1),clf()
%plot(s,'o')
%ylabel('singular values')
%matlab2tikz('pixelA.tex')
%figure(2),clf()
%colormap('gray')
for k=1:4
  %subplot(2,4,k)
  Ak=U(:,1:k)*S(1:k,1:k)*V(:,1:k)'
  fPgfImage([name num2str(k) '.ltx'],Ak);
  %imagesc(1-Ak)
  %title(['rank ' num2str(k)])
  %axis equal, axis off
end
%print -dpng 'pixelA'
