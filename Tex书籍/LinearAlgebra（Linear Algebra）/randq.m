function q=randq(n)
% Generate random orthogonal matrix of size nxn for n<5.
% AJR, 25 Jan 2016
orthomats
qs=qss{n};
q=qs{ceil(rand*length(qs))};
q=q(randperm(n),randperm(n));
q=diag(sign(randn(1,n)))*q*diag(sign(randn(1,n)))+0;
if abs(norm(q'*q-eye(n)))>1e-9, oopsBadOrthoMat=q, end
