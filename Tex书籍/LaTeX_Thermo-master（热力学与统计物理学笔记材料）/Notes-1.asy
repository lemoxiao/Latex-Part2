if(!settings.multipleView) settings.batchView=false;
settings.tex="xelatex";
defaultfilename="Notes-1";
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

pair O = (0, 0), x_axes = (10, 0), y_axes = (0, 10);

pair p1 = (2.2, 7.5), p2 = (8, 2.5), p3 = (4, 4.5);
pair p1_x = (p1.x, 0), p2_x = (p2.x, 0);

fill(p1_x--p1..p3..p2--p2_x--cycle, color1 + opacity(0.2));

draw(Label("$V$", EndPoint), O--x_axes, Arrow);
draw(Label("$p$", EndPoint), O--y_axes, Arrow);

draw(p1..p3..p2, linewidth(1) + color1);
draw(p1_x--p1, dashed + color1);
draw(p2_x--p2, dashed + color1);

label("$O$", O, SW);
label("状态 $1$", p1, (0, 2));
label("状态 $2$", p2, (0.5, 2));
label("$V_1$", p1_x, S);
label("$V_2$", p2_x, S);
