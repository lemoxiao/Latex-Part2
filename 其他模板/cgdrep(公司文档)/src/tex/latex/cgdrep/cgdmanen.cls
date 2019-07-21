% cgdmanen.cls : English manual class
% vim: ft=tex

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{cgdrepen}[2013/01/03 Cogenda manual class]

\ProcessOptions\relax

\LoadClass[nofonts,11pt,utf8,a4paper,oneside]{book}

%\RequirePackage{showframe}
\RequirePackage[svgnames]{xcolor}
\RequirePackage{geometry}
\RequirePackage[framemethod=TikZ]{mdframed}
\RequirePackage[explicit]{titlesec}
%\RequirePackage[T1]{fontenc}
\RequirePackage[font=small,labelfont=bf]{caption}

\RequirePackage{amsmath,amssymb,amsfonts,array,booktabs,calc,changepage,datetime,esint,enumitem,eso-pic,fancyhdr,fixltx2e,float,fontspec,hyperref,ifxetex,listings,lmodern,longtable,makeidx,nameref,refstyle,relsize,siunitx,tabu,tcolorbox,tikz,times,units,varioref}%,tocloft,paralist,xeCJK
\RequirePackage{unicode-math}

\input{cgd-docattr.def}
\renewcommand\CGD@value@doctype{manual}
\renewcommand\CGD@value@classification{Public}
\renewcommand\CGD@value@email{support@cogenda.com}

\input{cgd-style.def}
\input{cgdman-style.def}
\input{cgd-font-en.def}
