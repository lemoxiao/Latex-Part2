% generates examples of five temperatures to fit the
% relation between celcius and farenheit  AJR Feb 2015
t=sort(10+20*rand(3,1));
te=[15;26;round(t)]
ta=[60;80;round(32+1.8*t)]
plot(te,ta,'o'),hold on
A=[ones(5,1) te te.^2 te.^3 te.^4]
condNum=condest(A)
c=A\ta
t=linspace(5,35);
plot(t,c(1)+c(2)*t+c(3)*t.^2+c(4)*t.^3+c(5)*t.^4)
ylim([41 95]),hold off