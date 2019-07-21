% Find m points in nD given that you know their distance
% matrix and given that the mean location is precisely zero
% (Hopcroft & Kannan, 2014, p.83).  AJR Feb 2015.
m=9
n=2
X=randn(m,n); % but force mean zero
X=X-ones(m,1)*mean(X)
plot(X(:,1),X(:,2),'o'),hold on
axis equal
DD=zeros(m,m); o=ones(m,1);
for j=1:n, DD=DD+(X(:,j*o)-X(:,j*o)').^2; end

% corrupt the distance matrix: remarkably insensitive
Z=randn(m); Z=(Z+Z')/sqrt(2);
DD=DD.*exp(0.1*Z); 

% given the distance matrix DD, magic formula from Hopcroft
dd=mean(DD);
XXT=-0.5*(DD-o*dd-dd'*o'+mean(dd))
theerror=norm(XXT-X*X')

% use the (n) non-zero eigenvalues
[V,D]=eig((XXT+XXT')/2); % make exact symmetry
evals=sort(diag(D))
j=m-n+1:m
Y=V(:,j)*diag(sqrt(evals(j)))
plot(Y(:,1),Y(:,2),'r+')

% rotate/reflect to match
% possibly non-orthog Q helps improve the comparison
Q=Y\X
roterror=norm(Q'*Q-eye(n))
Z=Y*Q;
plot(Z(:,1),Z(:,2),'gx')

hold off