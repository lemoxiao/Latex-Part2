%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% finalexamz - LaTeX Template & Tool for Exam Preparation
%
% Version 1.4.0
%
% Developed by Galaa (www.galaa.mn)
% Copyright (c) 2015-2016 Galaa
% License: LATEX Project Public License (LPPL) (http://www.latex-project.org/lppl.txt)
% Project home page: https://github.com/galaamn/FinalExamZ
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{finalexamz}[2016/12/24 FinalExamZ -- LaTeX class for Exam Preparation - Version 1.4.0]
\NeedsTeXFormat{LaTeX2e}

%% Base class options

\DeclareOption{draft}{
  \PassOptionsToClass{\CurrentOption}{article}
}

\DeclareOption{10pt}{
  \PassOptionsToClass{\CurrentOption}{article}
}

\DeclareOption{11pt}{
  \PassOptionsToClass{\CurrentOption}{article}
}

\DeclareOption{12pt}{
  \PassOptionsToClass{\CurrentOption}{article}
}

%% Class specific options

\DeclareOption{solution}{
  \newcommand{\printsolution}{yes}
}

\DeclareOption{mongolian}{
  \newcommand{\mongolian}{yes}
}

%% Fallback
\DeclareOption*{
  \ClassWarning{finalexamz}{Unknown option '\CurrentOption'}
}

%% Execute default options
\ExecuteOptions{10pt}

%% Process given options
\ProcessOptions\relax

%% Load base class
\LoadClass[oneside]{article}

%% Required packages
\RequirePackage[utf8]{inputenc}
\ifdefined\mongolian
  \usepackage[mongolian]{babel}
\else
  % command \mongolian does not exists
\fi
\RequirePackage{amsmath,amssymb,textcomp,fmtcount,graphicx,xcolor,fancyhdr,ifthen,background,xstring,tikz,listings}
\RequirePackage[a4paper,margin=2cm,top=2.5cm,left=3cm,bottom=2.5cm]{geometry}
\RequirePackage[normalem]{ulem}

%% Language definition

\ifdefined\mongolian
  % Mongolian
  \def\institution{СУРГУУЛИЙН НЭР}
  \def\logo{logo.png}
  \def\examtype{Хаврын улирлын шалгалт}
  \def\examdate{2015}
  \def\coursetitle{Хичээлийн нэр}
  \def\coursecode{INDEX555}
  \def\teacher{Г.Махгал}
  \def\totaltime{90 минут}
  \def\materials{Тооны машин; өөрийн ном, лекцийн тэмдэглэл}
  \def\caution{Нэмэлт анхааруулга, санамж, зөвлөмж}
  % internal
  \def\@key{Бодолт, Хариу, Түлхүүр}
  \def\@studentinfo{Оюутны мэдээлэл}
  \def\@fill{бүрэн гүйцэд бөглөнө үү}
  \def\@studentfirstname{Овог}
  \def\@studentlastname{Нэр}
  \def\@studentid{ID}
  \def\@studentnameonheader{Оюутны овог ба нэр}
  \def\@studentidonheader{Оюутны ID}
  \def\@attention{Анхаарамж}
  \def\@time{Шалгалтын нийт хугацаа}
  \def\@permittedmaterials{Зөвшөөрөгдсөн материал}
  \def\@goodluck{Амжилт хүсье!}
  \def\@variant{хувилбар}
  \def\@poweredby{\LaTeX\ ашиглав.}
  \def\@developer{Галаа}
  \def\@problem{Бодлого}
  \def\@solution{Бодолт}
  \def\@question{Асуулт}
  \def\@answer{Хариулт}
  \def\@selectivetest{Сонгох тест}
  \def\@selection{Сонголт}
  \def\@rightselection{Зөв сонголт}
  \def\@placementtest{Нөхөх тест}
  \def\@score{оноо}
  \def\@totalscore{нийт оноо}
  \def\@theendofexamination{Шалгалтын материалын төгсгөл}
  \def\@page{хуудас}
\else
  % English
  \def\institution{INSTITUTION}
  \def\institution{UNIVERSITY NAME}
  \def\logo{logo.png}
  \def\examtype{Final Exam}
  \def\examdate{2015}
  \def\coursetitle{Course Title}
  \def\coursecode{INDEX555}
  \def\teacher{Teacher Name}
  \def\totaltime{2 hours}
  \def\materials{Permitted materials}
  \def\caution{Any Caution}
  % internal
  \def\@key{Solution}
  \def\@studentinfo{Student Information}
  \def\@fill{fill completely}
  \def\@studentfirstname{First Name}
  \def\@studentlastname{Last Name}
  \def\@studentid{ID}
  \def\@studentnameonheader{Full Name}
  \def\@studentidonheader{Student ID}
  \def\@attention{Attention}
  \def\@time{Exam Duration}
  \def\@permittedmaterials{Permitted Materials}
  \def\@goodluck{Good luck!}
  \def\@variant{variant}
  \def\@poweredby{Powered by \LaTeX.}
  \def\@developer{Galaa}
  \def\@problem{Problem}
  \def\@solution{Solution}
  \def\@question{Question}
  \def\@answer{Answer}
  \def\@selectivetest{Selective Test}
  \def\@selection{Selection}
  \def\@rightselection{Key}
  \def\@placementtest{Placement Test}
  \def\@score{point}
  \def\@totalscore{Total point}
  \def\@theendofexamination{The End of Examination}
  \def\@page{page}
\fi

%% Required commands

\ifdefined\printsolution
  % command \printsolution exists
\else
  \newcommand{\printsolution}{no}
\fi

\SetBgContents{\textcolor{black}{\tiny FinalExamZ\ \copyright\ 2015\ifthenelse{\equal{\the\year}{2015}}{}{--\the\year}\ \@developer\ (www.galaa.mn).\ \@poweredby}}
\SetBgPosition{17.5cm,-20cm}
\SetBgOpacity{1.0}
\SetBgAngle{90.0}
\SetBgScale{1.0}

\newcounter{variant}

\pagestyle{fancy}
\ifthenelse{\equal{\printsolution}{yes}}{}{
 \lhead{\@studentnameonheader: $\ldots\ldots\ldots\ldots\ldots\ldots\ldots$} \chead{} \rhead{\@studentidonheader: $\ldots\ldots\ldots\ldots\ldots\ldots\ldots$}
}
\lfoot{} \cfoot{\footnotesize{\@page\ $\dfrac{\thepage}{\pageref{finalpage\Alph{variant}}}$ $\ast$ \coursetitle\ \ifthenelse{\equal{\coursecode}{}}{}{(\coursecode)\ }$\ast$ \@variant\ \arabic{variant}}} \rfoot{} 

\renewcommand{\headrulewidth}{0pt} %Do not print a rule below the header
\renewcommand{\footrulewidth}{0pt}

% Source Code Listing

\lstset{
  language=r,
  basicstyle={\ttfamily\color{black!85}},
%  backgroundcolor=\color{black!25},
  keywordstyle=\color{black},
  commentstyle=\it\color{black!75},
  stringstyle=\color{black!75},
  breakatwhitespace=true,
  breaklines=true,
  frame=trb,
  framesep=5pt,framerule=0.5pt,
  linewidth=0.94\linewidth,
%  xleftmargin=6ptpt,xrightmargin=6ptpt,
  rulecolor=\color{black!50},
  keepspaces=true,
  showstringspaces=false,
  columns=flexible,
  numbers=right,
  numbersep=12pt,
  numberstyle=\scriptsize\color{black!65},
  tabsize=3,
  otherkeywords={},
  deletendkeywords={},
  deletekeywords={}
}

\newsavebox{\lstListing}

\newcommand{\printlisting}{
\par\noindent\\[-5pt]
\usebox{\lstListing}
\par\noindent\\[5pt]
}

% Cover Page

\newcommand{\coverpage}{
\thispagestyle{empty}
\ifthenelse{\equal{\logo}{}}{
$\,$
\vspace{1.5cm}
}{
\begin{center}
\includegraphics[height=3cm]{\logo}\\[1cm]
\end{center}
}
\begin{center}
\Large\textbf{\institution}
\end{center}
\vspace{1.5cm}

\begin{center}
\Large\textit{ \examtype\,\,--\,\,\examdate \\ \@variant: \arabic{variant} }
\end{center}
\vspace{1.5cm}

\begin{center}
\Huge\textbf{\coursetitle}
\end{center}
\begin{center}
\large\textbf{\coursecode}
\end{center}
\begin{center}
\Large\textbf{\teacher}
\end{center}
\vspace{1.5cm}

\begin{center}
\large
\ifthenelse{\equal{\printsolution}{yes}}{
\@key
}{
$$
\begin{array}{rl}
\text{\@studentinfo} & \text{\footnotesize(\textit{\@fill})} \\[0.2cm]
\text{\@studentfirstname} & $\ldots\ldots\ldots\ldots\ldots\ldots\ldots$ \\[0.2cm]
\text{\@studentlastname} & $\ldots\ldots\ldots\ldots\ldots\ldots\ldots$ \\[0.2cm]
\text{\@studentid} & $\ldots\ldots\ldots\ldots\ldots\ldots\ldots$
\end{array}
$$
}
\end{center}
\newpage
} % End of Cover Page

% Attention

\newcommand{\attention}{
  \ifthenelse{\equal{\printsolution}{yes}}{}{
   \paragraph{\@attention} \hfill {\small \@goodluck}
   \begin{itemize}
    \setlength{\itemsep}{0mm}
    \item \@time: \totaltime
    \ifthenelse{\equal{\materials}{}}{}{\item \@permittedmaterials: \materials}
    \ifthenelse{\equal{\caution}{}}{}{\item \caution}
   \end{itemize}
   \vspace{-0.5em} \textcolor{black!50}{\hrulefill}
  }
}

% Variant

\newcounter{number}
\newcounter{totalpoint}

\newenvironment{variant}{
  % begin
  \newpage
  \setcounter{page}{1}
  \addtocounter{variant}{1}
  \setcounter{number}{1}
  \setcounter{totalpoint}{0}
}{
  % end
  \paragraph{} \hfill \@totalscore\ \arabic{totalpoint}
  \begin{center}
    $\ast\ast\ast$ \textit{\@theendofexamination}\ $\ast\ast\ast$
    \label{finalpage\Alph{variant}}
  \end{center}
}

% Problem

\newcommand{\problem}[4][1.5]{
 \paragraph{\textnumero\arabic{number}.} \hspace{-1em} {\small\textit{\@problem}} \addtocounter{number}{1} \hfill {\small\textit{#3 \@score}} \addtocounter{totalpoint}{#3} \\[2mm] 
 #2 
 \vspace{2mm} \par \textit{\@solution}: \par %
 \ifthenelse{\equal{\printsolution}{yes}}{\vspace{0.5em} #4}{\vspace{-1.5em} \ \vspace*{#1cm}}
 \ \newline \textcolor{black!50}{\hrulefill}
}

% Question

\newcommand{\question}[4][0.5]{
 \paragraph{\textnumero\arabic{number}.} \hspace{-1em} {\small\textit{\@question}} \addtocounter{number}{1} \hfill {\small\textit{#3 \@score}} \addtocounter{totalpoint}{#3} \\[2mm] 
 #2 
 \vspace{2mm} \par \textit{\@answer}: \par %
 \ifthenelse{\equal{\printsolution}{yes}}{\vspace{0.5em} #4}{\vspace{-1.5em} \ \vspace*{#1cm}}
 \ \newline \textcolor{black!50}{\hrulefill}
}

% Selective Test

\newcounter{testchoices}

\newcommand{\stest}[3]{
 \paragraph{\textnumero\arabic{number}.} \hspace{-1em} {\small\textit{\@selectivetest}} \addtocounter{number}{1} \hfill {\small\textit{#2 \@score}} \addtocounter{totalpoint}{#2} \\[2mm] 
 #1 
 \vspace{2mm} \par \textit{\ifthenelse{\equal{\printsolution}{yes}}{\@rightselection}{\@selection}}: \setcounter{testchoices}{1}
 \begin{center}
  \splitlist{#3}
 \end{center}
 \textcolor{black!50}{\hrulefill}
}

\newcommand{\splitlist}[1]{\@splitlist#1\@nil}
\def\@splitlist#1\@nil{%
  \if\relax\detokenize{#1}\relax
    \expandafter\@gobble
  \else
    \expandafter\@firstofone
  \fi
  {\@spl@tlist#1//\@nil}%
}
\def\@spl@tlist#1//#2\@nil{%
  \ifthenelse{\equal{\printsolution}{yes}}{
    \IfSubStr{#1}{[+]}{\textcircled{\Alph{testchoices}}}{\Alph{testchoices}.}
  }{\Alph{testchoices}.}
  \nolinebreak\ \nolinebreak
  \StrSubstitute[0]{#1}{[+]}{}\qquad \addtocounter{testchoices}{1}
  \if\relax\detokenize{#2}\relax
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
  {\unskip}%
  {\@spl@tlist#2\@nil}%
}

% Placement Test

\newcommand{\ptest}[2]{
 \paragraph{\textnumero\arabic{number}.} \hspace{-1em} {\small\textit{\@placementtest}} \addtocounter{number}{1} \hfill {\small\textit{#2 \@score}} \addtocounter{totalpoint}{#2} \\[2mm] 
 #1 
 \vspace{0.5em}
 \par\noindent
 \textcolor{black!50}{\hrulefill}
}

\newcommand{\ehide}[1]{\ifthenelse{\equal{\printsolution}{yes}}{\underline{#1}}{\underline{\phantom{#1}}}}

\newcommand{\thide}[1]{\ifthenelse{\equal{\printsolution}{yes}}{\emph{#1}}{\uline{#1}}}

\def\UL@putbox{\ifx\UL@start\@empty \else % not inner
  \vrule\@width\z@ \LA@penalty\@M
  {\UL@skip\wd\UL@box \UL@leaders \kern-\UL@skip}%
    \phantom{\box\UL@box}%
  \fi}

%% The End of Class