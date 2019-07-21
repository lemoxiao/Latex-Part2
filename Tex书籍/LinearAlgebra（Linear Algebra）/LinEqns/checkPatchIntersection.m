% check intersection of patches
xyzc=[
0 0 2 1
0 5 2 1
5 5 1 1
5 0 1 1
0 2 0 2
0 3 4 2
5 3 4 2
5 2 0 2
2 0 0 3
2 5 0 3
1 5 4 3
1 0 4 3
];
A=[]; b=[];
for p=1:3
  j=find(xyzc(:,4)==p);
  xyz=[xyzc(j,1:3) -ones(4,1)];
  nonzeroIsError=det(xyz)
  n=null(xyz);
  A=[A;n(1:3)']; b=[b;n(4)];
end
intersection=A\b
