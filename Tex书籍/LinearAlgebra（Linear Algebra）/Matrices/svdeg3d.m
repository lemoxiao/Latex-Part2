% search for a 3x3 SVD, AJR, nov 2014
U=[1,-2,2;2,2,1;-2,1,2]/3
U'*U
V=[-8,-4,-1;-1,4,-8;-4,7,4]'/9
V'*V
% finds this one
A=[ -4   -2    4
    -8   -1   -4
     6    6    0 ]
A=U*diag([12 6 3])*V'

ns=-12:12;
ns=ns(ns!=0);
for a=ns
  for b=ns(abs(ns)!=abs(a))
    for c=ns((abs(ns)!=abs(a))&(abs(ns)!=abs(b)))
    A=U*diag([a,b,c])*V';
    if norm(A-round(A))<1e-9, A=[A [a;b;c]] end
end, end, end
