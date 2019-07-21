if(!settings.multipleView) settings.batchView=false;
settings.tex="xelatex";
defaultfilename="Notes-5";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

usepackage("amsmath");
usepackage("mathtools");
usepackage("mathdesign", "adobe-garamond");
usepackage("bm");
usepackage("xeCJK");
texpreamble("\setCJKmainfont[BoldFont = 华文中宋, ItalicFont = 方正楷体_GBK, Mapping = fullwidth-stop ]{方正书宋_GBK}");
texpreamble("\setmainfont{AGaramondPro-Regular.otf}");
usepackage("siunitx");
texpreamble("\sisetup{
number-math-rm = \ensuremath,
inter-unit-product = \ensuremath{{}\cdot{}},
group-digits = integer,
group-minimum-digits = 4,
group-separator = \text{~}
}");

size(6 cm);

defaultpen(fontsize(9 pt));

pen color1 = rgb(0.368417, 0.506779, 0.709798);
pen color2 = rgb(0.880722, 0.611041, 0.142051);
pen color3 = rgb(0.560181, 0.691569, 0.194885);
pen color4 = rgb(0.922526, 0.385626, 0.209179);
pen color5 = rgb(0.647624, 0.378160, 0.614037);
pen color6 = rgb(0.772079, 0.431554, 0.102387);
pen color7 = rgb(0.363898, 0.618501, 0.782349);
pen color8 = rgb(0.972829, 0.621644, 0.073362);

import my3D;

triple O = (0, 0, 0), x_axes = (3.5, 0, 0), y_axes = (0, 5, 0), z_axes = (0, 0, 5);
triple point_m = (2.5, 5, 6), point_n = (point_m.x, point_m.y, 0);

pair O2 = project(O), point_m2 = project(point_m), point_n2 = project(point_n);

draw(Label("$x$", EndPoint), O2--project(x_axes), Arrow);
draw(Label("$y$", EndPoint), O2--project(y_axes), Arrow);
draw(Label("$z$", EndPoint), O2--project(z_axes), Arrow);

draw(Label("$\bm{r}$", MidPoint, black), O2--point_m2, linewidth(1.5) + color2);
draw(O2--point_n2--point_m2, dashed + color1);
fill(circle(point_m2, 0.2), color1);

real angle_r = 0.7;
draw(Label("$\varphi$", MidPoint, Relative(E)), angleMark(O, x_axes, point_n, angle_r));
draw(Label("$\theta$", MidPoint, Relative((-1,-0.4))), angleMark(O, z_axes, point_m, angle_r));

label("$O$", O2, (-1.5, 0.5));
label("$m$", point_m2, (2, 0.5));
