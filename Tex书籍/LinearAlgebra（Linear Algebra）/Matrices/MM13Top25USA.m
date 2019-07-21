% AJR, 15 Feb 2016
d=dlmread("MM13Top25USA.txt","\t");
d=d(:,1:2:end);
d(:,1:4)=d(:,1:4)/1000% convert to M$ instead of k$
[m,n]=size(d)

% find the triple that best predict ranking
ranks=(1:m)';
ijk=[];
resijk=1e99; 
for i=1:n-2,for j=i+1:n-1,for k=j+1:n
A=[d(:,[i,j,k]) ones(m,1)];
res=norm(ranks-A*(A\ranks)); 
if res<resijk,
resijk=res
ijk=[i,j,k]
end
end,end,end

% find there a subset where predicts do well
% and sufficiently far apart in list?
A=[d(:,ijk) ones(m,1)];
x0=A\ranks
res=abs(ranks-A*x0);
%hist(res)
good=[];
j=1:m;
while (length(good)<9) & (length(j)>0)
[~,i]=min(res(j));i=j(i);
j(abs(j-i)<4)=[];
good=sort([good i])
end

% what about the fit to these nine
m=length(good)
ranks=(1:m)';
A=[d(good,ijk(1:2)) ones(m,1)];
xgood2=A\ranks
res2=ranks-A*xgood2
A=[d(good,ijk) ones(m,1)];
xgood=A\ranks
res=ranks-A*xgood


% What if we recognise matrix errors, with annual give and PhD
%ii=[ijk 4 7]
%A=[d(good,ii) ones(m,1)]
