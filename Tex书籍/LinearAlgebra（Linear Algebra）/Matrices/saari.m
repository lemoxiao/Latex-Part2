% Saari (2015) voting paradox
% AJR, Nov 2015
A=[ones(5,1)*[-1 0 0] diag([2 1 0 0 1]) eye(5)
   ones(5,1)*[0 -1 0] diag([1 0 1 2 2]) eye(5)
   ones(5,1)*[0 0 -1] diag([0 2 2 1 0]) eye(5)
  ]
format bank
wts=sqrt([2 6 4 4 3])
A=diag([wts wts wts])*A
[U,S,V]=svd(A)
