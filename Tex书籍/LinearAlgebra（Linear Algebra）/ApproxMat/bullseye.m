% approximate a bulls eye
A=[0 1 1 1 0
   1 0 0 0 1
   1 0 1 0 1
   1 0 0 0 1
   0 1 1 1 0]
[U,S,V]=svd(A)
A3=U(:,1:3)*S(1:3,1:3)*V(:,1:3)'
A2=U(:,1:2)*S(1:2,1:2)*V(:,1:2)'
s=diag(S)
fPgfImage('bullseye.ltx',A);
fPgfImage('bullseye2.ltx',A2);
