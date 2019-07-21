% library of orthogonal matrices, AJR, Jan 2016
qss={{eye(1)
},{eye(2)
,[4 -3;3 4]/5
,[12 -5;5 12]/13
,[15 -8;8 15]/17
%,[1 1;-1 1]/sqrt(2)
%,[sqrt(3) 1;-1 sqrt(3)]/2
},{eye(3)
,[1 2 2;2 -2 1;2 1 -2]/3
,[2 3 6;3 -6 2;6 2 -3]/7
%,[[1 1 1]/sqrt(3);[-1 0 1]/sqrt(2);[1 -2 1]/sqrt(6)]
,[7 4 4;4 -8 1;4 1 -8]/9
,[7 6 6;6 2 -9;6 -9 2]/11
},{eye(4)
,[1 1 1 1;1 1 -1 -1; 1 -1 -1 1;1 -1 1 -1]/2
,[1 2 2 4;2 4 -1 -2;2 -1 -4 2;4 -2 2 -1]/5
,[1 4 4 4;4 -5 2 2;4 2 -5 2;4 2 2 -5]/7
,[1 1 3 5;1 -1 5 -3;3 -5 -1 1;5 3 -1 -1]/6
,[2 2 3 8;2 -2 8 -3;3 -8 -2 2;8 3 -2 -2]/9
,[2 4 5 6;4 -2 6 -5;5 -6 -2 4;6 5 -4 -2]/9
,[1 5 5 7;5 -1 -7 5;5 7 -1 -5;7 -5 5 -1]/10
,[1 1 7 7;1 -1 -7 7;7 7 -1 -1;7 -7 1 -1]/10
,[1 3 3 9;3 9 -1 -3;3 -1 -9 3;9 -3 3 -1]/10
}};

for k=1:length(qss), qs=qss{k};
for l=1:length(qs), 
  if abs(norm(qs{l}'*qs{l}-eye(size(qs{l}))))>1e-9
  badOrthoMat=qs{l}
end,end,end

if 0 %search to construct orthogonal matrix from a row
q=[4 4 5 8]; n=length(q);
for l=1:999
  r=q(1,randperm(n)).*sign(randn(1,n));
  if norm(q*r')<1e-9, q=[q;r], end
  if size(q,1)==n,break,end
end,end


