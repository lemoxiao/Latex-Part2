%# -*- coding:utf-8 -*-
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{LA-Book}
              [2010/11/14 v2.0
 LA-Book document class]
\newif\ifLA@preview \LA@previewfalse
\newif\ifLA@print   \LA@printfalse
\newif\ifLA@book    \LA@booktrue
\newif\ifLA@wmark   \LA@wmarkfalse
\DeclareOption{preview}{\LA@previewtrue}
\DeclareOption{print}  {\LA@printtrue\LA@previewfalse}
\DeclareOption{book}   {\LA@booktrue\LA@previewfalse}
\DeclareOption{a4paper}{\LA@previewtrue\LA@printfalse\LA@bookfalse}
\DeclareOption{watermark}{\LA@wmarktrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\PassOptionsToPackage{CJKchecksingle,no-math,silent,fallback}{xeCJK}
\LoadClass[c5size,openany,nofonts]{ctexbook}[2009/05/05]

\RequireXeTeX

\def\hmmax{0}     % default 3
\def\bmmax{0}     % default 4

\RequirePackage[loosequotes,lf,onlymath]{MinionPro}
\RequirePackage{empheq,amsthm,bm,extarrows,pmat,polynom,systeme}
\RequirePackage[uppi,fourier,mathscrf,mathcal,mathbb,comma]{localint}
\RequirePackage{pifont,marvosym,paralist,multicolist,afterpage,chngcntr}
\RequirePackage{floatrow,caption,rotating,ifthen,varioref}
\RequirePackage[perpage,stable,bottom]{footmisc}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage[pagestyles,nobottomtitles*]{titlesec}
\RequirePackage[titles]{tocloft}
\RequirePackage[normalem]{ulem}
\def\pgfsysdriver{pgfsys-xetex.def}
\RequirePackage{tikz}
\usetikzlibrary{arrows,matrix}
\RequirePackage[showframe=false,twoside,headheight=5mm,headsep=7mm,footskip=1em,bindingoffset=10mm]{geometry}
\RequirePackage[bookmarksnumbered,pdfstartview={XYZ null null 1},pdfpagemode=UseNone,pdfprintscaling=None]{hyperref}
\RequirePackage[dvipdfm,color=purple]{bookmark}
\RequirePackage{wrapfig,metalogo,multicol,tabularx,booktabs}
\ifLA@wmark
  \RequirePackage{eso-pic}
\fi
\@ifpackageloaded{graphicx}{}{%
  \RequirePackage{graphicx}}

\graphicspath{{includefiles/figures/}}
\hypersetup{%
  colorlinks,linkcolor=purple,citecolor=purple,linkbordercolor=purple,%pdfborder=001,% bookmarksopen=true,linktocpage,%
  pdfinfo={
    Title   = {线性代数},
    Author  = {李炯生，查建国},
    Creator = {XeLaTeX + xeCJK + CTeX}
  }
}

\let\HyPsd@Warning\@gobble\relax

\ifLA@preview
  \geometry{a4paper,vmargin={25mm,20mm},hmargin=20mm}
\else
  \geometry{textwidth=130mm,lines=36,inner=15mm}
    \ifLA@print
      \hypersetup{colorlinks=false}
      \geometry{b5j,top=30mm}
    \else
      \ifLA@book
        \geometry{papersize={170mm,240mm},top=20mm}
      \fi
    \fi
\fi

\ifLA@wmark
  \newbox\@watermark@box
  \sbox\@watermark@box{\includegraphics[totalheight=.9\textwidth,angle=-90]{arbres.pdf}}
  \def\@watermark@CMD{\ifodd\c@page\usebox\@watermark@box\else\reflectbox{\usebox\@watermark@box}\fi}
\fi
\def\printwatermark{%
  \ifLA@wmark
    \AddToShipoutPictureBG{\AtTextCenter{\makebox(0,0)[c]{\@watermark@CMD}}}
  \fi}

\predisplaypenalty   = \z@
\postdisplaypenalty  = \z@
\clubpenalty         = \z@
\widowpenalty        = \z@
\displaywidowpenalty = \z@
\interlinepenalty    = \z@
\brokenpenalty       = \sixt@@n
\parskip             = \z@
\thinmuskip          = 3 mu
\medmuskip           = 4 mu  \@plus 1 mu  \@minus 4 mu
\thickmuskip         = 5 mu  \@plus 1 mu  \@minus 2 mu
\hfuzz   = 10\p@
\vfuzz   = 10\p@
\topskip = 10\p@

\input{LA-FontSet.def}

\definecolor{titlegray}{gray}{.75}
\newdimen\ruleheight
\ruleheight = .8\p@

\newcommand*\errorq{\hfill{(\kaishu{本题似有误})}}

\renewcommand*\appendixname     {附录}
\renewcommand*\thesubsection    {习题~~\thesection}
\renewcommand*\thesubsubsection {\chinese{subsubsection}}
\renewcommand*\theparagraph     {\arabic{paragraph}}
\renewcommand*\contentsname     {目\hspace{\ccwd}录}
\renewcommand*\bibsection       {\chapter{\bibname}}
\bibsep = \p@

\DeclareRobustCommand*\prethesection{{\MyriadPro\S\kern0.1em}}
\def\CTEX@presection{\prethesection}

\labelformat{part}{\CTEX@prepart~#1~\CTEX@postpart}
\labelformat{chapter}{\@firstoftwo{\CTEX@prechapter\chinese{chapter}\CTEX@postchapter}{#1}}
\labelformat{section}{\CTEX@presection#1}

\renewcommand*\bottomtitlespace{\z@}
\newcommand*\sectionbreak{%
  \goodbreak\renewcommand*\bottomtitlespace{.3\textheight}}

\titleformat{\chapter}[display]
            {\bfseries\boldmath\fzcuheisong\addfontfeature{BoldFont={MyriadPro-Bold}}}
            {\fillouter\zihao{-3}\fzydzhhei\CTEXthechapter\\ \titlerule[\ruleheight]}
            {\z@}
            {\ifthechapter{\zihao{-2}\fillinner}{\zihao{3}\filcenter}}
\titleformat{\section}
            {\filcenter\vspace*{2mm}\bfseries\boldmath\CMRoman\fzzysong\zihao{-3}}
            {\CTEXthesection}
            {\ccwd}
            {\gdef\bottomtitlespace{\z@}}
\titleformat{\subsection}
            {\filcenter\bfseries\boldmath\fzltzhhei\TeXGyreBonum\normalsize}
            {习\hspace\ccwd 题\hspace\ccwd\thesection}
            {\z@}
            {}
\titleformat{\subsubsection}
            {\emphfont\zihao{-4}}
            {\thesubsubsection 、}
            {\z@}
            {}
\titleformat{\paragraph}[runin]
            {\emphfont\normalsize}
            {\addfontfeature{BoldFont={MyriadPro-Bold}}\theparagraph.\hskip\labelsep}
            {\z@}
            {}
\titlespacing*%
    {name=\chapter,numberless}{\z@}   {-1em}                  {2\baselineskip-2\ccwd}
\titlespacing*{\chapter}      {\z@}   {-1em}                  {2\baselineskip-\ccwd}
\titlespacing*{\section}      {\z@}   {7mm \@plus 2mm \@minus 2mm}{6mm \@plus 2mm \@minus 2mm}
\titlespacing*{\subsection}   {\z@}   {5mm \@plus 2mm \@minus 2mm}{3mm \@plus 1mm \@minus 1mm}
\titlespacing*{\subsubsection}{2\ccwd}{3mm \@plus 2mm \@minus 2mm}{2mm \@plus 1mm \@minus 1mm}
\titlespacing*{\paragraph}    {2\ccwd}{1.5ex}                 {0mm}

\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{1}

\DeclareRobustCommand*\TitHspace{\hspace}
\cftsetrmarg{4\ccwd}
\cftsetindents{part}{4\ccwd}{3\ccwd}
\cftsetindents{chapter}{0\ccwd}{4\ccwd}
\cftsetindents{section}{4\ccwd}{3\ccwd}
\cftbeforepartskip = 10mm
\cftbeforechapskip = 2ex
\cftbeforesecskip  = \z@
\cftpagenumbersoff{part}
\renewcommand\cftdotsep        {4.5}
\renewcommand\cftdot           {\ensuremath\cdot}
\renewcommand\cftpartafterpnum {\hfill\medskip}
\renewcommand\cftsecpresnum    {\prethesection}
\renewcommand\cftpartfont      {\bfseries\zihao{-4}\fzzysong\ziju{.5}\hfill}
\renewcommand\cftchapfont      {\MyriadPro\emphfont\let\TitHspace\@gobble}
\renewcommand\cftsecfont       {\kaishu\let\TitHspace\@gobble}
\renewcommand\cftchapleader    {\cftchapfont\cftsecleader}
\renewcommand\cftchappagefont  {\cftchapfont}
\renewcommand\cftchapfillnum[1]{\cftchapleader\nobreak{\cftchappagefont #1}\cftchapafterpnum\par}
\renewcommand\cftsecfillnum [1]{\cftsecleader\nobreak{\cftsecpagefont #1}\cftsecafterpnum\par}

\newbox\ch@end@box
\newbox\em@page@box
\sbox\ch@end@box{\includegraphics{kochone.pdf}}
\sbox\em@page@box{\includegraphics[width={.4\textwidth}]{hilbert.pdf}}

\DeclareRobustCommand*\PrintChEndLogo{\vspace{\stretch{50}}\centerline{\usebox\ch@end@box}}
\DeclareRobustCommand*\ParTocLine    {\noindent\bigskip\titlerule[\ruleheight]\vspace{-\baselineskip}\par}

\raggedbottom
\allowdisplaybreaks[4]

\renewcommand\setheadrule[2][2mm]{%
  \ifdim#1=\z@
    \let\makeheadrule\@empty
  \else
    \def\makeheadrule{\rule[-#1]{\linewidth}{#2}}%
  \fi}
\newpagestyle{main}[\bfseries\boldmath\small\fzlthei\CMRoman]{%
  \sethead[$\cdot$\enskip\thepage\enskip$\cdot$]
          []
          [\ifthechapter{\CTEXthechapter\hspace\ccwd\chaptertitle}{\chaptertitle}%
           {\normalsize\makebox[3\ccwd][r]{\small\ForwardToIndex}}]
          {{\normalsize\makebox[3\ccwd][l]{\small\RewindToIndex}}%
            \ifthesection{\CTEXthesection\hspace\ccwd\sectiontitle}
                         {\ifthechapter{\CTEXthechapter\hspace\ccwd\chaptertitle}{\chaptertitle}}}
          {}
          {$\cdot$\enskip\thepage\enskip$\cdot$}%
  \setheadrule\ruleheight}
\newpagestyle{appendix}[\bfseries\boldmath\small\fzlthei\CMRoman]{%
  \setmarks{part}{chapter}
  \sethead[$\cdot$\enskip\thepage\enskip$\cdot$]
          [\ziju{1}\thepart]
          [\parttitle{\normalsize\makebox[3\ccwd][r]{\small\ForwardToIndex}}]
          {{\normalsize\makebox[3\ccwd][l]{\small\RewindToIndex}}%
            \ifthechapter{\CTEXthechapter\hspace\ccwd\chaptertitle}{\chaptertitle}}
          {}
          {$\cdot$\enskip\thepage\enskip$\cdot$}%
  \setheadrule\ruleheight}
\renewpagestyle{plain}{}
\pagestyle{main}
\renewcommand{\numberline}[1]{%
  \settowidth\@tempdimb{#1\hspace{0.5em}}%
  \ifdim\@tempdima<\@tempdimb
    \@tempdima=\@tempdimb
  \fi
  \hb@xt@\@tempdima{\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb}
\newcommand\titlematter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagestyle{empty}\pagenumbering{Alph}}
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagestyle{main}\pagenumbering{Roman}}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagestyle{main}\pagenumbering{arabic}}
\renewcommand\backmatter{%
  \clearpage
  \@mainmatterfalse}
\newpagestyle{apppart}{\addtocontents{toc}{\protect\ParTocLine\let\string\prethesection\relax}}
\renewcommand\appendix{%
  \let\prethesection\relax
  \cleardoublepage
  \@mainmattertrue
  \counterwithin*{chapter}{part}
  \counterwithin*{paragraph}{section}
  \renewcommand*\thepart{\appendixname}
  \setcounter{section}{0}
  \pagestyle{appendix}
  \renewcommand*\thesection{A\arabic{chapter}.\arabic{section}}
  \titleformat{\part}[display]
              {\filcenter\bfseries\boldmath\ziju{.5}\yanti\fontsize{30bp}{\baselineskip}\selectfont}
              {\fillouter\zihao{-4}\fzydzhhei\fbox{\ziju{.5}\thepart}\vspace{\stretch{1}}}
              {0\ccwd}
              {\pagecolor{titlegray}\thispagestyle{apppart}}
              [\vspace{\stretch{2}}\afterpage{\pagecolor{white}}]
  \titleformat{\chapter}[display]%
              {\bfseries\boldmath\fzcuheisong\ifthechapter{\zihao{3}\fillinner}{\zihao{-3}\filcenter}}
              {\fillouter\zihao{-4}\fzydzhhei\CTEXthechapter\\ \titlerule[\ruleheight]\vspace{-\baselineskip}}
              {0\ccwd}
              {}
  \titleformat{\section}
              {\filcenter\vspace*{3mm}\bfseries\boldmath\CMRoman\fzzysong\zihao{4}}
              {\CTEXthesection}
              {\ccwd}
              {\gdef\bottomtitlespace{\z@}}
  \def\CTEX@postchapter{讲}}
\newcommand\appfrontmatter{%
  \clearpage
  \@mainmatterfalse}
\newcommand\appmainmatter{%
  \cleardoublepage
  \@mainmattertrue}
\newcommand\appbackmatter{%
  \clearpage
  \@mainmatterfalse}
\newcommand\fillinner{%
  \if@twoside
    \ifodd\c@page\raggedleft\else\raggedright\fi
  \else
    \raggedleft
  \fi}
\newcommand\fillouter{%
  \if@twoside
    \ifodd\c@page\raggedright\else\raggedleft\fi
  \else
    \raggedright
  \fi}
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifodd\c@page\relax
    \else
      \thispagestyle{empty}
      \strut\vfill\centerline{\usebox\em@page@box}\vfill
      \newpage
      \if@twocolumn
        \strut\newpage
      \fi
    \fi
  \fi}

\AtEndDocument{\cleardoublepage}

\newcommand\vhrulefill[2][\z@]{%
  \leavevmode\unskip\leaders\hbox{\rule[#1]{\p@}{#2}}\hfill\ignorespaces}

\newtoks\theorembodyfont
\newtoks\theoremheaderfont
\newtoks\theorempunct
\global\theoremheaderfont{\MyriadPro\bfseries\sffamily\upshape\boldmath}
\global\theorembodyfont{\normalfont}
\global\theorempunct{}
\newskip\theorempreskipamount
\newskip\theorempostskipamount
\newskip\theoremindent
\newskip\theoremsep
\global\theorempreskipamount  = .5ex
\global\theorempostskipamount = .5ex
\global\theoremindent = \parindent
\global\theoremsep    = \ccwd
\newtheoremstyle{Axiom}
                {\theorempreskipamount}
                {\theorempostskipamount}
                {\the\theorembodyfont\sffamily}
                {\theoremindent}
                {\the\theoremheaderfont}
                {\the\theorempunct}
                {\theoremsep}
                {\@ifempty{#3}{\thmname{#1}}{\thmnote{#3}}}
\newtheoremstyle{Theorem}
                {\theorempreskipamount}
                {\theorempostskipamount}
                {\the\theorembodyfont\sffamily}
                {\theoremindent}
                {\the\theoremheaderfont}
                {\the\theorempunct}
                {\theoremsep}
                {\thmname{#1}\thmnumber{~#2}\thmnote{（#3\rlap{）}}}
\newtheoremstyle{Remark}
                {0ex \@plus .25ex}
                {0ex \@plus .25ex}
                {\the\theorembodyfont}
                {\theoremindent}
                {\the\theoremheaderfont}
                {\the\theorempunct}
                {\theoremsep}
                {\thmname{#1}\thmnumber{~#2}\thmnote{（#3\rlap{）}}}
\newtheoremstyle{EmptyHead}
                {0ex \@plus .25ex}
                {0ex \@plus .25ex}
                {\the\theorembodyfont}
                {\theoremindent}
                {\the\theoremheaderfont}
                {\the\theorempunct}
                {\theoremsep}
                {\@ifempty{#3}{\thmname{#1}\thmnumber{~#2}}{\thmnote{#3}}}
\newtheoremstyle{Proof}
                {0ex \@plus .25ex}
                {0ex \@plus .25ex}
                {\the\theorembodyfont\pushQED{\qed}}
                {\theoremindent}
                {\the\theoremheaderfont}
                {\the\theorempunct}
                {\theoremsep}
                {\@ifempty{#3}{\thmname{#1}\thmnumber{~#2}}{\thmnote{#3}}}
\theoremstyle{Axiom}
  \newtheorem*{axiom}{公理}
\theoremstyle{Theorem}
  \newtheorem{definition}  {定义}[section]
  \newtheorem{theorem}     {定理}[section]
  \newtheorem{lemma}       {引理}[section]
  \newtheorem{proposition} {命题}[section]
  \newtheorem{property}    {性质}[section]
  \newtheorem{conclusion}  {结论}[section]
  \newtheorem{corollary}   {推论}[section]
  \newtheorem{example}     {例}  [section]
\theoremstyle{Remark}
  \newtheorem*{remark}{注}
  \newtheorem{remark*}{注}
  \counterwithin*{remark*}{example}
\theoremstyle{EmptyHead}
  \newtheorem*{emptyhead}{空白}
\theoremstyle{Proof}
  \let\proof\@undefined
  \let\endproof\@undefined
  \def\proofname{证明}
  \def\solutionname{解}
  \def\qedsymbol{\ensuremath\blacksquare}
  \let\@old@endtheorem\@endtheorem
  \def\@endtheorem{\popQED\@old@endtheorem}
  \newtheorem*{proof}   {\proofname}
  \newtheorem*{solution}{\solutionname}
  \newtheorem{proof*}   {证法}
  \newtheorem{solution*}{解法}
  \counterwithin*{proof*}{example}
  \counterwithin*{solution*}{example}
  \let\@endtheorem\@old@endtheorem

\labelformat{definition}{定义~#1}
\labelformat{theorem}{定理~#1}
\labelformat{lemma}{引理~#1}
\labelformat{proposition}{命题~#1}
\labelformat{property}{性质~#1}
\labelformat{conclusion}{结论~#1}
\labelformat{corollary}{推论~#1}
\labelformat{example}{例~#1}
\labelformat{proof*}{证法~#1}
\labelformat{solution*}{解法~#1}
\labelformat{remark*}{注~#1}
\labelformat{equation}{(#1)}

\numberwithin{equation}{section}

\newcolumntype{C}{>{\centering\arraybackslash}X}
\renewcommand*\tabularxcolumn[1]{>{\arraybackslash}m{#1}}

\DeclareRobustCommand*\Ding[1]{%
  \ifnum\number#1 > 10%
    \typeout{The value of input number is \number#1, larger than 10}%
  \fi
  \ding{\number\numexpr#1 + 171}}
\let\@Ding\Ding\relax

\renewcommand*\thefootnote{\@Ding\c@footnote}
\renewcommand*\footnoterule{\kern-3\p@\hrule\@width.45\columnwidth\@height.6\p@\kern2.4\p@}
\newdimen\@footnote@indent
{\footnotesize\global\@footnote@indent=1.2em}
\long\def\@makefntext#1{\@setpar{\@@par%
  \@tempdima\hsize\advance\@tempdima-\@footnote@indent
  \parshape \@ne \@footnote@indent \@tempdima}%
  \par\noindent\llap{\makebox[1.2em][l]{\@thefnmark}}%
  \linespread{1.2}\selectfont\interlinepenalty\z@\CTEXindent#1}
\def\@makefnmark{\raisebox{1ex}[\z@]{\small\@thefnmark}}

\setlength\footnotesep{1.2\footnotesep}

\renewcommand*\theenumi{\@arabic\c@enumi}
\renewcommand*\theenumii{\@arabic\c@enumii}
\renewcommand*\theenumiii{\@Ding\c@enumiii}
\renewcommand*\theenumiv{\@Alph\c@enumiv}
\renewcommand*\labelenumi{\bfseries(\theenumi)}
\renewcommand*\labelenumii{(\theenumii)}
\renewcommand*\labelenumiii{\theenumiii}
\renewcommand*\labelenumiv{\theenumiv.}

\labelformat{enumi}{(#1)}
\labelformat{enumii}{(#1)}

\pldesclabelsep=1\ccwd\relax
\renewcommand*\paradescriptionlabel[1]{\mbox{\emph*{#1}}}

\newcommand*\emphitem[1]{\mbox{\emph*{#1}\kern\pldesclabelsep}\ignorespaces}

\def\@list@penalty{%
  \@beginparpenalty = \z@
  \@itempenalty     = \z@
  \@endparpenalty   = \z@}

\newcommand*\iscurrentsection[1]{\ifthenelse{\equal{#1}{\thesection}}{}{~\CTEX@presection #1~}}
\newenvironment{exercise}{\subsection{}\small
    \renewcommand\labelenumi{\bfseries\sffamily\theenumi.}%
    \labelformat{enumi}{\protect\iscurrentsection{\thesection}习题~##1}%
    \@list@penalty\asparaenum}{\endasparaenum}
\newenvironment{question}  {\@list@penalty\asparaenum}{\endasparaenum}
\newenvironment{enumitems} {\@list@penalty\asparaenum}{\endasparaenum}
\newenvironment{enumitems*}{\inparaenum}{\endinparaenum}
\newenvironment{descitems} {\inparadesc}{\endinparadesc}

\newcommand*\thmitemhspace[1]{\sbox{\@labels}{\unhbox\@labels\kern#1}}
\newcommand*\fixthmitem[1][-\parindent]{\thmitemhspace{#1}}

\newenvironment{enumitemcols}[1][2]{\CTEXindent
    \listcolsleftmargin=\parindent
    \multienumitems\relax
    \totalistcolswidth\dimexpr\linewidth/#1\relax}%
  {\endmultienumitems}
\newenvironment{enumitemcols*}{\itemcolsinlist
    \enumitemcols}%
  {\endenumitemcols}

\newcommand*\itemstrut{\strut}

\newenvironment{IntroPar}{\kaishu\small%
    \multicolsep   = 10\p@
    \columnsep     = 12\p@
    \columnseprule =   \z@
    \hrule\@height\ruleheight\vspace{-3\p@}%
    \raggedcolumns\begin{multicols}{2}\compactitem[\small\Writinghand]}%
  {\endcompactitem\end{multicols}\hrule\@height\ruleheight\vspace{2mm}}

\newenvironment{changemargin}[2]{%
    \list{}{%
      \leftmargin    = #1
      \rightmargin   = #2
      \topsep        = \z@
      \parsep        = \parskip
      \partopsep     = \z@
      \listparindent = \parindent
      \itemindent    = \parindent}%
    \item[]}%
  {\endlist}

\newcommand*\floatlabelformat[2]{\@namedef{fnum@#1}{#2}}
\floatlabelformat{figure}{\figurename\nobreakspace\thefigure}
\floatlabelformat{table}{\tablename\nobreakspace\thetable}

\floatplacement{figure}{ht}
\floatplacement{table}{ht}

\intextsep    = 1.5ex \@minus .2ex
\textfloatsep = 3ex   \@minus .5ex

\labelformat{figure}{\figurename~#1}
\labelformat{table}{\tablename~#1}

\newfloatcommand{tablebox}{table}[\nocapbeside][\FBwidth]
\DeclareFloatVCode{frpreskip} {\relax}
\DeclareFloatVCode{frpostskip}{\vskip-\intextsep}
\DeclareFloatVCode{wrapfig}{\vskip-\intextsep}
\DeclareFloatSeparators{frowsep}{\quad}
\floatsetup{style=plain,capposition=bottom,floatrowsep=frowsep,captionskip=.75ex,%
            rowprecode=frpreskip,rowpostcode=frpostskip}
\floatsetup[wrapfloat]{captionskip=-2\p@,rowprecode=wrapfig}

\DeclareCaptionFont{captextfont} {\bfseries}
\DeclareCaptionFont{caplabelfont}{\sffamily\bfseries}
\DeclareCaptionLabelSeparator{captionlabelsep}{\quad}
\captionsetup{labelfont=caplabelfont,textfont=captextfont,labelsep=captionlabelsep,%
              hypcap=true,figurewithin=section,tablewithin=section,position=below}

\renewcommand*\le\leqslant
\renewcommand*\ge\geqslant
\renewcommand*\mid{\bigm\vert}
\newcommand*\dps{\displaystyle}
\newcommand*\sumsep[1][.5]{\kern#1\ccwd}
\newcommand*\mtilde[1]{\widetilde{#1}}
\newcommand*\mequiv[1]{\overline{#1}}
\newcommand*\mscr[1]{\mathscr{#1}}
\newcommand*\mfield[1]{\mathbb{#1}}
\newcommand*\amscr[1]{\mathcal{#1}}
\newcommand*\map[3]{#1\colon#2\to#3}
\newcommand*\smsqrt[1]{\sqrt{\smash[b]{#1}}}
\newcommand*\setfam[1]{\mathcal{#1}}
\newcommand*\mA{\mscr A}
\newcommand*\mB{\mscr B}
\newcommand*\mI{\mscr I}
\newcommand*\mR{\mfield R}
\newcommand*\mC{\mfield C}
\newcommand*\mQ{\mfield Q}
\newcommand*\mK{\mfield K}
\newcommand*\mZ{\mfield Z}
\newcommand*\mN{\mfield N}
\newcommand*\mP{\mfield P}
\newcommand*\mF{\mfield F}
\newcommand*\uC{\mathrm C}
\newcommand*\mi{\mathrm i}
\newcommand*\me{\mathrm e}
\newcommand*\tran{^{\mathrm T}}
\newcommand*\diff{\mathop{}\!\mathrm{d}}
\newcommand*\hsep{\hphantom{-}}
\newcommand*\e{\varepsilon}
\newcommand*\eset{\varnothing}
\newcommand*\rest[1]{\bigr|_{#1}}
\newcommand\minor[1]{\bigl(\begin{smallmatrix}#1\end{smallmatrix}\bigr)}
\newcommand*\mvec[2][n]{%
  {#2}_1,\allowbreak{#2}_2,\allowbreak\dotsc,\allowbreak{#2}_{#1}}
\newcommand*\operp{\mathbin{\text{%
  \raisebox{0.6\p@}{\scalebox{0.75}{$\bigcirc\mkern-21mu\perp$}}}}}
\newcommand*\eqdots[1][2.5]{%
  \makebox[#1cm][c]{\titlerule*[5\p@]{$\cdot$}}}

\@ifpackageloaded{MinionPro}%
  {\let\adots\udots}%
  {\def\adots{\mathinner{\reflectbox{\ensuremath\ddots}}}}

\let\ker\@undefined
\let\hom\@undefined
\DeclareMathOperator{\ker}{Ker}
\DeclareMathOperator{\hom}{Hom}
\DeclareMathOperator{\rank}{rank}
\DeclareMathOperator{\tr}{Tr}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\im}{Im}
\DeclareMathOperator{\re}{Re}
\DeclareMathOperator{\diag}{diag}
\DeclareMathOperator{\grad}{grad}
\DeclareMathOperator{\arccot}{arccot}
\DeclareMathOperator{\spanm}{span}
\DeclareMathOperator{\nullm}{null}
\DeclareMathOperator{\tor}{Tor}
\DeclareMathOperator{\free}{Free}
\DeclareMathOperator{\ann}{ann}
\DeclareMathOperator*{\dsums}{\sum\,\sum}

\let\overbrace\LaTeXoverbrace
\let\underbrace\LaTeXunderbrace
\mathtoolsset{centercolon,mathic}
\DeclarePairedDelimiter\abs{\lvert}{\rvert}
\DeclarePairedDelimiter\norm{\lVert}{\rVert}
\DeclarePairedDelimiter\ideal{\langle}{\rangle}
\DeclarePairedDelimiter\bform{\langle}{\rangle}
\DeclarePairedDelimiter\Paren{\lparen}{\rparen}
\DeclarePairedDelimiter\Brack{\lbrack}{\rbrack}
\DeclarePairedDelimiter\Brace{\lbrace}{\rbrace}
\DeclarePairedDelimiter\Floor{\lbrack}{\rbrack}

\newcases{cdcases}{\quad}{%
  \hfil$\m@th\displaystyle{##}$\hfil}{$\m@th\displaystyle{##}$\hfil}{\lbrace}{.}
\newcases{cdcases*}{\quad}{%
  \hfil$\m@th\displaystyle{##}$\hfil}{{##}\hfil}{\lbrace}{.}

\newcommand*\bformk{\bform{\,,}}
\newcommand*\Parenb[1]{\Paren[\big]{#1}}
\newcommand*\Brackb[1]{\Brack[\big]{#1}}
\newcommand*\Braceb[1]{\Brace[\big]{#1}}

\newenvironment{tmatrix}{\biggl(\begin{matrix}}{\end{matrix}\biggr)}
\newenvironment{rtmatrix}{\biggl(\begin{matrix*}[r]}{\end{matrix*}\biggr)}

\DeclareRobustCommand*\mdiv{\mathchoice
  {\mathbin{\big\vert}}{\mathbin{\big\vert}}%
  {\mathbin\vert}{\mathbin\vert}}
\DeclareRobustCommand*\nmdiv{\mathchoice
  {\mathbin{\raisebox{-.3ex}{\scalebox{1.1}[1.55]{\ensuremath\nmid}}}}%
  {\mathbin{\raisebox{-.3ex}{\scalebox{1.1}[1.55]{\ensuremath\nmid}}}}%
  {\mathbin\nmid}{\mathbin\nmid}}

\newbox\@tp@box@la
\newbox\@tp@box@lb
\AtBeginDocument{\sbox\@tp@box@la{$,$}\sbox\@tp@box@lb{$;$}}

\newcommand*\cide{\rlap{\usebox\@tp@box@la}}
\newcommand*\side{\rlap{\usebox\@tp@box@lb}}
\newcommand*\cid{\rlap{$,$}}
\newcommand*\sid{\rlap{$;$}}
\newcommand*\pid{\rlap{．}}

\syslineskipcoeff{1}

\renewcommand*{\intertext}[1][]{\@amsmath@err{\Invalid@@\intertext}\@eha}
\def\intertext@{%
  \def\intertext{%
    \ifvmode\else\\\@empty\fi
    \noalign{\ifnum0=`}\fi
      \@ifnextchar[{\NCC@intertext@}{\NCC@intertext@[]}%
  }%
}
\def\NCC@intertext@[#1]#2{%
  \penalty\postdisplaypenalty
%%  \@ifempty{#1}{\vskip\belowdisplayskip}{\vskip#1\relax}%
  \vbox{\normalbaselines
    \ifdim\linewidth=\columnwidth
    \else\parshape\@ne\@totalleftmargin\linewidth
    \fi
    \noindent#2\par}%
  \penalty\predisplaypenalty
  \@ifempty{#1}{}{\vskip#1\relax}%
  \ifnum0=`{\fi}%
}

\newcommand\prefixtext[1]{%
  \ifvmode\else\\\@empty\fi
  \noalign{%
    \penalty\z@
    \vbox{\mathstrut}%
    \penalty\@M%
    \vskip-\baselineskip
    \penalty\@M
    \vbox to \z@{%
      \normalbaselines
      \ifdim\linewidth=\columnwidth
      \else
        \parshape\@ne\@totalleftmargin\linewidth
      \fi
      \vss
      \noindent#1\par}%
    \penalty\@M
    \vskip-\baselineskip}%
  \penalty\@M}


%\def\adots{\mathinner{%
%  \mkern2mu\raise\p@\hbox{.}%
%  \mkern2mu\raise4\p@\hbox{.}\mkern1mu%
%  \raise7\p@\vbox{\kern7\p@\hbox{.}}\mkern1mu}}

\endinput
%%
%% End of file `LA-Book.cls'.