% search for a 3x4 rank 2 SVD, AJR, nov 2014
U=[6 3 2;2 -6 3; -3 2 6]/7
U'*U
V=[1 1 1 1;1 -1 1 -1; 1 1 -1 -1 ; 1 -1 -1 1]/2
V'*V
% finds this one

ns=-28:28;
ns=ns(ns~=0);
for a=ns
  for b=ns(abs(ns)~=abs(a))
    for c=0%ns((abs(ns)~=abs(a))&(abs(ns)~=abs(b)))
    A=U*[diag([a,b,c]) zeros(3,1)]*V';
    if norm(A-round(A*2)/2)<1e-9, A=[A [a;b;c]], end
end, end, end

% try this one
A=[ -9   -15    -9   -15
   -10     2   -10     2
     8     4     8     4 ]
[U,S,V]=svd(A)
