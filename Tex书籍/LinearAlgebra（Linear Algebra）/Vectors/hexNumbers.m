u=[1 0]
v=[1 sqrt(3)]/2
for n=0:4
[i,j]=meshgrid(-n:n);
k=find(abs(i+j)<=n);
w=i(k)*u+j(k)*v
end
plot(w(:,1),w(:,2),'o')
