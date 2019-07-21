if(!settings.multipleView) settings.batchView=false;
settings.tex="xelatex";
defaultfilename="Notes-4";
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

pair O = (0, 0), x_axes = (8, 0), y_axes = (0, 5);

real a = 5.5, b = 3;

pair p1 = (0.4, 1.8), p2 = (5, 3.8);
pair p3 = (2, -0.4), p4 = (6, -3);

draw(Label("$x$", EndPoint), (-x_axes)--x_axes, Arrow);
draw(Label("$p$", EndPoint), (0, -4.2)--y_axes, Arrow);

draw(ellipse(O, a, b), linewidth(1) + color1);

draw(O--(a, 0), linewidth(1.2));
draw(O--(0, b), linewidth(1.2));

draw(Label("$\sqrt{2mE}$", EndPoint), p1--p2);
draw(Label("$\sqrt{\dfrac{\displaystyle 2E}{\displaystyle m\omega^2}}$", EndPoint), p3--p4);

label("$O$", O, SW);
