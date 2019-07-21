%% This file is macqassign.cls 
%%
%% Copyright 2009 by Vafa Khalighi
%%
%%%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{macqassign}[2009/03/01 v1 Typesetting Macquarie University (Sydney) assignments (Author: Vafa Khalighi)]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[twoside]{article}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage[T1]{fontenc}
\RequirePackage{fourier}
\RequirePackage[scaled]{helvet}
\RequirePackage{pifont}
\RequirePackage{graphicx}
\RequirePackage{pstricks}
\RequirePackage{fancybox}
\RequirePackage[top=2.5cm,bottom=2.5cm,left=2.5cm,right=2.5cm]{geometry}
\RequirePackage{enumerate}
\RequirePackage[%
    bookmarks=true,
    colorlinks=true,
    linkcolor=myblue,
    urlcolor=myblue,
    citecolor=myblue,
    hyperindex=false,
    hyperfootnotes=false,
    pdfcreator={macqassign Class v1 (Author: Vafa Khalighi)},
    ]{hyperref}

\RequirePackage{multicol}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LO,RE]{\bfseries\sffamily \@unit, Solution To Assignment \@assignmentnumber}
\fancyhead[RO,LE]{\bfseries\sffamily \@firstname\ \underline{\@lastname}, SID:~\@SID}
\newcount\TotalPages
\TotalPages=\z@
\def\NumberLastPage{9999}
\AtEndDocument{%
\immediate\write\@auxout{%
  \string\gdef\string\NumberLastPage{\the\TotalPages}}}
\fancyput(17.5cm,2.5cm){%
\psframe[linestyle=none,fillstyle=solid,fillcolor=yellow](1,-\paperheight)
\rput(0.5,-\pst@dimh){%
  \pscirclebox[fillstyle=solid,fillcolor=black]{%
    \textcolor{white}{\textbf{\textsf{\thepage}}}}}}
\let\@outputpageORIG\@outputpage
\def\@outputpage{%
\global\advance\TotalPages\@ne
\pst@cnth=\NumberLastPage
\advance\pst@cnth\@ne
\pst@dimh=\paperheight
\divide\pst@dimh\pst@cnth
\pst@dimg=\pst@dimh
\divide\pst@dimg\tw@
\pst@cntg=\thepage
\advance\pst@cntg\m@ne
\multiply\pst@dimh\pst@cntg
\advance\pst@dimh\pst@dimg
\@outputpageORIG}
\def\assignmentnumber#1{\gdef\@assignmentnumber{#1}}
\def\firstname#1{\gdef\@firstname{#1}}
\def\lastname#1{\gdef\@lastname{#1}}
\def\SID#1{\gdef\@SID{#1}}
\def\unit#1{\gdef\@unit{#1}}
\definecolor{myblue}{rgb}{0.02,0.04,0.48}

\def\maketitle{\begin{titlepage}
\setcounter{page}{0}
\noindent
\begin{pspicture}(0,13.5)(\linewidth,0)
  \psline[linewidth=3mm,linecolor=pink](0,13.5)(\linewidth,13.5)
  \rput(\linewidth,13.5)
    {\pspolygon*(-3.6,0)(-1.4,0)(0,-1.4)(0,-3.6)}
  \rput(\linewidth,13.5)
    {\rput{-45}(-1,-1){\Large\textbf{\white \sffamily Macquarie}}}
  \rput(\linewidth,13.5)
    {\rput{-45}(-1.5,-1.5){\Large\textbf{\white\sffamily University}}}

  \rput[l](0,3.7){\textsl{\Huge\bfseries\sffamily Solution To}}
  \psline[linewidth=3mm,linecolor=pink](0,3)(\linewidth,3)
  \psline[linewidth=3mm,linecolor=pink](0,0)(\linewidth,0)
  \rput[b](0.5\linewidth,4)
    {\includegraphics[height=0.4\textheight]{logo}}
  \rput[l](0,1.5){\psscaleboxto(\textwidth,2){Assignment \@assignmentnumber}}
\end{pspicture}

\vfill\noindent
{\huge \textbf{\sffamily \@unit}} \hfill
{\large\textsf{\@firstname\ \underline{\@lastname}, SID:~\@SID}}
\end{titlepage}}
\newenvironment{acknowledgement}{\def\abstractname{\textbf{\sffamily Acknowledgement}}\begin{abstract}\sffamily}{\end{abstract}}
\def\proofname{\textbf{\sffamily Proof}}
\setlength\columnseprule{0.4pt}
\renewcommand\tableofcontents{%
  \begin{multicols}{2}[\section*{\contentsname}]%
    \small\sffamily
    \@starttoc{toc}%
  \end{multicols}}
\definecolor{mygreen}{rgb}{0,.43,0}
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\Large\bfseries\sffamily\color{mygreen}}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\large\bfseries\sffamily\color{mygreen}}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries\sffamily\color{mygreen}}}
\endinput
