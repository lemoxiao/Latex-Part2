% cgdrepen.cls : English Report class
% vim: ft=tex

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{cgdrepen}[2013/01/03 Cogenda report class]

\DeclareOption{twoside}{
  \PassOptionsToPackage{\CurrentOption}{report}
}
\ProcessOptions\relax

\LoadClass[nofonts,11pt,utf8,a4paper]{report}

\input{cgd-common.def}
\input{cgd-font-en.def}

\input{cgd-docattr.def}
\renewcommand\CGD@value@classification{Restricted}

\input{cgd-front-en.def}
\input{cgd-struct.def}
\input{cgd-style.def}
\input{cgd-math.def}

\IfFileExists{./local.def}{\input {./local.def}}{}

\endinput

