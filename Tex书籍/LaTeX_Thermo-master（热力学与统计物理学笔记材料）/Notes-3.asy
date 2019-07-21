if(!settings.multipleView) settings.batchView=false;
settings.tex="xelatex";
defaultfilename="Notes-3";
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

import graph;
pair O = (0, 0), x_axes = (10, 0), y_axes = (0, 10);
draw(Label("$V$", EndPoint), O--x_axes, Arrow);
draw(Label("$p$", EndPoint), O--y_axes, Arrow);

real gamma = 2.5;
real x1 = 2, x4 = 9;
real c1 = 10, c2 = 18;
real c3 = c2*x1^(gamma-1), c4 = c1*x4^(gamma-1);
real x2 = x1*(c1/c2)^(1/(1-gamma)), x3 = x4*(c2/c1)^(1/(1-gamma));

path path1 = graph(new real(real x) {return c2/x;}, x1, x3);
path path2 = graph(new real(real x) {return c4/x^gamma;}, x3, x4);
path path3 = reverse(graph(new real(real x) {return c1/x;}, x2, x4));
path path4 = reverse(graph(new real(real x) {return c3/x^gamma;}, x1, x2));
//path path_TH = graph(new real(real x) {return c2/x;}, x3, 8);
//path path_TC = graph(new real(real x) {return c1/x;}, 1.7, x2);

pair p1 = (x1, c2/x1), p2 = (x3, c2/x3), p3 = (x4, c1/x4), p4 = (x2, c1/x2);

pen pen1 = linewidth(1)+color1;

fill(path1 & path2 & path3 & path4 & cycle, color1+opacity(0.2));

//draw(path_TH, dashed + color1);
//draw(path_TC, dashed + color1);
draw(path1, pen1, Arrow(position = Relative(0.7), arrowhead = HookHead, size = 4));
draw(path2, pen1, Arrow(position = Relative(0.5), arrowhead = HookHead, size = 4));
draw(path3, pen1, Arrow(position = Relative(0.7), arrowhead = HookHead, size = 4));
draw(path4, pen1, Arrow(position = Relative(0.45), arrowhead = HookHead, size = 4));

draw(Label("$V_1$", EndPoint, black), p1--(p1.x, 0), dashed + color1);
draw(Label("$V_2$", EndPoint, black), p2--(p2.x, 0), dashed + color1);
draw(Label("$V_3$", EndPoint, black), p3--(p3.x, 0), dashed + color1);
draw(Label("$V_4$", EndPoint, black), p4--(p4.x, 0), dashed + color1);

label("状态1", p1, N);
label("状态2", p2, NE);
label("状态3", p3, E);
label("状态4", p4, SW, Fill(white));

label("I", path1, align = Relative(W));
label("II", path2, align = Relative(W));
label("III", path3, align = Relative(W));
label("IV", path4, align = Relative(W), Fill(white));
