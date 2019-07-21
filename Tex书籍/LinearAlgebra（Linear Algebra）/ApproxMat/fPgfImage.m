function fPgfImage(filename,A)
% generate pgfplot command for drawing greyscale pixel
% image. AJR Sep 2015

% size of image
[m,n]=size(A);
minA=min(A(:)); maxA=max(A(:));
% corner coordinates of patches
[h,v]=meshgrid(0:n,m:-1:0);
% indices of the corner coordinates
l=nan(m+1,n+1);
l(:)=0:(m+1)*(n+1)-1;
% print header info
fid=fopen(filename,'w');
fprintf(fid,'\\begin{tikzpicture}\n')
fprintf(fid,'\\begin{axis}[tiny,axis equal image\n')
fprintf(fid,',colormap/blackwhite,axis lines=none]\n')
fprintf(fid,'\\addplot[patch,patch type=rectangle\n')
fprintf(fid,',point meta min={0},point meta max={%6.3f}\n',maxA-minA)
fprintf(fid,',table/row sep=\\\\,patch table with point meta={\n')
% print image with inverted data as greyscale flipped
for j=1:n,for i=1:m
  k=i+(j-1)*(m+1);
  fprintf(fid,'%i %i %i %i %6.3f \\\\\n' ...
  ,l(k),l(k+1),l(k+m+2),l(k+m+1),maxA-A(i,j))
end, end
% print transition to coordinates
fprintf(fid,'}]\n')
fprintf(fid,'table[row sep=\\\\] {\n')
fprintf(fid,'x y \\\\\n')
for j=1:n+1,for i=1:m+1
  fprintf(fid,'%i %i \\\\\n',h(i,j),v(i,j))
end, end
fprintf(fid,'};\n')
fprintf(fid,'\\end{axis}\n')
fprintf(fid,'\\end{tikzpicture}\n')
fclose(fid)
