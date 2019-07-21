\pdfminorversion=4 % force pdf 1.4 output; http://tex.stackexchange.com/questions/95973/is-pdftex-1-40-13-outputting-malformed-pdfs

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sr}

\LoadClass[11pt]{book}
% Note that 11 pt does work with pdflatex, even though 11 pt is not one of the sizes
% of CM. I don't know whether it scales up 10 pt or scales down 12 pt, but anyway, it
% works.
%====================== counters =====================================================
\newcounter{dqctr}[subsection]
\newcounter{egctr}[chapter]
\newcounter{scctr}[chapter]
\newcounter{hwctr}[chapter]
%====================== packages =====================================================
\RequirePackage{amsmath}
\def\maketag@@@#1{\hbox{\m@th#1}} % workaround for bug in amsmath; see http://tex.stackexchange.com/a/155719/6853
\RequirePackage{url,tensor,learn-cmd-syntax,tikz,birdtracks,enumerate}
% enumerate is for lc roman numerals, which I sometimes want so items don't look like equation numbers
\StartSaveCommands % for learn-cmd-syntax
%====================== pull in sub-packages =====================================================
\RequirePackage{lmlanguage,lmlayout,lmcommon,lmfigs,lmenvironments}
% \RequirePackage[hidelinks]{hyperref} % doesn't work correctly, see meki, latex notes
%=====================================================================================
% In DP, we use italics for figref, but in LM that would look too much like an algebra
% symbol, so no italics.
\newcommand{\formatfigref}[1]{#1}

% titlesec stuff:
\titleformat{\chapter}[display]
    {\normalfont\huge\bfseries\sffamily\raggedright}{Chapter \thechapter}{0mm}
    {\Huge}
\newcommand{\normalsectiontitleformat}{
  \titleformat{\section}
    {\normalfont\Large\bfseries\sffamily\raggedright}{\showsecnum{\thesection}}{0.6em}{}
}
\normalsectiontitleformat
\titleformat{\subsection}
  {\normalfont\normalsize\bfseries\sffamily\raggedright\protect\sansmath}{\lmserifmath\showsecnum{\thesubsection}}{0.6em}{}
\titleformat{\subsubsection}
  {\normalfont\normalsize\slshape\raggedright}{\thesubsubsection}{1em}{}
%-------------------- sections and subsections -------------------------
% (chapter stuff is in lmfigs.cls, since it contains a lot of stuff for figures)
  \newcommand{\mysection}[2][4]{\pagebreak[#1]%
	\section{#2}\myeqnspacing%
        \setcounter{dqctr}{0}% gets done automatically for subsections, but I need to do it explicitly for sections that have no subsections
  }
  \newcommand{\myoptionalsection}[2][4]{\pagebreak[#1]%
	\section{$\star$ #2}\myeqnspacing}
  \newcommand{\mysubsection}[2][3]{\pagebreak[#1]\subsection{#2}}
  \newcommand{\mysubsectionnotoc}[2][3]{\pagebreak[#1]\subsection*{#2}}

\newcommand{\emt}{\mathcal{F}}%electromagnetic field tensor

\StopSaveCommands % for learn-cmd-syntax
\WriteSaveCommands  % for learn-cmd-syntax
%-------------
% http://tex.stackexchange.com/a/22101/6853
    \newsavebox\myboxA
    \newsavebox\myboxB
    \newlength\mylenA

    \newcommand*\xoverline[2][0.75]{%
        \sbox{\myboxA}{$\m@th#2$}%
        \setbox\myboxB\null% Phantom box
        \ht\myboxB=\ht\myboxA%
        \dp\myboxB=\dp\myboxA%
        \wd\myboxB=#1\wd\myboxA% Scale phantom
        \sbox\myboxB{$\m@th\overline{\copy\myboxB}$}%  Overlined phantom
        \setlength\mylenA{\the\wd\myboxA}%   calc width diff
        \addtolength\mylenA{-\the\wd\myboxB}%
        \ifdim\wd\myboxB<\wd\myboxA%
           \rlap{\hskip 0.5\mylenA\usebox\myboxB}{\usebox\myboxA}%
        \else
            \hskip -0.5\mylenA\rlap{\usebox\myboxA}{\hskip 0.5\mylenA\usebox\myboxB}%
        \fi}
