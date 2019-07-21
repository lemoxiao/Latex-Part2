if(!settings.multipleView) settings.batchView=false;
settings.tex="xelatex";
defaultfilename="Notes-2";
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

pair p1 = (0, 7), p2 = (0, 0), p3 = (12, 0), p4 = (p3.x, p1.y), p5 = (0, 6), p6 = (p3.x, p5.y);
pair m1 = (p1+p4)/2, m2 = (p2+p3)/2;
transform myReflect = reflect(m1, m2);

real boxWidth = 3, boxHeight = 2;
pair pA1 = (1.8, 2.5), pA2 = (pA1.x+boxWidth, pA1.y), pA3 = (pA2.x, pA1.y+boxHeight), pA4 = (pA1.x, pA3.y);
path boxA = pA1--pA2--pA3--pA4--cycle;
path boxB = myReflect*boxA;

real pipeSize = 0.2, pipeHeight = 3.5;
pair ppA1 = (pA4.x+(boxWidth-pipeSize)/2, pA4.y), ppA2 = (ppA1.x, ppA1.y+pipeHeight), ppA3 = (ppA1.x+pipeSize, ppA1.y), ppA4 = (ppA3.x, ppA2.y-pipeSize);
pair ppB1 = myReflect*ppA1, ppB2 = myReflect*ppA2, ppB3 = myReflect*ppA3, ppB4 = myReflect*ppA4;
path pipe = ppA1--ppA2--ppB2--ppB1--ppB3--ppB4--ppA4--ppA3--cycle;

real valveHeight = 0.6;
pair pv1 = (m1.x, ppA2.y-(valveHeight+pipeSize)/2), pv2 = (pv1.x, pv1.y+valveHeight);

real thermometerHeight = 5, thermometerR = 0.2;
pair pt1 = (1, 3), pt2 = (pt1.x, pt1.y+thermometerHeight);

fill(p5--p2--p3--p6--cycle, color1+opacity(0.2));
draw(p1--p2--p3--p4, linewidth(1)+color1);
draw(boxA, linewidth(1)+color2);
draw(boxB, linewidth(1)+color2);
draw(pipe, linewidth(1)+color2);
draw(pv1--pv2, linewidth(2)+color3);
draw(pt1--pt2, linewidth(2)+color4);
fill(circle(pt1, thermometerR), color4);

label("A", (ppA1+ppA3)/2, (0, -3));
label("B", (ppB1+ppB3)/2, (0, -3));

pair pwLabel1 = (p3.x-1, p3.y+1.4), pwLabel2 = (p3.x+1, p3.y+2.5);
draw(pwLabel1--pwLabel2);
label("水槽", pwLabel2, E);

pair ptLabel1 = (pt1.x-0.25, pt2.y-1), ptLabel2 = (pt1.x-1.5, pt2.y+0.4);
draw(ptLabel1--ptLabel2);
label("温度计", ptLabel2, N);

pair pvLabel1 = (pv1.x+0.25, pv2.y-0.1), pvLabel2 = (pv1.x+1.5, pv2.y+1);
draw(pvLabel1--pvLabel2);
label("阀门", pvLabel2, N);
