% an octave script to try SSA analysis of yearly SOI data.
% but smooth the data to only four principle components
% for teaching purposes.
% AJR April 2015
format bank

soiData % input the orignal data

disp('average over each year into row')
ss=mean(reshape(soi,12,[]))
ys=year(6:12:end); ys=round(ys)
n=length(ss)

figure(1),plot(year,soi,ys,ss)
title('SOI data series');

w=10 % window width

disp('project data until analysis has four sing values precisely')
for it=1:99
a=hankel(ss(1:w),ss(w:n));
[u,s,v]=svd(a); singvalues=diag(s)
figure(2),plot(diag(s),'o'),drawnow
a=u(:,1:4)*s(1:4,1:4)*v(:,1:4)';
ss(1:w)=a(:,1)';
ss(w:n)=a(end,:);
if s(5,5)<0.02,break,end
end

disp('round data to two d.p.')
soi=round(ss*100)/100
year=ys
figure(1),plot(year,soi,'o-')
print -depsc2 soiRoundData
%title('Soi data series---rounded');
disp('then analyse rounded data')
A=hankel(soi(1:w),soi(w:n))
figure(2),plot(A(:,1:6)+10*ones(w,1)*(1:6),'o-')
print -depsc2 soiRoundWind
[U,S,V]=svd(A); 
singValues=diag(S)
figure(3),plot(U(:,1:4)+ones(w,1)*(1:4),'o-')
print -depsc2 soiRoundSubs
