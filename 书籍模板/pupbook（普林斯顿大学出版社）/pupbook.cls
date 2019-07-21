%% pupbook.cls
%% 
%% Revised book class for Princeton University Press
%% 
%% Copyright 2011-2012 PUP
%%
%% Based on the memoir class by Peter Wilson
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.3 of this license or (at your option) any
%% later version.
%% The latest version of the license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of
%% LaTeX version 2003/06/01 or later.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pupbook}%
              [2012/08/01 v1.9 Princeton University Press book class]
\let\@xp=\expandafter
\let\@nx=\noexpand
\def\@oparg#1[#2]{\@ifnextchar[{#1}{#1[#2]}}
\long\def\@ifempty#1{\@xifempty#1@@..\@nil}
\long\def\@xifempty#1#2@#3#4#5\@nil{%
  \ifx#3#4\@xp\@firstoftwo\else\@xp\@secondoftwo\fi}
\long\def\@ifnotempty#1{\@ifempty{#1}{}}
\newcommand{\@ptsize}{}
\newlength{\onelineskip}
\newlength{\lxvchars}
\newlength{\xlvchars}
\newlength{\opttextwidth}
\newcount\@pupcnta
\newif\if@restonecol
\newif\if@openright
  \@openrighttrue

\newif\if@openleft
  \@openleftfalse

\newif\if@mainmatter
  \@mainmattertrue

\newif\if@pupoldfont
  \@pupoldfontfalse

\newcommand*{\@puperror}{\ClassError{pup}}
\newcommand*{\@pupwarn}{\ClassWarning{pup}}


\newif\ifsamename
\newcommand{\nametest}[2]{%
  \samenamefalse
  \begingroup
  \def\@puptempa{#1} \def\@puptempb{#2}
  \ifx \@puptempa\@puptempb
    \endgroup
    \samenametrue
  \else
    \endgroup
  \fi}

\newif\ifp@p@And
\newif\ifp@p@Or
\newif\ifp@p@Xor

\newcommand{\kill@lastcounter}[1]{%
  \count\count10 \z@
  \advance\count10 \m@ne
  \expandafter\let\csname c@#1\endcsname\relax}

\newcommand{\@name@p@xdef}[1]{%
  \expandafter\protected@xdef\csname #1\endcsname}
\newcommand{\@name@unresp@xdef}[1]{%
  \expandafter\unrestored@protected@xdef\csname #1\endcsname}
\newcommand{\@namelet}[1]{%
  \expandafter\let\csname #1\endcsname}
\newcommand{\@namelongdef}[1]{%
  \long\expandafter\def\csname #1\endcsname}

\newcommand{\pupjustarg}[1]{#1}
\newcommand{\pupgobble}[1]{}

\newcommand*{\@pupfakeusepackage}[1]{%
  \@namelet{ver@#1.sty}\@empty}

\RequirePackage{graphicx}

\providecommand*{\EmulatedPackage}{}
\renewcommand*{\EmulatedPackage}[1]{%
  \@ifnextchar[{\@emulated@package{#1}}%
               {\@emulated@package{#1}[]}%]
}
\providecommand*{\EmulatedPackageWithOptions}{}
\renewcommand*{\EmulatedPackageWithOptions}[2]{%
  \PassOptionsToPackage{#1}{#2}%
  \EmulatedPackage{#2}%
}
\def\@emulated@package#1[#2]{%
  \expandafter\xdef\csname ver@#1.\@pkgextension\endcsname{#2}%
  \@ifundefined{opt@#1.\@pkgextension}%
    {\@namedef{opt@#1.\@pkgextension}{}}{}%
  \wlog{Package #1 \if,\csname opt@#1.\@pkgextension\endcsname,\else
        (with options \csname opt@#1.\@pkgextension\endcsname)\fi
        emulated by \@currname.}%
}
\@onlypreamble\EmulatedPackage
\@onlypreamble\EmulatedPackageWithOptions
\@onlypreamble\@emulated@package

\newif\ifpdf
\ifx\pdfoutput\undefined
\else
  \ifx\pdfoutput\relax
  \else
    \ifcase\pdfoutput
    \else
      \pdftrue
    \fi
  \fi
\fi

\newcommand{\phantomsection}{}

 \renewcommand*{\nofiles}{%
   \@fileswfalse%  flag for suppressing \immediate \writes
   \typeout{No auxiliary output files.^^J}%
   \long\def\protected@write##1##2##3%
     {\write\m@ne{}\if@nobreak\ifvmode\nobreak\fi\fi}%
   }

\edef\wo@dmacro{%
  \string m\string a\string c\string r\string o\string :%
}

\def\wo@difmacro@begingroup#1{%
  \begingroup
    \edef\x{%
      \noexpand\wo@dparsemacro\meaning#1\wo@dmacro\string -%
    }%
    \x\@nil{#1}%
}

\begingroup
  \edef\x{\endgroup
    \def\noexpand\wo@dparsemacro##1\wo@dmacro##2\string -}%
\x#3\@nil#4{%
  \ifx\\#3\\%
    \endgroup
    \@pupwarn{\string `\string #4\string ' is not a macro}%
    \expandafter\@gobble
  \else
    \expandafter\@firstofone
  \fi
}

\def\addtodef{\@star@or@long\wo@daddtodef}
\long\def\wo@daddtodef#1#2#3{%
  \wo@difmacro@begingroup{#1}{%
    \@temptokena{#2}%
    \toks@\expandafter{#1#3}%
    \edef\x{\endgroup
         \l@ngrel@x\def\noexpand#1{\the\@temptokena \the\toks@}}%
    \x
  }%
}

\def\addtoiargdef{\@star@or@long\wo@daddtoiargdef}
\long\def\wo@daddtoiargdef#1#2#3{%
  \wo@difmacro@begingroup{#1}{%
    \@temptokena{#2}%
    \toks@\expandafter{#1{##1}#3}%
    \edef\x{\endgroup
       \l@ngrel@x\def\noexpand#1####1{\the\@temptokena \the\toks@}}%
    \x
  }%
}

%%%%%%%%%%%%%%%% Michael Downes' patchcmd 2000/07/31 v1.03 %%%%%%%%
\newcommand{\patchcommand}[1]{%
  \expandafter\patchcmd@a\meaning#1??->@\@nil#1%
}
\long\def\patchcmd@a#1#2#3->#4#5\@nil#6{%
  \ifx @#4\relax \patchcmdError#6#1%
    \expandafter\@gobbletwo % discard the other two arguments
  \else
    \if l#2\toks@{\patchcmd@e{}#6}% l in this position means \long
    \else \toks@{\patchcmd@e*#6}%   not \long
    \fi
    \patchcmd@b #3@#4#5 ? ? ? \@nil#6%
    \expandafter\the\expandafter\toks@
  \fi}
\def\patchcmd@b#1:#2@#3#4 #5#6 #7 #8\@nil#9{%
  \if \ifx @#7@\expandafter
      \ifx\csname #6\endcsname#9T\else F\fi\else F\fi T%
    \toks@\expandafter{\expandafter\patchcommand\csname #6 \endcsname}%
  \else
    \ifx @#2@% No arguments
      \toks@\expandafter{\the\toks@ 0}%
    \else
      \patchcmd@c 0#2{\string##}0%
    \fi
  \fi}
\def\patchcmd@c#1#2#3{%
  \if\string###2%      % yes it's a # token
    \ifodd 0#31 % and it's followed by a number
      \if 0#3\patchcmd@d#1\fi % number=0? then we're done
    \else \patchcmd@d D% # not a number: must be a delimited arg
    \fi
  \else \patchcmd@d D% not a # token: must be a delmited arg
  \fi
  \patchcmd@c#3}
\def\patchcmd@d#1{%
  \if D#1%
%%%    \PackageError{patchcmd}{Cannot change a macro that has
%%%      delimited arguments}\@ehd
    \@puperror{%
      Cannot change a macro that has delimited arguments}{\@ehd}
  \else
    \toks@\expandafter{\the\toks@ #1}%
  \fi
  \begingroup
  \aftergroup\@gobble
  \let\patchcmd@c\endgroup}
\def\patchcmd@e#1#2#3#4#5{%
  \begingroup
  \edef\@##1{%
    \@temptokena\noexpand\expandafter{%
      \noexpand#2%
        \ifnum#3>0 {####1}\ifnum#3>1 {####2}\ifnum#3>2 {####3}%
        \ifnum#3>3 {####4}\ifnum#3>4 {####5}\ifnum#3>5 {####6}%
        \ifnum#3>6 {####7}\ifnum#3>7 {####8}\ifnum#3>8 {####9}%
        \fi\fi\fi\fi\fi\fi\fi\fi\fi
      ##1%
    }%
  }
  \@{#5}%
  \edef\@##1{\endgroup
    \noexpand\renewcommand#1\noexpand#2\ifcase#3 \else [#3]\fi
    {##1\the\@temptokena}}%
  \@{#4}%
}
\long\def\patchcmdError#1#2{%
  \begingroup
  \toks@{Not redefinable}%
  \ifcat\relax\noexpand#1% Is it a control sequence?
    \begingroup
    \let#1=?\ifx ?\relax % Is it "\relax"?
      \endgroup % accept current value of \toks@
    \else \endgroup
      \if\ifx\relax#1u\else #2\fi u%
        \toks@{Not defined}%
      \fi
    \fi
  \fi
  \edef\@{\endgroup
%%%    \noexpand\PackageError{patchcmd}{%
%%%      \the\toks@: \string#1}\noexpand\@ehd}%
    \noexpand\@puperror{%
      \the\toks@: \string#1}\noexpand\@ehd}%
  \@}

%%%%%%%%%%%%%%%%%%%%% end of patchcmd code %%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\stockheight}
\newlength{\stockwidth}
\newlength{\trimtop}
\newlength{\trimedge}

\DeclareOption{a3paper}
   {\setlength\stockheight {420mm}%
    \setlength\stockwidth  {297mm}}
\DeclareOption{a4paper}
   {\setlength\stockheight {297mm}%
    \setlength\stockwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\stockheight {210mm}%
    \setlength\stockwidth  {148mm}}
\DeclareOption{a6paper}
   {\setlength\stockheight {148mm}%
    \setlength\stockwidth  {105mm}}
\DeclareOption{b3paper}
   {\setlength\stockheight {500mm}%
    \setlength\stockwidth  {353mm}}
\DeclareOption{b4paper}
   {\setlength\stockheight {353mm}%
    \setlength\stockwidth  {250mm}}
\DeclareOption{b5paper}
   {\setlength\stockheight {250mm}%
    \setlength\stockwidth  {176mm}}
\DeclareOption{b6paper}
   {\setlength\stockheight {176mm}%
    \setlength\stockwidth  {125mm}}
\DeclareOption{letterpaper}
   {\setlength\stockheight {11in}%
    \setlength\stockwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\stockheight {14in}%
    \setlength\stockwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\stockheight {10.5in}%
    \setlength\stockwidth  {7.25in}}
\DeclareOption{ebook}
   {\setlength\stockheight {9in}%
    \setlength\stockwidth  {6in}}
\DeclareOption{landscape}
  {\setlength\@tempdima  {\stockheight}
   \setlength\stockheight{\stockwidth}
   \setlength\stockwidth {\@tempdima}}

\renewcommand{\@ptsize}{0}
\DeclareOption{9pt}{\renewcommand{\@ptsize}{9}}
\DeclareOption{10pt}{\renewcommand{\@ptsize}{0}}
\DeclareOption{11pt}{\renewcommand{\@ptsize}{1}}
\DeclareOption{12pt}{\renewcommand{\@ptsize}{2}}
\DeclareOption{14pt}{\renewcommand{\@ptsize}{4}}
\DeclareOption{17pt}{\renewcommand{\@ptsize}{7}}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\newif\ifdraftdoc\draftdocfalse
\setlength{\overfullrule}{\z@}
\DeclareOption{final}{\setlength{\overfullrule}{\z@}
                      \draftdocfalse
                      \msdocfalse}
\DeclareOption{draft}{\setlength\overfullrule{5pt}%
                      \draftdoctrue
                      \msdocfalse}

\DeclareOption{6x9}{%
\def\timedate{\raisebox{52pt}[0pt][0pt]{\jobname\quad\today\quad6x9}}
\setlength{\opttextwidth}{28.8pc}
  \AtBeginDocument{
    \settrimmedsize{9.25in}{6.125in}{*}
    \setlrmarginsandblock{4.5pc}{3.5pc}{}
    \setulmarginsandblock{*}{5.5pc}{*}
    \setlength{\trimtop}{\stockheight}
    \addtolength{\trimtop}{-\paperheight}
    \setlength{\trimedge}{\stockwidth}
    \addtolength{\trimedge}{-\paperwidth}
    \settrims{.5\trimtop}{.5\trimedge}
    \checkandfixthelayout}
}
\DeclareOption{7x10}{%
   \def\timedate{\raisebox{50pt}[0pt][0pt]{\jobname\quad\today\quad7x10}}
   \setlength{\opttextwidth}{30pc}
   \AtBeginDocument{
     \renewcommand{\cftchapterleader}{\hfill}
     \renewcommand{\cftsectionleader}{\hfill}
     \settrimmedsize{10in}{7in}{*}
     \setlrmarginsandblock{6.5pc}{5.5pc}{*}
     \setulmarginsandblock{*}{5.5pc}{*}
     \setlength{\trimtop}{\stockheight}
     \addtolength{\trimtop}{-\paperheight}
     \setlength{\trimedge}{\stockwidth}
     \addtolength{\trimedge}{-\paperwidth}
     \settrims{.5\trimtop}{.5\trimedge}
     \checkandfixthelayout}
}

\DeclareOption{copyedit}{%
   \renewcommand{\@ptsize}{2}
   \def\timedate{\raisebox{50pt}[0pt][0pt]{\jobname\quad\today\quad Copyedit}}
   \AtBeginDocument{
     \settrimmedsize{11in}{8.5in}{*}
     \setlrmarginsandblock{4.5pc}{4.5pc}{}
     \setulmarginsandblock{*}{5.5pc}{*}
     \setlength{\trimtop}{\stockheight}
     \addtolength{\trimtop}{-\paperheight}
     \setlength{\trimedge}{\stockwidth}
     \addtolength{\trimedge}{-\paperwidth}
     \settrims{.5\trimtop}{.5\trimedge}
     \checkandfixthelayout\linespread{2}}
}

\newif\ifmsdoc
  \msdocfalse
\DeclareOption{ms}{%
  \msdoctrue
  \draftdocfalse
  \setlength\overfullrule{\z@}
}

\newif\ifshowtrims
  \showtrimsfalse
\DeclareOption{showtrims}{\showtrimstrue}

\newif\ifartopt
  \artoptfalse
\DeclareOption{article}{\artopttrue}

\DeclareOption{subfigure}{%
  \ClassWarningNoLine{pup}{The subfigure option is not required}}

\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{openleft}{\@openlefttrue}
\newcommand{\openright}{\@openrighttrue\@openleftfalse%
  \gdef\clearforchapter{\cleartorecto}}
\newcommand{\openany}{\@openrightfalse\@openleftfalse%
  \gdef\clearforchapter{\clearpage}}
\newcommand{\openleft}{\@openlefttrue
  \gdef\clearforchapter{\cleartoverso}}

\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfClass{%
    \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
     }%
    \renewcommand\newblock{\par}}%
}

\DeclareOption{oldfontcommands}{%
  \@pupoldfonttrue}

\ExecuteOptions{final,letterpaper,10pt,onecolumn,openany,twoside,6x9,showtrims}
\ProcessOptions

\def\cleartorecto{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}\thispagestyle{cleared}%
  \newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\def\cleartoverso{\clearpage\if@twoside
  \ifodd\c@page\hbox{}\thispagestyle{cleared}%
  \newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}


\if@openleft
  \openleft
\else
  \if@openright
    \openright
  \else
    \openany
  \fi
\fi

\ifnum\@ptsize = 9\relax
  \input{pup\@ptsize.clo}
\else
  \input{pup1\@ptsize.clo}
\fi
\newcommand{\captionsize}{\normalsize}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand{\baselinestretch}{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\clubpenalty  1000
\widowpenalty 1000
\newcommand{\setlxvchars}[1][\normalfont]{\begingroup
  #1
  \settowidth{\lxvchars}{abcdefghijklmnopqrstuvwxyz}%
  \setlength{\lxvchars}{2.042\lxvchars}%
  \addtolength{\lxvchars}{33.41pt}%
  \global\lxvchars=\lxvchars
  \endgroup}
\newcommand{\setxlvchars}[1][\normalfont]{\begingroup
  #1
  \settowidth{\xlvchars}{abcdefghijklmnopqrstuvwxyz}%
  \setlength{\xlvchars}{1.415\xlvchars}%
  \addtolength{\xlvchars}{23.03pt}%
  \global\xlvchars=\xlvchars
  \endgroup}

\newcommand{\setrectanglesize}[3]{%
  \nametest{#1}{*}%
  \ifsamename                           % H = *
    \nametest{#2}{*}%
    \ifsamename                         % W = *
      \@puperror{%
        The combination of argument values is ambiguous.\MessageBreak
        The lengths will be set to zero}{\@ehd}
      \@tempdima = \z@
      \@tempdimb = \z@
    \else                               % W
      \nametest{#3}{*}%
      \ifsamename                       % r = *
        \@tempdimb = #2\relax
        \@tempdima = \@tempdimb
      \else                             % r
        \@tempdimb = #2\relax
        \@tempdima = #3\@tempdimb
      \fi
    \fi
  \else                                 % H
    \nametest{#2}{*}%
    \ifsamename                         % W = *
      \nametest{#3}{*}%
      \ifsamename                       % r = *
        \@tempdima = #1\relax
        \@tempdimb = \@tempdima
      \else                             % r
        \@tempdima = #1\relax
        \@tempdimb = #3\@tempdima
      \fi
    \else                               % W
      \@tempdima = #1\relax
      \@tempdimb = #2\relax
    \fi
  \fi
}

\newcommand{\setfillsize}[5]{%
  \nametest{#2}{*}%
  \ifsamename                                % C = *
    \nametest{#3}{*}%
    \ifsamename                              % L = *
      \nametest{#4}{*}%
      \ifsamename                            % R = *
        \@puperror{%
          The combination of argument values is ambiguous.\MessageBreak
          The lengths will be set to zero}{\@ehd}
        \@tempdima = \z@
        \@tempdimb = \z@
        \@tempdimc = \z@
      \else                                  % R
        \nametest{#5}{*}%
        \ifsamename                          % r = *
          \@tempdimb = #4\relax
          \@tempdima = \@tempdimb
          \@tempdimc = #1\relax
          \advance\@tempdimc -\@tempdima
          \advance\@tempdimc -\@tempdimb
        \else                                % r
          \@tempdimb = #4\relax
          \@tempdima = #5\@tempdimb
          \@tempdimc = #1\relax
          \advance\@tempdimc -\@tempdima
          \advance\@tempdimc -\@tempdimb
        \fi
      \fi
    \else                                    % L
      \nametest{#4}{*}%
      \ifsamename                            % R = *
        \nametest{#5}{*}%
        \ifsamename                          % r = *
          \@tempdima = #3\relax
          \@tempdimb = \@tempdima
          \@tempdimc = #1\relax
          \advance\@tempdimc -\@tempdima
          \advance\@tempdimc -\@tempdimb
        \else                                % r
          \@tempdima = #3\relax
          \@tempdimb = #5\@tempdima
          \@tempdimc = #1\relax
          \advance\@tempdimc -\@tempdima
          \advance\@tempdimc -\@tempdimb
        \fi
      \else                                  % R
        \@tempdima = #3\relax
        \@tempdimb = #4\relax
        \@tempdimc = #1\relax
        \advance\@tempdimc -\@tempdima
        \advance\@tempdimc -\@tempdimb
      \fi
    \fi
  \else                                      % C is valued
    \nametest{#3}{*}%
    \ifsamename                              % L = *
      \nametest{#4}{*}%
      \ifsamename                            % R = *
        \nametest{#5}{*}%
        \ifsamename                          % r = *
          \@tempdimc = #2\relax
          \@tempdima = #1\relax
          \advance\@tempdima -\@tempdimc
          \@tempdima = 0.5\@tempdima
          \@tempdimb = \@tempdima
        \else                                % r (CODE PERHAPS FIXED)
          \@tempdimc = #2\relax         % C
          \@tempdimb = #1\relax         % T
          \advance\@tempdimb -\@tempdimc % T - C
          \@tempdima = 1000sp
          \@tempdima = #5\@tempdima        % 1000r sp
          \advance\@tempdima by 1000sp   % 1000(1+r)sp
          \@tempcnta = \@tempdima        % 1000(1+r)
          \@tempdima = \@tempdimb        % T - C
          \divide\@tempdima by \@tempcnta  % (T-C)/1000(1+r) pts
          \@tempdima = 1000\@tempdima      % (T-C)/(1+r)  pts = L
          \advance\@tempdimb by -\@tempdima % = R
        \fi
      \else                                  % R
        \@tempdimc = #2\relax
        \@tempdimb = #4\relax
        \@tempdima = #1\relax
        \advance\@tempdima -\@tempdimc
        \advance\@tempdima -\@tempdimb
      \fi
    \else                                    % L
      \nametest{#4}{*}%
      \ifsamename                            % R = *
        \@tempdimc = #2\relax
        \@tempdima = #3\relax
        \@tempdimb = #1\relax
        \advance\@tempdimb -\@tempdimc
        \advance\@tempdimb -\@tempdima
      \else                                  % R
        \@puperror{%
          The combination of argument values is ambiguous.\MessageBreak
          The lengths will be set to zero}{\@ehd}%
        \@tempdima = \z@
        \@tempdimb = \z@
        \@tempdimc = #2\relax
      \fi
    \fi
  \fi
}

\newcommand{\setstocksize}[2]{%
  \setlength{\stockheight}{#1}%
  \setlength{\stockwidth}{#2}}
\newcommand{\settrims}[2]{%
  \setlength{\trimtop}{#1}%
  \setlength{\trimedge}{#2}}
\newcommand{\settrimmedsize}[3]{%
  \setrectanglesize{#1}{#2}{#3}%
  \setlength{\paperheight}{\@tempdima}%
  \setlength{\paperwidth}{\@tempdimb}}

\newcommand{\settypeblocksize}[3]{%
  \setrectanglesize{#1}{#2}{#3}%
  \setlength{\textheight}{\@tempdima}%
  \setlength{\textwidth}{\@tempdimb}}

\newlength{\spinemargin}
\newlength{\foremargin}
\newcommand{\setlrmargins}[3]{%
  \setfillsize{\paperwidth}{\textwidth}{#1}{#2}{#3}%
  \setlength{\textwidth}{\@tempdimc}%
  \setlength{\spinemargin}{\@tempdima}%
  \setlength{\foremargin}{\@tempdimb}}

\newcommand{\setlrmarginsandblock}[3]{%
  \setfillsize{\paperwidth}{*}{#1}{#2}{#3}%
  \setlength{\textwidth}{\@tempdimc}%
  \setlength{\spinemargin}{\@tempdima}%
  \setlength{\foremargin}{\@tempdimb}}

\newlength{\uppermargin}
\newlength{\lowermargin}
\newcommand{\setulmargins}[3]{%
  \setfillsize{\paperheight}{\textheight}{#1}{#2}{#3}%
  \setlength{\textheight}{\@tempdimc}%
  \setlength{\uppermargin}{\@tempdima}%
  \setlength{\lowermargin}{\@tempdimb}}

\newcommand{\setulmarginsandblock}[3]{%
  \setfillsize{\paperheight}{*}{#1}{#2}{#3}%
  \setlength{\textheight}{\@tempdimc}%
  \setlength{\uppermargin}{\@tempdima}%
  \setlength{\lowermargin}{\@tempdimb}}

\newlength{\headdrop}
\newcommand{\setheaderspaces}[3]{%
  \setfillsize{\uppermargin}{\headheight}{#1}{#2}{#3}%
  \setlength{\headheight}{\@tempdimc}%
  \setlength{\headdrop}{\@tempdima}%
  \setlength{\headsep}{\@tempdimb}}

\newcommand{\setheadfoot}[2]{%
  \setlength{\headheight}{#1}%
  \setlength{\footskip}{#2}}

\newcommand{\setcolsepandrule}[2]{%
  \setlength{\columnsep}{#1}%
  \setlength{\columnseprule}{#2}}

\newcommand{\setmarginnotes}[3]{%
  \setlength{\marginparsep}{#1}%
  \setlength{\marginparwidth}{#2}%
  \setlength{\marginparpush}{#3}}

\settrimmedsize{\stockheight}{\stockwidth}{*}
\settrims{\z@}{\z@}

\setlength{\@tempdimb}{1.14\lxvchars}
\setlength\@tempdima{\paperwidth}
  \addtolength\@tempdima{-2in}
\if@twocolumn
  \ifdim\@tempdima>2\@tempdimb\relax
    \setlength\textwidth{2\@tempdimb}
  \else
    \setlength\textwidth{\@tempdima}
  \fi
\else
  \ifdim\@tempdima>\@tempdimb\relax
    \setlength\textwidth{\@tempdimb}
  \else
    \setlength\textwidth{\@tempdima}
  \fi
\fi
\@settopoint\textwidth

\setlength\@tempdima{\paperheight}
  \addtolength\@tempdima{-3.5in}
  \divide\@tempdima\baselineskip
\@tempcnta=\@tempdima
\setlength\textheight{\@tempcnta\baselineskip}
  \addtolength\textheight{\topskip}

\if@twoside
  \setlength\@tempdima       {\paperwidth}
  \addtolength\@tempdima     {-\textwidth}
  \setlength\oddsidemargin   {.5\@tempdima} % change these to do horizontal jump
  \addtolength\oddsidemargin {-.5in}
  \setlength\marginparwidth  {.5\@tempdima} % change these to do horizontal jump
  \addtolength\marginparwidth{-\marginparsep}
  \addtolength\marginparwidth{-1.2in}
\else
  \setlength\@tempdima       {\paperwidth}
  \addtolength\@tempdima     {-\textwidth}
  \setlength\oddsidemargin   {.5\@tempdima}
  \addtolength\oddsidemargin {-1in}
  \setlength\marginparwidth  {.5\@tempdima}
  \addtolength\marginparwidth{-\marginparsep}
  \addtolength\marginparwidth{-1in} 
\fi
\ifdim\marginparwidth>2in
  \setlength\marginparwidth{2in}
\fi
\@settopoint\oddsidemargin
\@settopoint\marginparwidth

\newcommand*{\@pupznegtest}[1]{%
  \ifdim#1>\z@\else
    \@puperror{\protect#1\space is zero or negative}{\@ehd}%
  \fi}
\newcommand*{\@pupnegtest}[1]{%
  \ifdim#1<\z@
    \@puperror{\protect#1\space is negative}{\@ehd}%
  \fi}

\newcommand{\checkthelayout}{%
  \@pupnegtest{\trimedge}
  \@pupnegtest{\trimtop}
  \@pupznegtest{\stockwidth}
  \@pupznegtest{\paperwidth}
  \@pupznegtest{\textwidth}
  \@pupznegtest{\spinemargin}
  \@pupznegtest{\foremargin}
  \@pupznegtest{\marginparsep}
  \@pupznegtest{\marginparwidth}
  \@pupznegtest{\stockheight}
  \@pupznegtest{\paperheight}
  \@pupznegtest{\textheight}
  \@pupznegtest{\uppermargin}
  \@pupznegtest{\lowermargin}
  \@pupznegtest{\headheight}
  \@pupznegtest{\headsep}
  \@pupznegtest{\footskip}

  \@tempdima = \textheight
    \divide\@tempdima \baselineskip
  \@tempcnta=\@tempdima
  \setlength{\textheight}{\@tempcnta\baselineskip}
    \addtolength{\textheight}{\topskip}
  \setulmargins{\uppermargin}{*}{*}
  \@tempdimb = -1pt
  \@tempdima=\stockwidth
  \advance\@tempdima -\trimedge
  \advance\@tempdima -\paperwidth
  \ifdim\@tempdima<\@tempdimb
    \@tempdima = -\@tempdima
    \@puperror{\protect\paperwidth\space and/or
                        \protect\trimedge\space
                        are too large for \protect\stockwidth\space
                        by \the\@tempdima}%
                       {\@ehd}
  \fi
  \@tempdima = \paperwidth
  \advance\@tempdima -\foremargin
  \advance\@tempdima -\textwidth
  \advance\@tempdima -\spinemargin
  \ifdim\@tempdima<\@tempdimb
    \@tempdima = -\@tempdima
    \@puperror{\protect\spinemargin\space and/or
                        \protect\textwidth\space and/or
                        \protect\foremargin\space
                        are too large for \protect\paperwidth\space
                        by \the\@tempdima}%
                       {\@ehd}
  \fi
  \@tempdima = \stockheight
  \advance\@tempdima -\trimtop
  \advance\@tempdima -\paperheight
  \ifdim\@tempdima<\@tempdimb
    \@tempdima = -\@tempdima
    \@puperror{\protect\paperheight\space and/or
                        \protect\trimtop\space
                        are too large for \protect\stockheight\space
                        by \the\@tempdima}%
                       {\@ehd}
  \fi
  \@tempdima = \paperheight
  \advance\@tempdima -\uppermargin
  \advance\@tempdima -\textheight
  \advance\@tempdima -\lowermargin
  \ifdim\@tempdima<\@tempdimb
    \@tempdima = -\@tempdima
    \@puperror{\protect\uppermargin\space and/or
                        \protect\textheight\space and/or
                        \protect\lowermargin\space
                        are too large for \protect\paperheight\space
                        by \the\@tempdima}%
                       {\@ehd}
  \fi
  \@tempdima = \uppermargin
  \advance\@tempdima -\headheight
  \advance\@tempdima -\headsep
  \ifdim\@tempdima<\@tempdimb
    \@tempdima = -\@tempdima
    \@puperror{\protect\headheight\space and/or
                        \protect\headsep\space
                        are too large for \protect\uppermargin\space
                        by \the\@tempdima}%
                       {\@ehd}
  \fi
  \@tempdima = \lowermargin
  \advance\@tempdima -\footskip
  \ifdim\@tempdima<\z@
    \@tempdima = -\@tempdima
    \@puperror{\protect\footskip
                        is too large for \protect\lowermargin\space
                        by \the\@tempdima}%
                       {\@ehd}
  \fi
}
\newcommand{\fixthelayout}{%
  \topmargin = \trimtop
    \advance\topmargin \uppermargin
    \advance\topmargin -\headsep
    \advance\topmargin -\headheight
    \advance\topmargin -1in\relax
  \oddsidemargin = \stockwidth
    \advance\oddsidemargin -\trimedge
    \advance\oddsidemargin -\paperwidth
    \advance\oddsidemargin \spinemargin
    \advance\oddsidemargin -1in\relax
  \evensidemargin = \trimedge
    \advance\evensidemargin \foremargin
    \advance\evensidemargin -1in\relax
  \@settopoint\textwidth
  \@settopoint\oddsidemargin
  \@settopoint\evensidemargin
}

\newcommand{\typeoutlayout}{%
  \typeout{}
  \typeout{******************************************************}
  \typeout{Stock height and width:
                 \the\stockheight\space by \the\stockwidth}
  \typeout{Top and edge trims:
                 \the\trimtop\space and \the\trimedge}
  \typeout{Page height and width:
                 \the\paperheight\space by \the\paperwidth}
  \typeout{Text height and width:
                 \the\textheight\space by \the\textwidth}
  \typeout{Spine and edge margins:
                 \the\spinemargin\space and \the\foremargin}
  \typeout{Upper and lower margins:
                 \the\uppermargin\space and \the\lowermargin}
  \typeout{Headheight and headsep:
                 \the\headheight\space and \the\headsep}
  \typeout{Footskip:
                 \the\footskip}
  \typeout{Columnsep and columnseprule:
                 \the\columnsep\space and \the\columnseprule}
  \typeout{Marginparsep and marginparwidth:
                 \the\marginparsep\space and \the\marginparwidth}
  \typeout{******************************************************}
  \typeout{}
}

\newcommand{\checkandfixthelayout}{%
  \checkthelayout
  \fixthelayout
  \typeoutlayout}

\newcommand*{\fixpdflayout}{%
  \pdfpageheight=\the\stockheight
  \pdfpagewidth=\the\stockwidth
  \ifdim\pdfvorigin=0pt\pdfvorigin=1in\fi
  \ifdim\pdfhorigin=0pt\pdfhorigin=1in\fi}
\newcommand*{\fixdvipslayout}{%
  \AtBeginDvi{\special{papersize=\the\stockwidth,\the\stockheight}}}

\AtBeginDocument{%
  \ifpdf
    \ifnum\pdfoutput<\@ne
      \fixdvipslayout
    \else
      \fixpdflayout
    \fi
  \else
    \fixdvipslayout
  \fi}

\newcommand{\typeoutstandardlayout}{%
  \typeout{}
  \typeout{******************************************************}
  \typeout{Page height and width:
                \the\paperheight\space by \the\paperwidth}
  \typeout{Text height and width:
               \the\textheight\space by \the\textwidth}
  \typeout{Oddside and evenside margins:
                \the\oddsidemargin\space and \the\evensidemargin}
  \typeout{Topmargin and footskip:
                \the\topmargin\space and \the\footskip}
  \typeout{Headheight and headsep:
                \the\headheight\space and \the\headsep}
  \typeout{Columnsep and columnseprule:
                \the\columnsep\space and \the\columnseprule}
  \typeout{Marginparsep and marginparwidth:
                \the\marginparsep\space and \the\marginparwidth}
  \typeout{******************************************************}
  \typeout{}
}

\setcounter{topnumber}{3}
\renewcommand{\topfraction}{.85}
\setcounter{bottomnumber}{2}
\renewcommand{\bottomfraction}{.5}
\setcounter{totalnumber}{4}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.7}
\setcounter{dbltopnumber}{3}
\renewcommand{\dbltopfraction}{.85}
\renewcommand{\dblfloatpagefraction}{.7}
\newcommand{\makeevenhead}[4]{%
  \@namedef{#1eheadl}{#2}
  \@namedef{#1eheadc}{#3}
  \@namedef{#1eheadr}{#4}
}
\newcommand{\makeoddhead}[4]{%
  \@namedef{#1oheadl}{#2}
  \@namedef{#1oheadc}{#3}
  \@namedef{#1oheadr}{#4}
}
\newcommand{\makeevenfoot}[4]{%
  \@namedef{#1efootl}{#2}
  \@namedef{#1efootc}{#3}
  \@namedef{#1efootr}{#4}
}
\newcommand{\makeoddfoot}[4]{%
  \@namedef{#1ofootl}{#2}
  \@namedef{#1ofootc}{#3}
  \@namedef{#1ofootr}{#4}
}

\newcommand{\makerunningwidth}[2]{%
  \@namedef{#1runwidth}{#2}}
\newlength{\normalrulethickness}
  \setlength{\normalrulethickness}{0.4pt}
\newcommand{\footruleheight}{0pt}
\newcommand{\footruleskip}{0.3\normalbaselineskip}
\newcommand{\makeheadrule}[3]{%
  \@namedef{#1headrule}{%
    \hrule\@width #2\@height #3 \vskip-#3}
}
\newcommand{\makefootrule}[4]{%
  \@namedef{#1footrule}{%
    \vskip-#4\vskip-#3
    \hrule\@width #2\@height #3 \vskip #4}
}

\newcommand{\makeheadposition}[5]{%
  \nametest{flushleft}{#2}
  \ifsamename
    \@namedef{#1evenhpl}{\relax} \@namedef{#1evenhpr}{\hss}
  \else
    \nametest{flushright}{#2}
    \ifsamename
      \@namedef{#1evenhpl}{\hss} \@namedef{#1evenhpr}{\relax}
    \else
      \@namedef{#1evenhpl}{\hss} \@namedef{#1evenhpr}{\hss}
    \fi
  \fi
  \nametest{flushleft}{#3}
  \ifsamename
    \@namedef{#1oddhpl}{\relax} \@namedef{#1oddhpr}{\hss}
  \else
    \nametest{flushright}{#3}
    \ifsamename
      \@namedef{#1oddhpl}{\hss} \@namedef{#1oddhpr}{\relax}
    \else
      \@namedef{#1oddhpl}{\hss} \@namedef{#1oddhpr}{\hss}
    \fi
  \fi
  \nametest{flushleft}{#4}
  \ifsamename
    \@namedef{#1evenfpl}{\relax} \@namedef{#1evenfpr}{\hss}
  \else
    \nametest{flushright}{#4}
    \ifsamename
      \@namedef{#1evenfpl}{\hss} \@namedef{#1evenfpr}{\relax}
    \else
      \@namedef{#1evenfpl}{\hss} \@namedef{#1evenfpr}{\hss}
    \fi
  \fi
  \nametest{flushleft}{#5}
  \ifsamename
    \@namedef{#1oddfpl}{\relax} \@namedef{#1oddfpr}{\hss}
  \else
    \nametest{flushright}{#5}
    \ifsamename
      \@namedef{#1oddfpl}{\hss} \@namedef{#1oddfpr}{\relax}
    \else
      \@namedef{#1oddfpl}{\hss} \@namedef{#1oddfpr}{\hss}
    \fi
  \fi
}

\newcommand{\makepsmarks}[2]{\@namedef{#1pshook}{#2}}

\newcommand*{\p@phe@dreset}{\def\baselinestretch{1}\normalsize}

\newcommand{\makepagestyle}[1]{%
  \@namedef{ps@#1}{%
    \@namedef{#1@evenhead}{%
      \@nameuse{#1evenhpl}\hb@xt@\@nameuse{#1runwidth}{\p@phe@dreset%
        \vbox{\hbox{%
        \rlap{\parbox[b]{\@nameuse{#1runwidth}}{%
          \raggedright\@nameuse{#1eheadl}\strut}}\hfill
              \parbox[b]{\@nameuse{#1runwidth}}{%
          \centering\@nameuse{#1eheadc}\strut}\hfill
        \llap{\parbox[b]{\@nameuse{#1runwidth}}{%
          \raggedleft\@nameuse{#1eheadr}\strut}}}%
        \@nameuse{#1headrule}}}\@nameuse{#1evenhpr}}
    \@namedef{#1@oddhead}{%
      \@nameuse{#1oddhpl}\hb@xt@\@nameuse{#1runwidth}{\p@phe@dreset%
        \vbox{\hbox{%
        \rlap{\parbox[b]{\@nameuse{#1runwidth}}{%
          \raggedright\@nameuse{#1oheadl}\strut}}\hfill
              \parbox[b]{\@nameuse{#1runwidth}}{%
          \centering\@nameuse{#1oheadc}\strut}\hfill
        \llap{\parbox[b]{\@nameuse{#1runwidth}}{%
          \raggedleft\@nameuse{#1oheadr}\strut}}}%
        \@nameuse{#1headrule}}}\@nameuse{#1oddhpr}}
    \@namedef{#1@evenfoot}{%
      \@nameuse{#1evenfpl}\hb@xt@\@nameuse{#1runwidth}{\p@phe@dreset%
        \vbox{\@nameuse{#1footrule}\hbox{%
        \rlap{\parbox[b]{\@nameuse{#1runwidth}}{%
          \raggedright\@nameuse{#1efootl}\strut}}\hfill
              \parbox[b]{\@nameuse{#1runwidth}}{%
          \centering\@nameuse{#1efootc}\strut}\hfill
        \llap{\parbox[b]{\@nameuse{#1runwidth}}{%
          \raggedleft\@nameuse{#1efootr}\strut}}}%
        }}\@nameuse{#1evenfpr}}
    \@namedef{#1@oddfoot}{%
      \@nameuse{#1oddfpl}\hb@xt@\@nameuse{#1runwidth}{\p@phe@dreset%
        \vbox{\@nameuse{#1footrule}\hbox{%
        \rlap{\parbox[b]{\@nameuse{#1runwidth}}{%
          \raggedright\@nameuse{#1ofootl}\strut}}\hfill
              \parbox[b]{\@nameuse{#1runwidth}}{%
          \centering\@nameuse{#1ofootc}\strut}\hfill
        \llap{\parbox[b]{\@nameuse{#1runwidth}}{%
          \raggedleft\@nameuse{#1ofootr}\strut}}}%
        }}\@nameuse{#1oddfpr}}
    \def\@evenhead{\@nameuse{#1@evenhead}}
    \def\@oddhead{\@nameuse{#1@oddhead}}
    \def\@evenfoot{\@nameuse{#1@evenfoot}}
    \def\@oddfoot{\@nameuse{#1@oddfoot}}
    \@nameuse{#1pshook}
  }
  \makeevenhead{#1}{}{}{}
  \makeoddhead{#1}{}{}{}
  \makeevenfoot{#1}{}{}{}
  \makeoddfoot{#1}{}{}{}
  \makerunningwidth{#1}{\textwidth}
  \makeheadposition{#1}{}{}{}{}
  \makeheadrule{#1}{\textwidth}{0pt}
  \makefootrule{#1}{\textwidth}{\footruleheight}{\footruleskip}
  \makepsmarks{#1}{}
}

\newcommand{\aliaspagestyle}[2]{%
  \@namedef{ps@#1}{\@nameuse{ps@#2}}}

\newcommand{\copypagestyle}[2]{%
  \makepagestyle{#1}%
  \makeevenhead{#1}{\@nameuse{#2eheadl}}%
               {\@nameuse{#2eheadc}}{\@nameuse{#2eheadr}}%
  \makeoddhead{#1}{\@nameuse{#2oheadl}}%
               {\@nameuse{#2oheadc}}{\@nameuse{#2oheadr}}%
  \makeevenfoot{#1}{\@nameuse{#2efootl}}%
               {\@nameuse{#2efootc}}{\@nameuse{#2efootr}}%
  \makeoddfoot{#1}{\@nameuse{#2ofootl}}%
              {\@nameuse{#2ofootc}}{\@nameuse{#2ofootr}}%
  \makerunningwidth{#1}{\@nameuse{#2runwidth}}%
  \@namedef{#1evenhpl}{\@nameuse{#2evenhpl}}%
  \@namedef{#1oddhpl}{\@nameuse{#2oddhpl}}%
  \@namedef{#1evenfpl}{\@nameuse{#2evenfpl}}%
  \@namedef{#1oddfpl}{\@nameuse{#2oddfpl}}%
  \@namedef{#1headrule}{\@nameuse{#2headrule}}%
  \@namedef{#1footrule}{\@nameuse{#2footrule}}%
  \makepsmarks{#1}{\@nameuse{#2pshook}}%
}

\newcommand{\ifonlyfloats}[2]{\if@fcolmade #1\else #2\fi}

\newcommand{\mergepagefloatstyle}[3]{%
  \@nameuse{ps@#3} \@nameuse{ps@#2}
  \@namedef{ps@#1}{
  \def\@evenhead{\ifonlyfloats{\@nameuse{#3@evenhead}}%
                {\@nameuse{#2@evenhead}}}
  \def\@oddhead{\ifonlyfloats{\@nameuse{#3@oddhead}}%
               {\@nameuse{#2@oddhead}}}
  \def\@evenfoot{\ifonlyfloats{\@nameuse{#3@evenfoot}}%
                {\@nameuse{#2@evenfoot}}}
  \def\@oddfoot{\ifonlyfloats{\@nameuse{#3@oddfoot}}%
               {\@nameuse{#2@oddfoot}}}
  \@namedef{#1pshook}{\@nameuse{#2pshook}}
}}
\makepagestyle{empty}
    \makeevenhead{empty}{}{\timedate}{}
    \makeoddhead{empty}{}{\timedate}{}

\makepagestyle{plain}
    \makeevenhead{plain}{}{\timedate}{}
    \makeoddhead{plain}{}{\timedate}{}
    \makeevenfoot{plain}{}{\normalfont\fontsize{10}{10pt}\selectfont\sffamily\thepage}{}
    \makeoddfoot{plain}{}{\normalfont\fontsize{10}{10pt}\selectfont\sffamily\thepage}{}

\if@twoside
  \makepagestyle{headings}
    \makepsmarks{headings}{%
      \let\@mkboth\markboth
      \def\chaptermark##1{%
        \markboth{\MakeUppercase{%
          \ifnum \c@secnumdepth >\m@ne
            \if@mainmatter
              \@chapapp\ \thechapter%. \ %
            \fi
          \fi
          }}{\MakeUppercase{##1}}}%
      \def\tocmark{\markboth{\MakeUppercase{\contentsname}}{\MakeUppercase{\contentsname}}}%
      \def\lofmark{\markboth{\MakeUppercase{\listfigurename}}{\MakeUppercase{\listfigurename}}}%
      \def\lotmark{\markboth{\MakeUppercase{\listtablename}}{\MakeUppercase{\listtablename}}}%
      \def\bibmark{\markboth{\MakeUppercase{\bibname}}{\MakeUppercase{\bibname}}}%
      \def\indexmark{\markboth{\MakeUppercase{\indexname}}{\MakeUppercase{\indexname}}}%
    }


   \makeevenhead{headings}{\normalfont\fontsize{10}{10pt}\selectfont\thepage}{\timedate}{\normalfont\fontsize{8}{10pt}\selectfont\sffamily\leftmark}

\makeoddhead{headings}{\normalfont\fontsize{8}{10pt}\selectfont\sffamily\rightmark}{\timedate}{\normalfont\fontsize{10}{10pt}\selectfont\thepage}
\else
  \makepagestyle{headings}
    \makepsmarks{headings}{%
      \let\@mkboth\markboth
      \def\chaptermark##1{%
        \markright{\MakeUppercase{%
          \ifnum \c@secnumdepth >\m@ne
            \if@mainmatter
              \@chapapp\ \thechapter. \ %
            \fi
          \fi
          ##1}}}%
      \def\tocmark{\markright{\MakeUppercase{\contentsname}}}%
      \def\lofmark{\markright{\MakeUppercase{\listfigurename}}}%
      \def\lotmark{\markright{\MakeUppercase{\listtablename}}}%
      \def\bibmark{\markright{\MakeUppercase{\bibname}}}%
      \def\indexmark{\markright{\MakeUppercase{\indexname}}}%
    }
    \makeoddhead{headings}{\slshape\rightmark}{}{\thepage}
\fi

\makepagestyle{myheadings}
  \makepsmarks{myheadings}{%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    \def\tocmark{}%
    \def\lofmark{}%
    \def\lotmark{}%
    \def\bibmark{}%
    \def\indexmark{}%
  }
  \makeevenhead{myheadings}{\thepage}{}{\slshape\leftmark}
  \makeoddhead{myheadings}{\slshape\rightmark}{}{\thepage}

\aliaspagestyle{chapter}{empty}
\aliaspagestyle{part}{empty}
\aliaspagestyle{cleared}{empty}

\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}\thispagestyle{cleared}%
  \newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\makepagestyle{ruled}
\makeevenfoot{ruled}{\thepage}{}{}
\makeoddfoot{ruled}{}{}{\thepage}
\makeheadrule{ruled}{\textwidth}{\normalrulethickness}
\newcommand{\@ruledmarks}{%
  \let\@mkboth\markboth
  \def\chaptermark##1{%
    \markboth{%
      \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
          \thechapter. \ %
        \fi
      \fi
      ##1}{}}
  \def\sectionmark##1{\markright{##1}}
  \def\tocmark{\markboth{\contentsname}{}}
  \def\lofmark{\markboth{\listfigurename}{}}
  \def\lotmark{\markboth{\listtablename}{}}
  \def\bibmark{\markboth{\bibname}{}}
  \def\indexmark{\markboth{\indexname}{}}
}
\makepsmarks{ruled}{\@ruledmarks}
\makeevenhead{ruled}{\scshape\leftmark}{}{}
\makeoddhead{ruled}{}{}{\rightmark}

\makepagestyle{Ruled}
\makerunningwidth{Ruled}{1.1\textwidth}
\makeheadposition{Ruled}{flushright}{flushleft}{flushright}{flushleft}
\makeevenfoot{Ruled}{\thepage}{}{}
\makeoddfoot{Ruled}{}{}{\thepage}
\makeheadrule{Ruled}{1.1\textwidth}{\normalrulethickness}
\makepsmarks{Ruled}{\@ruledmarks}
\makeevenhead{Ruled}{\scshape\leftmark}{}{}
\makeoddhead{Ruled}{}{}{\rightmark}

\newlength{\headwidth}

\makepagestyle{companion}
\setlength{\headwidth}{\textwidth}
  \addtolength{\headwidth}{\marginparsep}
  \addtolength{\headwidth}{\marginparwidth}
\makerunningwidth{companion}{\headwidth}
\makeheadrule{companion}{\headwidth}{\normalrulethickness}
\makeheadposition{companion}{flushright}{flushleft}{}{}
\makepsmarks{companion}{%
  \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{##1}{##1}}    % left mark & right marks
  \def\sectionmark##1{\markright{%
    \ifnum \c@secnumdepth>\z@
      \thesection. \ %
    \fi
    ##1}}
  \def\tocmark{\markboth{\contentsname}{\contentsname}}
  \def\lofmark{\markboth{\listfigurename}{\listfigurename}}
  \def\lotmark{\markboth{\listtablename}{\listtablename}}
  \def\bibmark{\markboth{\bibname}{\bibname}}
  \def\indexmark{\markboth{\indexname}{\indexname}}
}
\makeevenhead{companion}{\normalfont\bfseries\thepage}{}%
                        {\normalfont\bfseries\leftmark}
\makeoddhead{companion}{\normalfont\bfseries\rightmark}{}%
                       {\normalfont\bfseries\thepage}

\renewcommand{\pagenumbering}{%
  \@ifstar{\@spuppnum}{\@puppnum}}
\newcommand{\@spuppnum}[1]{%
  \gdef\thepage{\csname @#1\endcsname \c@page}}
\newcommand{\@puppnum}[1]{%
  \@spuppnum{#1}\global\c@page \@ne}

\newcounter{storedpagenumber}
  \setcounter{storedpagenumber}{1}
\newcommand{\savepagenumber}{\global\c@storedpagenumber \c@page}
\newcommand{\restorepagenumber}{\global\c@page \c@storedpagenumber}

\newcommand{\pretitle}[1]{\def\@bspretitle{#1}}
\newcommand{\posttitle}[1]{\def\@bsposttitle{#1}}
\newcommand{\preauthor}[1]{\def\@bspreauthor{#1}}
\newcommand{\postauthor}[1]{\def\@bspostauthor{#1}}
\newcommand{\predate}[1]{\def\@bspredate{#1}}
\newcommand{\postdate}[1]{\def\@bspostdate{#1}}

  \pretitle{\begin{center}\LARGE}
  \posttitle{\par\end{center}\vskip 0.5em}
  \preauthor{\begin{center}
    \large \lineskip .5em%
    \begin{tabular}[t]{c}}
  \postauthor{\end{tabular}\par\end{center}}
  \predate{\begin{center}\large}
  \postdate{\par\end{center}}

\newcommand{\maketitlehooka}{}
\newcommand{\maketitlehookb}{}
\newcommand{\maketitlehookc}{}
\newcommand{\maketitlehookd}{}

\newcommand{\thanksmarkseries}[1]{%
  \def\@bsmarkseries{\renewcommand{\thefootnote}%
                     {\@nameuse{#1}{footnote}}}}
\newcommand{\symbolthanksmark}{\thanksmarkseries{\fnsymbol}}
\newcommand{\@bscontmark}{\setcounter{footnote}{0}}
\newcommand{\continuousmarks}{\def\@bscontmark{}}
\newcommand{\thanksheadextra}[2]{%
  \def\@bsthanksheadpre{#1}%
  \def\@bsthanksheadpost{#2}}

\DeclareRobustCommand{\thanksmark}[1]{\footnotemark[#1]}
\newcommand{\thanksgap}[1]{\hspace{#1}}
\newcommand{\tamark}{\@thefnmark}

\newlength{\thanksmarkwidth}
\newlength{\thanksmarksep}
\newcommand{\thanksmarkstyle}[1]{\def\thanksscript##1{#1}}
\thanksmarkstyle{\textsuperscript{#1}}
\newcommand{\makethanksmarkhook}{}

\newcommand{\thanksfootmark}{%
  \ifdim\thanksmarkwidth < \z@
    \llap{\hb@xt@ -\thanksmarkwidth{%
          \hss\normalfont\thanksscript{\tamark}}%
          \hspace*{-\thanksmarkwidth}}%
  \else
    \ifdim\thanksmarkwidth = \z@
      {\normalfont\thanksscript{\tamark}}%
    \else
      \hb@xt@\thanksmarkwidth{\hss\normalfont\thanksscript{\tamark}}%
    \fi
  \fi}

\newcommand{\makethanksmark}{%
  \leavevmode%
  \parindent 1em\noindent
  \leftskip\thanksmarksep\relax
  \advance\leftskip\thanksmarkwidth \null\nobreak\hskip-\leftskip\relax
  \makethanksmarkhook\relax
  \thanksfootmark}

\newcommand{\usethanksrule}{\let\footnoterule\thanksrule}
\newcommand{\cancelthanksrule}{\let\footnoterule\@bsfootnoterule}

\thanksmarkseries{fnsymbol}  % symbols
\thanksheadextra{}{}
\setlength{\thanksmarkwidth}{1.8em}
\setlength{\thanksmarksep}{-\thanksmarkwidth}

\AtBeginDocument{%
  \let\thanksrule\footnoterule
  \let\@bsfootnoterule\footnoterule
}

\newlength{\droptitle}
\setlength{\droptitle}{0pt}

\newcommand{\maketitle}{\par
  \begingroup
    \@bsmarkseries
    \def\@makefnmark{\@textsuperscript{%
       \normalfont\@bsthanksheadpre \tamark \@bsthanksheadpost}}%
    \long\def\@makefntext##1{\makethanksmark ##1}
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \ifdim\pagetotal>\z@
        \newpage
      \fi
      \global\@topnum\z@
      \@maketitle
    \fi
    \thispagestyle{title}\@thanks
  \endgroup
  \@bscontmark  %  \setcounter{footnote}{0}%
  }
\aliaspagestyle{title}{plain}

\newcommand*{\@pup@titlefootkill}[1]{%
  \@pupwarn{Do not use \string\footnote\space in
            \string\maketitle.\MessageBreak
            Use \protect\thanks\space instead}}

\newcommand{\@maketitle}{%
  \let\footnote\@pup@titlefootkill
  \ifdim\pagetotal>\z@
    \newpage
  \fi
  \null
  \vskip 2em%
        \vspace*{\droptitle}
  \maketitlehooka
  {\@bspretitle \@title \@bsposttitle}
  \maketitlehookb
  {\@bspreauthor \@author \@bspostauthor}
  \maketitlehookc
  {\@bspredate \@date \@bspostdate}
  \maketitlehookd
  \par
  \vskip 1.5em}

\newenvironment{titlingpage}%
  {\let\footnoterule\relax
   \let\footnotesize\small
   \if@twocolumn
     \@restonecoltrue\onecolumn
   \else
     \@restonecolfalse
   \fi
   \thispagestyle{titlingpage}%
   \setcounter{page}{\@ne}%
  }{%
   \thispagestyle{titlingpage}%
   \if@restonecol \twocolumn \fi
   \if@twoside \cleardoublepage \else \clearpage \fi
   \setcounter{page}{\@ne}}
\aliaspagestyle{titlingpage}{empty}

\newcommand{\emptythanks}{\global\let\@thanks\@empty}

\newcommand*{\andnext}{%
  \end{tabular}\\ \begin{tabular}[t]{c}}

\newcommand{\@bsmtitlempty}{%
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\thanksmarkseries\relax
  \global\let\thanksheadextra\relax
  \global\let\thanksfootextra\relax
  \global\let\thanksmark\relax
  \global\let\thanksgap\relax
}

\newcommand{\keepthetitle}{%
  \@bsmtitlempty
  \global\let\thanks\relax
  \global\let\and\relax
  \global\let\andnext\relax
  \global\let\@thanks\@empty
  \global\let\@title\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
}

\newcommand{\killtitle}{%
  \keepthetitle
  \global\let\thetitle\relax
  \global\let\theauthor\relax
  \global\let\thedate\relax
}

\addtoiargdef{\title}{%
  \begingroup\let\footnote\@gobble}{%
  \begingroup
    \renewcommand{\thanks}[1]{}
    \renewcommand{\thanksmark}[1]{}
    \renewcommand{\thanksgap}[1]{}
    \protected@xdef\thetitle{#1}
  \endgroup\endgroup}
\addtoiargdef{\author}{%
  \begingroup\let\footnote\@gobble}{%
  \begingroup
    \renewcommand{\thanks}[1]{}
    \renewcommand{\and}{\unskip, }
    \renewcommand{\andnext}{\unskip, }
    \renewcommand{\thanksmark}[1]{}
    \renewcommand{\thanksgap}[1]{}
    \protected@xdef\theauthor{#1}
  \endgroup\endgroup}
\addtoiargdef{\date}{%
  \begingroup\let\footnote\@gobble}{%
  \begingroup
    \renewcommand{\thanks}[1]{}
    \renewcommand{\thanksmark}[1]{}
    \renewcommand{\thanksgap}[1]{}
    \protected@xdef\thedate{#1}
  \endgroup\endgroup}

\newif\if@bsonecol
  \@bsonecoltrue
\newif\ifadd@bstotoc
  \add@bstotocfalse
\newif\ifnumber@bs
  \number@bsfalse
\newif\if@bsrunin
  \@bsruninfalse
\newif\if@titlepage
  \@titlepagetrue

  \if@compatibility
  \newenvironment{titlepage}
      {%
        \if@twocolumn
          \@restonecoltrue\onecolumn
        \else
          \@restonecolfalse\newpage
        \fi
        \thispagestyle{empty}%
        \setcounter{page}\z@
      }%
      {\if@restonecol\twocolumn \else \newpage \fi
      }
  \else
  \newenvironment{titlepage}%
      {%
        \if@twocolumn
          \@restonecoltrue\onecolumn
        \else
          \@restonecolfalse
        \fi
        \thispagestyle{empty}%
        %%%%%%%%%removed for correct FM pagination \setcounter{page}\@ne
      }%
      {\if@restonecol\twocolumn \else \newpage \fi
       \if@twoside\else
          \setcounter{page}\@ne
       \fi
      }
  \fi

\newcommand\makehalftitle{\begin{titlepage}%
 \fontsize{10}{12pt}\selectfont%
   \let\footnotesize\small
   \let\footnoterule\relax
   \let \footnote \thanks
   \null\mbox{}\\
 \vskip7.25pc
   \begin{flushleft}\advance\leftskip36pt%
     {\fontsize{18}{24pt}\selectfont\sffamily\@title \par}%
     {\large
      \lineskip .75em%
       \par}%
       \vskip 1.5em%
     {\par}%       % Set date in \large size.
   \end{flushleft}\par
   \@thanks
   \vfil\null
   \end{titlepage}
}
 
\newcommand\makepuptitle{\begin{titlepage}%
    \cleartooddpage\null\thispagestyle{empty}
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \null\vfil\fontsize{10}{12pt}\selectfont
    \vspace*{-29pt}
    \begin{center}%
      {\sffamily\fontsize{20}{24pt}\selectfont \par
  \rule{\textwidth}{2pt}\vspace*{-17.53pt}\par
  \rule{\textwidth}{.5pt}\vspace{18pt}\par
  \bgroup\raggedright\advance\leftskip30pt\advance\rightskip18pt
  \@title\vspace{6pt}\par
  \egroup
  \rule{\textwidth}{.5pt} \par}%
     \end{center}   
  \vskip22pt

  \bgroup
  \let \\\@centercr \@rightskip 18.0pt plus 1.0fil \rightskip \@rightskip \leftskip 
  18pt \parindent \z@
  \parindent0pt
  {\fontsize{14}{16pt}\selectfont\sffamily\itshape\@subtitle\par}
  \vskip12pt
      {\fontsize{20}{24pt}\selectfont

          \sffamily\@author
       \par}%
  \vfill

  %\includegraphics[width=1in]{logo.eps}
  %\vspace{16.4pc}
  \vskip1pc


  \fontsize{8}{16pt}\selectfont\sffamily
  \noindent\hbox to 146pt{P\hss R\hss I\hss N\hss C\hss E\hss T\hss O\hss N\hspace*{7pt}U\hss N\hss I\hss V\hss E\hss R\hss S\hss I\hss T\hss Y\hspace{7pt}P\hss R\hss E\hss S\hss S}\\
  \noindent\hbox to 120pt{P\hss R\hss I\hss N\hss C\hss E\hss T\hss O\hss N\hspace{7pt}A\hss N\hss D\hspace{7pt}O\hss X\hss F\hss O\hss R\hss D}

      {\par}%       % Set date in \large size.
  \par
  \egroup
    \@thanks
    \vfil\null
\end{titlepage}
}


\newcommand{\abstractcol}{\@bsonecolfalse}
\newcommand{\abstractintoc}{\add@bstotoctrue}
\newcommand{\abstractnum}{\number@bstrue\@bsruninfalse}
\newcommand{\abstractrunin}{\@bsrunintrue\number@bsfalse}

\newcommand{\abstractnamefont}{\normalfont\small\bfseries}
\newcommand{\abstracttextfont}{\normalfont\small}

\newcommand{\absnamepos}{center}
\newlength{\abstitleskip} \setlength{\abstitleskip}{-0.5em}
\newlength{\absleftindent}
\newdimen\abs@leftindent
  \abs@leftindent=\leftmargin
\newlength{\absrightindent}
\newlength{\absparindent}
\newlength{\absparsep}

\newcommand{\abslabeldelim}[1]{\def\@bslabeldelim{#1}}
\abslabeldelim{}
\newcommand{\@bsrunintitle}{%
  \hspace*{\abstitleskip}{\abstractnamefont\abstractname\@bslabeldelim}}

\newcommand{\setup@bstract}{%
  \if@twocolumn
    \if@bsonecol
      \abs@leftindent=\absleftindent
    \else
      \abs@leftindent=\z@
      \renewcommand{\abstractnamefont}{\normalfont\Large\bfseries}
      \renewcommand{\abstracttextfont}{\normalfont}
      \renewcommand{\absnamepos}{flushleft}
      \setlength{\abstitleskip}{-2ex}
    \fi
  \else
    \abs@leftindent=\absleftindent
  \fi
  \setlength{\absrightindent}{\absleftindent}
}

\AtBeginDocument{\setlength{\absparindent}{\parindent}
                 \setlength{\absparsep}{\parskip}}

\newenvironment{@bstr@ctlist}{%
  \list{}{%
          %%\topsep        \z@
          \partopsep     \z@
          \listparindent \absparindent
          \itemindent    \listparindent
          \leftmargin    \abs@leftindent
          \rightmargin   \absrightindent
          \parsep        \absparsep}%
  \item\relax}
  {\endlist}

\newcommand{\put@bsintoc}{%
  \ifadd@bstotoc
    \ifnumber@bs\else
      \phantomsection
      \addcontentsline{toc}{chapter}{\abstractname}
    \fi
  \fi}

\newcommand{\num@bs}{\chapter{\abstractname}}

\newenvironment{abstract}{%
  \setup@bstract
  \if@bsrunin\else
    \ifnumber@bs \num@bs \else
      \begin{\absnamepos}\abstractnamefont\abstractname\end\absnamepos%
      \vspace{\abstitleskip}%
    \fi
  \fi
  \put@bsintoc%
  \begin{@bstr@ctlist}\if@bsrunin\@bsrunintitle\fi\abstracttextfont}%
  {\par\end{@bstr@ctlist}}

\newenvironment{onecolabstract}{%
  \begin{@twocolumnfalse}\begin{abstract}}{%
  \end{abstract}\end{@twocolumnfalse}}

\addtoiargdef{\thanks}{}{%
  \protected@xdef\@bs@thanks{\@bs@thanks
    \protect\footnotetext[\the\c@footnote]{#1}}%
}
\let\@bs@thanks\@empty

\newcommand{\saythanks}{\begingroup
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}\@bs@thanks
  \endgroup\global\let\@bs@thanks\@empty}

\newcommand*{\partmark}[1]{}
\newcommand*{\chaptermark}[1]{}

\newcommand*{\bibmark}{}
\newcommand*{\indexmark}{}
\newcommand*{\glossarymark}{}

\setcounter{secnumdepth}{2}
\newcounter{part}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\renewcommand{\thepart}{\@Roman\c@part}
\renewcommand{\thechapter}{{\@arabic\c@chapter}}
\renewcommand{\thesection}{{{\thechapter.\@arabic\c@section}}}
\renewcommand{\thesubsection}{{{\thesection.\@arabic\c@subsection}}}
\renewcommand{\thesubsubsection}{{{\thesubsection.\@arabic\c@subsubsection}}}
\renewcommand{\theparagraph}{{{\thesubsubsection.\@arabic\c@paragraph}}}
\renewcommand{\thesubparagraph}{{{\theparagraph.\@arabic\c@subparagraph}}}
\newcommand{\@chapapp}{\chaptername}

\newcommand{\frontmatter}{%
  \@ifstar{\@spupfront}{\@pupfront}}
\newcommand{\@spupfront}{%
  \@mainmatterfalse
  \setcounter{secnumdepth}{-10}
  \counterwithout{figure}{chapter}
  \counterwithout{table}{chapter}
}
\newcommand{\@pupfront}{%
  \@spupfront\pagenumbering{roman}}

\newenvironment{dedication}{\clearpage\fontsize{12}{14pt}\selectfont\parindent0pt\sffamily\thispagestyle{empty}\vspace*{5.75pc}\begin{center}\itshape}{\normalfont\end{center}\par}

\newcommand{\mainmatter}{%
  \@ifstar{\@spupmain}{\@pupmain}}
\newcommand{\@spupmain}{
  \@mainmattertrue
  \setcounter{secnumdepth}{\value{maxsecnumdepth}}
  \ifartopt
    \clearpage
  \else
    \cleardoublepage
    \counterwithin{figure}{chapter}
    \counterwithin{table}{chapter}
  \fi}
\newcommand{\@pupmain}{%
  \@spupmain\pagenumbering{arabic}}

\newcommand{\backmatter}{%
  \ifartopt
    \clearpage
  \else
    \if@openright
      \cleardoublepage
    \else
      \clearpage
    \fi
  \fi
  \@mainmatterfalse
  \setcounter{secnumdepth}{-10}
  \ifartopt\else
    \counterwithout{figure}{chapter}
    \counterwithout{table}{chapter}
    \setcounter{figure}{0}
    \setcounter{table}{0}
  \fi}

\newcommand{\part}{%
  \@setuppart
  \secdef\@part\@spart}
\newcommand{\beforepartskip}{\null\vfil}
\newcommand{\midpartskip}{\par\vskip 20pt}
\newcommand{\afterpartskip}{\vfil\newpage}

\newcommand{\@setuppart}{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{part}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \beforepartskip}

\newcommand{\partnamefont}{\normalfont\huge\bfseries}
\newcommand{\partnumfont}{\normalfont\huge\bfseries}
\newcommand{\parttitlefont}{\normalfont\Huge\bfseries}

\newcommand{\printpartname}{\partnamefont \partname}
\newcommand{\partnamenum}{\space}
\newcommand{\printpartnum}{\partnumfont \thepart}
\newcommand{\printparttitle}[1]{\parttitlefont #1}

\newcommand*{\puppartinfo}[3]{}
\newcommand*{\puppartstarinfo}[1]{}

\long\def\@part[#1]#2{%
  \M@gettitle{#1}%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}%
      {\protect\partnumberline{\thepart}#1}%
    \puppartinfo{\thepart}{#1}{#2}%
  \else
    \addcontentsline{toc}{part}{#1}%
    \puppartinfo{}{#1}{#2}%
  \fi
  \partmark{#1}%
  {\centering
   \interlinepenalty \@M
   \normalfont
   \ifnum \c@secnumdepth >-2\relax
     \printpartname \partnamenum \printpartnum
     \midpartskip
   \fi
   \printparttitle{#2}\par}%
  \@endpart}

\def\@spart#1{%
  \M@gettitle{#1}%
  \puppartstarinfo{#1}%
  {\centering
   \interlinepenalty \@M
   \normalfont
   \printparttitle{#1}\par}%
  \@endpart}

\def\@endpart{\afterpartskip
  \if@twoside
    \if@openright
      \null
      \thispagestyle{empty}%
      \newpage
    \fi
  \fi
  \if@tempswa
    \twocolumn
  \fi}

\newcommand\chapter{%
  \ifartopt\par\else
    \clearforchapter
    \thispagestyle{chapter}
    \global\@topnum\z@
  \fi
  \@afterindentfalse
  \@ifstar{\@p@pschapter}{\@p@pchapter}}

\newcommand{\@p@pchapter}[1][]{%
  \def\ch@pt@c{#1}% capture first optional arg
  \@ifnextchar[{\@chapter}{\@chapter[]}%
}
\def\p@p@empty{\@empty}

\newcommand*{\pupchapinfo}[4]{}
\newcommand*{\pupchapstarinfo}[2]{}
\newcommand*{\pupappchapinfo}[4]{}
\newcommand*{\pupappchapstarinfo}[2]{}

\def\@chapter[#1]#2{%
  \ifx\ch@pt@c\@empty % no optional args
    \def\f@rtoc{#2}%
    \def\f@rhdr{#2}%
  \else                  % at least one opt arg
    \let\f@rtoc\ch@pt@c
    \ifx\@empty#1\@empty
      \let\f@rhdr\ch@pt@c
    \else
      \def\f@rhdr{#1}%
    \fi
  \fi
  \p@p@Andfalse
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \p@p@Andtrue
    \fi
  \fi
  \ifp@p@And
    \refstepcounter{chapter}%
  \fi
  \chaptermark{\f@rhdr}
  \ifartopt
    \@makeschapterhead{#2}%
    \@afterheading
  \else
    \insertchapterspace
    \if@twocolumn
      \@topnewpage[\@makechapterhead{#2}{#1}]%
    \else
      \@makechapterhead{#2}{#1}%
    \fi
    \@afterheading
  \fi
  \ifp@p@And
    \ifanappendix
      \addcontentsline{toc}{appendix}{%
        \protect\chapternumberline{\thechapter}\f@rtoc}%
      \pupappchapinfo{\thechapter}{\f@rtoc}{\f@rhdr}{#2}%
    \else
      \addcontentsline{toc}{chapter}{%
        \protect\chapternumberline{\thechapter}\f@rtoc}%
      \pupchapinfo{\thechapter}{\f@rtoc}{\f@rhdr}{#2}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{\f@rtoc}%
    \ifanappendix
      \pupappchapinfo{}{\f@rtoc}{\f@rhdr}{#2}%
    \else
      \pupchapinfo{}{\f@rtoc}{\f@rhdr}{#2}%
    \fi
  \fi
  \ifheadnameref\M@gettitle{\f@rhdr}\else\M@gettitle{\f@rtoc}\fi
}

\def\@makeschapterhead#1{%
{\fontsize{10}{12pt}\selectfont  
\vspace*{-\schapterdrop}%
  {\parindent \z@ \raggedright\advance\leftskip18pt
    \interlinepenalty\@M
    \fontsize{16}{18pt}\selectfont
\noindent\hspace*{-18pt}\rule{\textwidth}{2pt}\\[-11.58pt]%\vspace{-11.58pt}\par%%%2pt rule
\noindent\hspace*{-18pt}\rule{\textwidth}{.5pt}\vspace{18pt}\par\sffamily\itshape  #1\par\nobreak
    \vskip 40\p@
 }}
\normalfont}

\def\@makechapterhead#1#2{
  \vspace*{-\chapterdrop}%
  {\parindent 18pt \raggedright \parindent0pt\normalfont\fontsize{10}{12pt}\selectfont\advance\leftskip18pt
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
      \fontsize{18}{18pt}\selectfont\sffamily{\itshape\@chapapp\space 
\ifanappendix
\thechapter
\else
\ifcase\the\c@chapter
\or%
One\or Two\or Three\or Four\or Five\or%
Six\or Seven\or Eight\or Nine\or Ten\or%
Eleven\or Twelve\or Thirteen\or Fourteen\or Fifteen\or%
Sixteen\or Seventeen\or Eighteen\or Nineteen\or Twenty\or%
Twenty One\or Twenty Two\or Twenty Three\or Twenty Four\or Twenty Five\or%
Twenty Six\or Twenty Seven\or Twenty Eight\or Twenty Nine\or Thirty\or%
Thirty One\or Thirty Two\or Thirty Three\or Thirty Four\or Thirty Five\or%
Thirty Six\or Thirty Seven\or Thirty Eight\or Thirty Nine\or Forty\or%
Forty One\or Forty Two\or Forty Three\or Forty Four\or Forty Five\or%
Forty Six\or Forty Seven\or Forty Eight\or Forty Nine\or Fifty\or%
\else
Your book's too long!
\fi%ifcase
\fi}        \par\nobreak
        \vskip -4\p@
\noindent\hspace{-18pt}\rule{\textwidth}{2pt}\\[-18.55pt]
\noindent\hspace{-18pt}\rule{\textwidth}{0.5pt}\Huge
\vskip6pt
     \fi
   \fi
   \interlinepenalty\@M
   {\fontsize{14}{24pt}\sffamily #1\par}\nobreak
   \vskip 32\p@
}}


\newcommand{\insertchapterspace}{%
  \addtocontents{lof}{\protect\addvspace{10pt}}%
  \addtocontents{lot}{\protect\addvspace{10pt}}%
}

\newcommand{\@chs@def@ult}{%
  \def\chapterheadstart{\vspace*{\beforechapskip}}
  \def\printchaptername{\chapnamefont \@chapapp}
  \def\chapternamenum{\space}
  \def\printchapternum{\chapnumfont \thechapter}
  \def\afterchapternum{\par\nobreak\vskip \midchapskip}
  \def\printchapternonum{}
  \def\printchaptertitle##1{\chaptitlefont ##1}
  \def\afterchaptertitle{\par\nobreak\vskip \afterchapskip}
}

\newcommand{\chapnamefont}{\normalfont\huge\bfseries}
\newcommand{\chapnumfont}{\normalfont\huge\bfseries}
\newcommand{\chaptitlefont}{\normalfont\Huge\bfseries}
\newlength{\beforechapskip}\setlength{\beforechapskip}{50pt}
\newlength{\midchapskip}\setlength{\midchapskip}{20pt}
\newlength{\afterchapskip}\setlength{\afterchapskip}{40pt}
\newlength{\chapterdrop}
\setlength{\chapterdrop}{8.5pt}

\newlength{\schapterdrop}
\setlength{\schapterdrop}{6.34pt}

\newlength{\partdrop}
\setlength{\partdrop}{0pt}

\newcommand{\@p@pschapter}[2][\@empty]{%
  \@schapter{#2}%
  \ifx \@empty#1
    \def\f@rhdr{#2}%
  \else   % opt arg
    \def\f@rhdr{#1}%
    \setcounter{secnumdepth}{-10}%
    \chaptermark{#1}%
    \setcounter{secnumdepth}{\value{maxsecnumdepth}}%
  \fi
  \ifanappendix
    \pupappchapstarinfo{\f@rhdr}{#2}%
  \else
    \pupchapstarinfo{\f@rhdr}{#2}%
  \fi}

\newcommand{\@schapter}[1]{%
  \ifartopt
    \@makeschapterhead{#1}%
    \@afterheading
  \else
    \if@twocolumn
      \@topnewpage[\@makeschapterhead{#1}]%
    \else
      \@makeschapterhead{#1}%
    \fi
    \@afterheading
  \fi
  \M@gettitle{#1}}

\newcommand{\makechapterstyle}[2]{\@namedef{chs@#1}{\@chs@def@ult #2}}
\newcommand{\chapterstyle}[1]{\@nameuse{chs@#1}}

\makechapterstyle{default}{%
  \renewcommand{\chapnamefont}{\normalfont\huge\bfseries}
  \renewcommand{\chapnumfont}{\normalfont\huge\bfseries}
  \renewcommand{\chaptitlefont}{\normalfont\Huge\bfseries}
  \setlength{\beforechapskip}{50pt}
  \setlength{\midchapskip}{20pt}
  \setlength{\afterchapskip}{40pt}
}
\chapterstyle{default}

\makechapterstyle{section}{%
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\chapnumfont}{\normalfont\Huge\bfseries}
  \renewcommand{\printchapternum}{\chapnumfont \thechapter\space}
  \renewcommand{\afterchapternum}{}
}

\makechapterstyle{article}{%
  \renewcommand{\chapterheadstart}{\vspace{\beforechapskip}}
  \setlength{\beforechapskip}{3.5ex \@plus 1ex \@minus .2ex}
  \setlength{\afterchapskip}{2.3ex \@plus .2ex}
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\chaptitlefont}{\normalfont\Large\bfseries}
  \renewcommand{\chapnumfont}{\normalfont\Large\bfseries}
  \renewcommand{\printchapternum}{\chapnumfont \thechapter\quad}
  \renewcommand{\afterchapternum}{}
}

\makechapterstyle{hangnum}{%
  \renewcommand{\chapnumfont}{\chaptitlefont}
  \settowidth{\chapindent}{\chapnumfont 999}
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\printchapternum}{%
    \noindent\llap{\makebox[\chapindent][l]{\chapnumfont \thechapter}}}
  \renewcommand{\afterchapternum}{}
}

\newlength{\chapindent}

\makechapterstyle{companion}{%
  \renewcommand{\chapnamefont}{\normalfont\LARGE\scshape}
  \renewcommand{\printchaptername}{\raggedleft\chapnamefont \@chapapp}
  \renewcommand{\chapnumfont}{\normalfont\Huge}
  \setlength{\chapindent}{\marginparsep}
  \addtolength{\chapindent}{\marginparwidth}
  \renewcommand{\printchaptertitle}[1]{%
    \begin{adjustwidth}{}{-\chapindent}
      \raggedleft \chaptitlefont ##1\par\nobreak
    \end{adjustwidth}}
}

\makechapterstyle{demo}{
  \renewcommand{\printchaptername}{\centering}
  \renewcommand{\printchapternum}{\chapnumfont \numtoName{\c@chapter}}
  \renewcommand{\chaptitlefont}{\normalfont\Huge\sffamily}
  \renewcommand{\printchaptertitle}[1]{%
    \hrule\vskip\onelineskip \raggedleft \chaptitlefont ##1}
  \renewcommand{\afterchaptertitle}%
               {\vskip\onelineskip \hrule\vskip \afterchapskip}
}

\newenvironment{chapterintro}{\vskip4pt\par\noindent\ignorespaces}{}

\newcommand{\prefacename}{Preface}
\newenvironment{thepreface}
               {%
               \chapter*{Preface}
               \@mkboth{\MakeUppercase\prefacename}{\MakeUppercase\prefacename}%
\addcontentsline{toc}{chapter}{Preface}
}

\def\shorttitle#1{\gdef\@shorttitle{#1}}
\def\@shorttitle{}
\def\subtitle#1{\gdef\@subtitle{#1\vskip60pt}}
\def\@subtitle{}

\newif\ifraggedbottomsection
  \raggedbottomsectionfalse
\newlength{\bottomsectionskip}
  \setlength{\bottomsectionskip}{10mm}

\newcommand{\@trplargomm}[1]{%
  \@ifnextchar[{\@xtrplargomm{#1}}%
               {\@xxtrplarg{#1}}}
\long\def\@xtrplargomm#1[#2]{\@dblarg{#1[#2]}}
\newcommand{\@xxtrplarg}[2]{#1[{#2}][{#2}]{#2}}
\newcommand{\@trplargoom}[1]{%
  \@ifnextchar[{\@xtrplargoom{#1}}%
               {\@xxtrplarg{#1}}}
\long\def\@xtrplargoom#1[#2]{%
  \@ifnextchar[{#1[{#2}]}%
               {#1[{#2}][{#2}]}}

\newcommand*{\pupsecinfo}[5]{}

\renewcommand{\@startsection}[6]{%
  \ifraggedbottomsection\if@nobreak\else
    \vskip\z@\@plus\bottomsectionskip
    \penalty\z@
    \vskip\z@\@plus -\bottomsectionskip
  \fi\fi
  \def\p@psecn@me{#1}%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
    {\@trplargoom{\M@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

\def\M@sect#1#2#3#4#5#6[#7][#8]#9{%
  \ifheadnameref\M@gettitle{#8}\else\M@gettitle{#7}\fi
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
    \pupsecinfo{#1}{}{#7}{#8}{#9}%
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
    \pupsecinfo{#1}{\@nameuse{the#1}}{#7}{#8}{#9}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
      \@hangfrom{\hskip #3\relax\@svsec}%
        \interlinepenalty \@M #9\@@par}%
    \endgroup
    \csname #1mark\endcsname{#8}%
    \addcontentsline{toc}{#1}{%      
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
     \@svsec #9}%
     \csname #1mark\endcsname{#8}%
     \addcontentsline{toc}{#1}{%
       \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
       \fi
       #7}}%
  \fi
  \@xsect{#5}}

\newcommand{\section}{%
  \sechook%
  \@startsection{section}{1}%  level 1
      {\secindent}%            heading indent
      {\beforesecskip}%        skip before the heading
      {\aftersecskip}%         skip after the heading
      {\normalfont\secheadstyle}} % font
\newcommand{\sechook}{}
\newcommand{\setsechook}[1]{\renewcommand{\sechook}{#1}}
\newlength{\secindent}
\newcommand{\setsecindent}[1]{\setlength{\secindent}{#1}}
  \setsecindent{\z@}
\newskip\beforesecskip
\newcommand{\setbeforesecskip}[1]{\setlength{\beforesecskip}{#1}}
  \setbeforesecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\newskip\aftersecskip
\newcommand{\setaftersecskip}[1]{\setlength{\aftersecskip}{#1}}
  \setaftersecskip{2.3ex \@plus .2ex}
\newcommand{\secheadstyle}{}
\newcommand{\setsecheadstyle}[1]{\renewcommand{\secheadstyle}{#1}}
  \setsecheadstyle{\fontsize{10}{14}\selectfont\bfseries\raggedright\uppercase}    % CLEANUP make a normal parameter

\newcommand{\subsection}{%
  \subsechook%
  \@startsection{subsection}{2}%  level 2
      {\subsecindent}%            heading indent
      {\beforesubsecskip}%        skip before the heading
      {\aftersubsecskip}%         skip after the heading
      {\normalfont\subsecheadstyle}} % font
\newcommand{\subsechook}{}
\newcommand{\setsubsechook}[1]{\renewcommand{\subsechook}{#1}}
\newlength{\subsecindent}
\newcommand{\setsubsecindent}[1]{\setlength{\subsecindent}{#1}}
  \setsubsecindent{\z@}
\newskip\beforesubsecskip
\newcommand{\setbeforesubsecskip}[1]{\setlength{\beforesubsecskip}{#1}}
  \setbeforesubsecskip{-3.25ex \@plus -1ex \@minus -.2ex}
\newskip\aftersubsecskip
\newcommand{\setaftersubsecskip}[1]{\setlength{\aftersubsecskip}{#1}}
  \setaftersubsecskip{1.5ex \@plus .2ex}
\newcommand{\subsecheadstyle}{}
\newcommand{\setsubsecheadstyle}[1]{\renewcommand{\subsecheadstyle}{#1}}
  \setsubsecheadstyle{\normalsize\bfseries\raggedright}

\newcommand{\subsubsection}{%
  \subsubsechook%
  \@startsection{subsubsection}{3}%  level 3
      {\subsubsecindent}%            heading indent
      {\beforesubsubsecskip}%        skip before the heading
      {\aftersubsubsecskip}%         skip after the heading
      {\normalfont\subsubsecheadstyle}} % font
\newcommand{\subsubsechook}{}
\newcommand{\setsubsubsechook}[1]{\renewcommand{\subsubsechook}{#1}}
\newlength{\subsubsecindent}
\newcommand{\setsubsubsecindent}[1]{%
            \setlength{\subsubsecindent}{#1}}
  \setsubsubsecindent{\z@}
\newskip\beforesubsubsecskip
\newcommand{\setbeforesubsubsecskip}[1]{%
            \setlength{\beforesubsubsecskip}{#1}}
  \setbeforesubsubsecskip{-3.25ex \@plus -1ex \@minus -.2ex}
\newskip\aftersubsubsecskip
\newcommand{\setaftersubsubsecskip}[1]{%
            \setlength{\aftersubsubsecskip}{#1}}
  \setaftersubsubsecskip{1.5ex \@plus .2ex}
\newcommand{\subsubsecheadstyle}{}
\newcommand{\setsubsubsecheadstyle}[1]{%
            \renewcommand{\subsubsecheadstyle}{#1}}
  \setsubsubsecheadstyle{\normalsize\itshape\raggedright}

\newcommand{\paragraph}{%
  \parahook%
  \@startsection{paragraph}{4}%  level 4
      {\paraindent}%            heading indent
      {\beforeparaskip}%        skip before the heading
      {\afterparaskip}%         skip after the heading
      {\normalfont\paraheadstyle}} % font
\newcommand{\parahook}{}
\newcommand{\setparahook}[1]{\renewcommand{\parahook}{#1}}
\newlength{\paraindent}
\newcommand{\setparaindent}[1]{\setlength{\paraindent}{#1}}
  \setparaindent{\z@}
\newskip\beforeparaskip
\newcommand{\setbeforeparaskip}[1]{\setlength{\beforeparaskip}{#1}}
  \setbeforeparaskip{-12pt \@plus-1ex \@minus-.2ex}
\newskip\afterparaskip
\newcommand{\setafterparaskip}[1]{\setlength{\afterparaskip}{#1}}
  \setafterparaskip{6pt}
\newcommand{\paraheadstyle}{}
\newcommand{\setparaheadstyle}[1]{\renewcommand{\paraheadstyle}{#1}}
  \setparaheadstyle{\normalsize\scshape}

\newcommand{\subparagraph}{%
  \subparahook%
  \@startsection{subparagraph}{5}%  level 5
      {\subparaindent}%            heading indent
      {\beforesubparaskip}%        skip before the heading
      {\aftersubparaskip}%         skip after the heading
      {\normalfont\subparaheadstyle}} % font
\newcommand{\subparahook}{}
\newcommand{\setsubparahook}[1]{\renewcommand{\subparahook}{#1}}
\newlength{\subparaindent}
\newcommand{\setsubparaindent}[1]{%
            \setlength{\subparaindent}{#1}}
  \setsubparaindent{\parindent}
\newskip\beforesubparaskip
\newcommand{\setbeforesubparaskip}[1]{%
            \setlength{\beforesubparaskip}{#1}}
  \setbeforesubparaskip{3.25ex \@plus 1ex \@minus .2ex}
\newskip\aftersubparaskip
\newcommand{\setaftersubparaskip}[1]{%
            \setlength{\aftersubparaskip}{#1}}
  \setaftersubparaskip{-1em}
\newcommand{\subparaheadstyle}{}
\newcommand{\setsubparaheadstyle}[1]{%
            \renewcommand{\subparaheadstyle}{#1}}
  \setsubparaheadstyle{\normalsize\bfseries}

\newcommand{\sethangfrom}[1]{\renewcommand{\@hangfrom}[1]{#1}}
\newcommand{\setsecnumformat}[1]{\renewcommand{\@seccntformat}[1]{#1}}
\newcommand{\hangsecnum}{%
  \def\@seccntformat##1{\llap{\csname the##1\endcsname\quad}}}
\newcommand{\defaultsecnum}{%
  \def\@seccntformat##1{\csname the##1\endcsname\quad}}

\newcommand{\plainbreak}{\@ifstar{\@spbreak}{\@pbreak}}
\newcommand*{\@pbreak}[1]{\par
  \penalty -100
  \vskip #1\onelineskip \@plus 2\onelineskip
  \penalty -20
  \vskip \z@ \@plus -2\onelineskip
  \@afterindentfalse
  \@afterheading}
\newcommand*{\@spbreak}[1]{\par
  \penalty -100
  \vskip #1\onelineskip \@plus 2\onelineskip
  \penalty -20
  \vskip \z@ \@plus -2\onelineskip
  \@afterindenttrue
  \@afterheading}

\newcommand{\fancybreak}{\@ifstar{\@sfbreak}{\@fbreak}}
\newcommand{\@fbreak}[1]{\par
  \penalty -100
  \noindent\parbox{\linewidth}{\centering #1}\null
  \penalty -20
%%  \vskip -\onelineskip
  \@afterindentfalse
  \@afterheading}
\newcommand{\@sfbreak}[1]{\par
  \penalty -100
  \noindent\parbox{\linewidth}{\centering #1}\null
  \penalty -20
%%  \vskip -\onelineskip
  \@afterindenttrue
  \@afterheading}

\newcommand{\plainfancybreak}{\@ifstar{\@spfbreak}{\@pfbreak}}
\newcommand{\@pfbreak}[3]{\par
  \@tempdimc\pagegoal \advance\@tempdimc-\pagetotal
  \ifdim #1>\@tempdimc \@fbreak{#3}\else \@pbreak{#2}\fi}
\newcommand{\@spfbreak}[3]{\par
  \@tempdimc\pagegoal \advance\@tempdimc-\pagetotal
  \ifdim #1>\@tempdimc \@sfbreak{#3}\else \@spbreak{#2}\fi}

\newcommand*{\pen@ltyabovepfbreak}{2}
\newcommand*{\pen@ltybelowpfbreak}{-4}

\newlength{\pfbreakskip}
  \setlength{\pfbreakskip}{2\baselineskip}
\newcommand{\pfbreakdisplay}{*\quad*\quad*}

\def\pfbre@kdispl@y{\vbox to 1\pfbreakskip{\vss
  \hb@xt@ \columnwidth{\hss \pfbreakdisplay \hss}%
  \vss}}

\edef\nopfbreakOutput{\the\output}
\def\pfbreakOutput{%
  \ifnum\outputpenalty=\pen@ltyabovepfbreak
    \nopfbreakOutput
    \pfbre@kdispl@y
    \nobreak
    \vskip-\pfbreakskip
  \else\ifnum\outputpenalty=\pen@ltybelowpfbreak
    \unvbox 255\relax
    \nobreak
    \vskip-\pfbreakskip
    \pfbre@kdispl@y
    \break
  \else
    \nopfbreakOutput
  \fi
  \fi}
\output={\pfbreakOutput}

\newcommand{\pfbreak}{\@ifstar{\@spfbreakgap}{\@pfbreakgap}}
\newcommand{\@pfbreakgap}{%
  \par {%
  \skip@\lastskip
  \nobreak
  \vskip -\ifdim\prevdepth>\maxdepth \maxdepth
          \else\ifdim\prevdepth>-1000pt\prevdepth
            \else\ifinner 0pt
              \else \pagedepth
          \fi \fi \fi
  \vskip -\skip@
  \ifdim\skip@<\pfbreakskip
    \advance\skip@ -1\skip@ \advance\skip@ 1\pfbreakskip
  \fi
  \penalty\pen@ltyabovepfbreak
  \vskip\skip@
  \penalty\pen@ltybelowpfbreak
  }
  \@afterindentfalse
  \@afterheading
}
\newcommand{\@spfbreakgap}{%
  \par {%
  \skip@\lastskip
  \nobreak
  \vskip -\ifdim\prevdepth>\maxdepth \maxdepth
          \else\ifdim\prevdepth>-1000pt\prevdepth
            \else\ifinner 0pt
              \else \pagedepth
          \fi \fi \fi
  \vskip -\skip@
  \ifdim\skip@<\pfbreakskip
    \advance\skip@ -1\skip@ \advance\skip@ 1\pfbreakskip
  \fi
  \penalty\pen@ltyabovepfbreak
  \vskip\skip@
  \penalty\pen@ltybelowpfbreak
  }
  \@afterindenttrue
  \@afterheading
}

\newcommand*{\noprelistbreak}{\@nobreaktrue\nopagebreak}

\newif\ifanappendix
  \anappendixfalse
\newcommand{\appendix}{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}%
  \anappendixtrue}

\newcommand{\appendixpage}{%
  \@ifstar{\@sapppage}{\@apppage}}
\newcommand*{\pupapppageinfo}[1]{}
\newcommand*{\pupapppagestarinfo}[1]{}

\def\@apppage{%
  \@setuppart
  \addappheadtotoc
  \partmark{\appendixpagename}%
  \pupapppageinfo{\appendixpagename}%
  {\centering
   \interlinepenalty \@M
   \normalfont
   \printparttitle{\appendixpagename}\par}%
  \@endpart}
\def\@sapppage{%
  \@setuppart
  \partmark{\appendixpagename}%
  \pupapppagestarinfo{\appendixpagename}%
  {\centering
   \interlinepenalty \@M
   \normalfont
   \printparttitle{\appendixpagename}\par}%
  \@endpart}

\def\addappheadtotoc{\addcontentsline{toc}{chapter}{\appendixtocname}}
\newcounter{@ppsavesec}
\newcounter{@ppsaveapp}
\setcounter{@ppsaveapp}{0}
\newcommand{\@ppsavesec}{%
  \setcounter{@ppsavesec}{\value{chapter}}}
\newcommand{\@pprestoresec}{%
  \setcounter{chapter}{\value{@ppsavesec}}}
\newcommand{\@ppsaveapp}{%
  \setcounter{@ppsaveapp}{\value{chapter}}}
\newcommand{\restoreapp}{%
  \setcounter{chapter}{\value{@ppsaveapp}}}

\newcommand{\@resets@pp}{%
  \par
  \@ppsavesec
  \setcounter{section}{0}%
  \setcounter{chapter}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}%
  \restoreapp
}

\newenvironment{appendices}%
  {\@resets@pp\anappendixtrue}%
  {\@ppsaveapp\@pprestoresec\anappendixfalse}

\newcommand{\setthesection}{\thechapter.\Alph{section}}

\newcommand{\@resets@ppsub}{
  \par
  \setcounter{section}{0}
  \renewcommand{\thesection}{\setthesection}
}

\newif\ifnamesubappendix
  \namesubappendixfalse

\newenvironment{subappendices}{%
  \@resets@ppsub
  \def\addappheadtotoc{\phantomsection
    \addcontentsline{toc}{section}{\appendixtocname}}
  \ifnamesubappendix
    \def\sectionname{\appendixname}
    \def\@seccntformat##1{\@ifundefined{##1name}%
                         {}{\csname ##1name\endcsname\ }%
        \csname the##1\endcsname\quad}
  \fi
  }{}

\newcommand{\@formatsecmark@pp}[1]{%
  \MakeUppercase{\appendixname\space
    \ifnum \c@secnumdepth >\z@
      \thesection\quad
    \fi
    #1}}
\newcommand*{\leadpagetoclevel}{chapter}
\newcommand*{\newleadpage}[3][empty]{%
  \@namedef{#2}{\@ifstar{\dlfp@psapppage{#1}{#2}{#3}}%
                        {\dlfp@papppage{#1}{#2}{#3}}}}
\newcommand*{\renewleadpage}[3][empty]{%
  \@namedef{#2}{\@ifstar{\dlfp@psapppage{#1}{#2}{#3}}%
                        {\dlfp@papppage{#1}{#2}{#3}}}}

\newcommand{\pupleadpageinfo}[3]{}
\newcommand{\pupleadpagestarinfo}[3]{}

\newcommand*{\dlfp@psapppage}[3]{%
  \@setuppart
  \partmark{#3}%
  \pupleadpagestarinfo{#1}{#2}{#3}%
  {\centering
  \interlinepenalty \@M
  \normalfont
  \printparttitle{#3}\par
  \thispagestyle{#1}}%
  \dlfp@p@endpart{#1}}
\newcommand*{\dlfp@papppage}[3]{%
  \@setuppart
  \phantomsection
  \addcontentsline{toc}{\leadpagetoclevel}{#3}%
  \partmark{#3}%
  \pupleadpageinfo{#1}{#2}{#3}%
  {\centering
  \interlinepenalty \@M
  \normalfont
  \printparttitle{#3}\par
  \thispagestyle{#1}}%
  \dlfp@p@endpart{#1}}

\newcommand*{\dlfp@p@endpart}[1]{%
  \if@twoside
    \if@openright
      \null
      \thispagestyle{#1}%
      \newpage
    \fi
  \fi
  \if@tempswa
    \twocolumn
  \fi}

\newdimen\ragrparindent
  \setlength{\ragrparindent}{\parindent}
\newcommand{\raggedyright}[1][2em]{%
  \let\\\@centercr\@rightskip \z@ \@plus #1\relax \rightskip\@rightskip
  \leftskip\z@skip
  \parindent\ragrparindent}

\newcommand{\hangfrom}[1]{%
  \setbox\@tempboxa\hbox{{#1}}%
  \hangindent \wd\@tempboxa\noindent\box\@tempboxa}

\newcommand{\hangpara}[2]{\hangindent#1\hangafter#2\noindent}
\newenvironment{hangparas}[2]{\setlength{\parindent}{\z@}
  \everypar={\hangpara{#1}{#2}}}{\par}

\if@twocolumn
  \setlength{\leftmargini}{2em}
\else
  \setlength{\leftmargini}{2.5em}
\fi
\leftmargin \leftmargini
\setlength{\leftmarginii}{2.2em}
\setlength{\leftmarginiii}{1.87em}
\setlength{\leftmarginiv}{1.7em}
\if@twocolumn
  \setlength{\leftmarginv}{.5em}
  \setlength{\leftmarginvi}{.5em}
\else
  \setlength{\leftmarginv}{1em}
  \setlength{\leftmarginvi}{1em}
\fi
\setlength{\itemindent}{\z@}
\setlength{\labelsep}{0.5em}
\setlength{\labelwidth}{\leftmargini}
  \addtolength{\labelwidth}{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty

\newlength{\parsepi}
\newlength{\topsepi}
\newlength{\itemsepi}
\newlength{\parsepii}
\newlength{\topsepii}
\newlength{\topsepiii}

\newcommand{\defaultlists}{%   %% initialise for 10pt
  \setlength\partopsep{2\p@ \@plus 1\p@ \@minus 1\p@}
  \parsepi=   4\p@   \@plus2\p@   \@minus\p@
  \topsepi=   8\p@   \@plus2\p@   \@minus4\p@
  \itemsepi=  4\p@   \@plus2\p@   \@minus\p@
  \parsepii=  2\p@   \@plus\p@    \@minus\p@
  \topsepii=  4\p@   \@plus2\p@   \@minus\p@
  \topsepiii= 2\p@   \@plus\p@    \@minus\p@
\ifcase\@ptsize  % 0 = 10pt
\or              % 1 = 11pt
  \setlength\partopsep{3\p@ \@plus 1\p@ \@minus 1\p@}
  \parsepi=   4.5\p@ \@plus2\p@   \@minus\p@
  \topsepi=   9\p@   \@plus3\p@   \@minus5\p@
  \itemsepi=  4.5\p@ \@plus2\p@   \@minus\p@
  \parsepii=  2\p@   \@plus\p@    \@minus\p@
  \topsepii=  4.5\p@ \@plus2\p@   \@minus\p@
  \topsepiii= 2\p@   \@plus\p@    \@minus\p@
\or              % 2 = 12pt
  \setlength\partopsep{3\p@ \@plus 2\p@ \@minus 2\p@}
  \parsepi=   5\p@   \@plus2.5\p@ \@minus\p@
  \topsepi=  10\p@   \@plus4\p@   \@minus6\p@
  \itemsepi=  5\p@   \@plus2.5\p@ \@minus\p@
  \parsepii=  2.5\p@ \@plus\p@    \@minus\p@
  \topsepii=  5\p@   \@plus2.5\p@ \@minus\p@
  \topsepiii= 2.5\p@ \@plus\p@    \@minus\p@
\or              % 3 = 13pt  %% not available
\or              % 4 = 14pt
  \setlength\partopsep{4\p@ \@plus 2\p@ \@minus 2\p@}
  \parsepi=   6\p@   \@plus2.5\p@ \@minus\p@
  \topsepi=  12\p@   \@plus4\p@   \@minus6\p@
  \itemsepi=  6\p@   \@plus2.5\p@ \@minus\p@
  \parsepii=  3\p@   \@plus\p@    \@minus\p@
  \topsepii=  6\p@   \@plus2.5\p@ \@minus\p@
  \topsepiii= 3\p@   \@plus\p@    \@minus\p@
\or              % 5 = 15pt  %% not available
\or              % 6 = 16pt  %% not available
\or              % 7 = 17pt
  \setlength\partopsep{5\p@ \@plus 2\p@ \@minus 2\p@}
  \parsepi=   7\p@   \@plus3\p@   \@minus\p@
  \topsepi=  14\p@   \@plus6\p@   \@minus8\p@
  \itemsepi=  7\p@   \@plus3\p@   \@minus\p@
  \parsepii=  3\p@   \@plus\p@    \@minus\p@
  \topsepii=  7\p@   \@plus3\p@   \@minus\p@
  \topsepiii= 3.5\p@ \@plus\p@    \@minus\p@
\or              % 8 = 18pt  %% not available
\or              % 9 = 9pt
  \setlength\partopsep{2\p@ \@plus 1\p@ \@minus 1\p@}
  \parsepi=   3.5\p@ \@plus2\p@   \@minus\p@
  \topsepi=   7\p@   \@plus3\p@   \@minus5\p@
  \itemsepi=  3.5\p@ \@plus2\p@   \@minus\p@
  \parsepii=  2\p@   \@plus\p@    \@minus\p@
  \topsepii=  4\p@   \@plus2\p@   \@minus\p@
  \topsepiii= 2\p@   \@plus\p@    \@minus\p@
\fi
}

\newcommand{\tightlists}{%
  \setlength\partopsep{0.5\onelineskip \@plus 0\p@ \@minus 0\p@}
  \parsepi=       \parskip
  \itemsepi =     \p@ \@plus\p@ \@minus\p@
  \topsepi =   0.5\parskip
  \parsepii =     \parskip
  \topsepii =  0.5\parskip
  \topsepiii = 0.5\parskip
}

\def\@listi{\leftmargin\leftmargini
  \parsep\parsepi
  \topsep\topsepi
  \itemsep\itemsepi}
\let\@listI\@listi
\defaultlists
\@listi

\def\@listii{\leftmargin\leftmarginii
             \labelwidth\leftmarginii
             \advance\labelwidth-\labelsep
             \topsep\topsepii
             \parsep\parsepii
             \itemsep\parsep}

\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep\topsepiii
              \parsep\z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep\topsep}

\def\@listiv{\leftmargin\leftmarginiv
             \labelwidth\leftmarginiv
             \advance\labelwidth-\labelsep}

\def\@listv{\leftmargin\leftmarginv
            \labelwidth\leftmarginv
            \advance\labelwidth-\labelsep}

\def\@listvi{\leftmargin\leftmarginvi
             \labelwidth\leftmarginvi
             \advance\labelwidth-\labelsep}

\newcommand{\firmlist}{%
  \setlength{\itemsep}{0.5\itemsep}\setlength{\parskip}{0.5\parskip}}
\newcommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

\newskip\p@psavetopsep
\newskip\p@psavepartopsep
\newcommand*{\savetrivseps}{%
  \p@psavetopsep\topsep
  \p@psavepartopsep\partopsep}
\newcommand*{\restoretrivseps}{%
  \topsep\p@psavetopsep
  \partopsep\p@psavepartopsep}
\savetrivseps

\newcommand*{\zerotrivseps}{%
  \topsep\z@
  \partopsep\z@}

\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{\theenumi.}
\newcommand{\labelenumii}{\theenumii)}
\newcommand{\labelenumiii}{\theenumiii.}
\newcommand{\labelenumiv}{\theenumiv.}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi(\theenumii)}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}
\newtoks\@enLab
\def\@enQmark{?}
\def\@enLabel#1#2{%
  \edef\@enThe{\noexpand#1{\@enumctr}}%
  \@enLab\expandafter{\the\@enLab\csname the\@enumctr\endcsname}%
  \@enloop}
\def\@enSpace{\afterassignment\@enSp@ce\let\@puptempa= }
\def\@enSp@ce{\@enLab\expandafter{\the\@enLab\space}\@enloop}
\def\@enGroup#1{\@enLab\expandafter{\the\@enLab{#1}}\@enloop}
\def\@enOther#1{\@enLab\expandafter{\the\@enLab#1}\@enloop}
\def\@enloop{\futurelet\@entemp\@enloop@}
\def\@enloop@{%
  \ifx A\@entemp         \def\@puptempa{\@enLabel\Alph  }\else
  \ifx a\@entemp         \def\@puptempa{\@enLabel\alph  }\else
  \ifx i\@entemp         \def\@puptempa{\@enLabel\roman }\else
  \ifx I\@entemp         \def\@puptempa{\@enLabel\Roman }\else
  \ifx 1\@entemp         \def\@puptempa{\@enLabel\arabic}\else
  \ifx \@sptoken\@entemp \let\@puptempa\@enSpace         \else
  \ifx \bgroup\@entemp   \let\@puptempa\@enGroup         \else
  \ifx \@enum@\@entemp   \let\@puptempa\@gobble          \else
                         \let\@puptempa\@enOther
                         \@enhook
             \fi\fi\fi\fi\fi\fi\fi\fi
  \@puptempa}
%% \providecommand\@enhook{}
  \newcommand\@enhook{}
\def\enumerate{%
  \ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\fi
  \@ifnextchar[{\@@enum@}{\@enum@}}
\def\@@enum@[#1]{%
  \@enLab{}\let\@enThe\@enQmark
  \@enloop#1\@enum@
  \ifx\@enThe\@enQmark\@warning{The counter will not be printed.%
   ^^J\space\@spaces\@spaces\@spaces The label is: \the\@enLab}\fi
  \expandafter\edef\csname label\@enumctr\endcsname{\the\@enLab}%
  \expandafter\let\csname the\@enumctr\endcsname\@enThe
  \csname c@\@enumctr\endcsname7
  \expandafter\settowidth
            \csname leftmargin\romannumeral\@enumdepth\endcsname
            {\the\@enLab\hspace{\labelsep}}%
  \@enum@}

\def\@enum@{\list{\csname label\@enumctr\endcsname}%
           {\usecounter{\@enumctr}\def\makelabel##1{\hss\llap{##1}}}}

\newcommand{\labelitemi}{\textbullet}
\newcommand{\labelitemii}{\normalfont\bfseries \textendash}
\newcommand{\labelitemiii}{\textasteriskcentered}
\newcommand{\labelitemiv}{\textperiodcentered}
\renewcommand{\itemize}[1][\@empty]{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \ifx \@empty #1\else % optional argument
      \@namedef{labelitem\romannumeral\the\@itemdepth}{#1}%
    \fi
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
       {\def\makelabel##1{\hss\llap{##1}}}%
  \fi}
\let\enditemize = \endlist


%% For compatability: these commands are deprecated and should no longer be used.
\newcounter{NumList}
\newlength{\NumWidth}
\newenvironment{numberlist}[1][1]{%
\settowidth{\NumWidth}{\upshape{#1}.\enspace}%
\begin{list}
{\leavevmode\hbox to \NumWidth{\hss\upshape\arabic{NumList}.\enspace}\hfil}
{\usecounter{NumList}%
\setlength{\topsep}{6pt plus3pt minus2pt}%
\setlength{\partopsep}{0pt}%
\setlength{\parsep}{0pt}%
\setlength{\itemsep}{0pt}%
\setlength{\leftmargin}{1em}%
\addtolength{\leftmargin}{\NumWidth}%
\setlength{\rightmargin}{0pt}%
\setlength{\listparindent}{1em}%
\setlength{\labelwidth}{\NumWidth}%
\setlength{\labelsep}{0pt}%
\setlength{\itemindent}{0pt}}}%
{\end{list}}

\newenvironment{unnumberlist}{\begin{list}
{}%%%%no label
{%%%%%no counter
\setlength{\topsep}{6pt plus3pt minus2pt}%
\setlength{\partopsep}{0pt}%
\setlength{\parsep}{0pt}%
\setlength{\itemsep}{0pt}%
\setlength{\leftmargin}{2em}%
\setlength{\rightmargin}{0pt}%
\setlength{\listparindent}{0pt}%
\setlength{\labelwidth}{0pt}%
\setlength{\itemindent}{-1em}%
\setlength{\labelsep}{0pt}}}%
{\end{list}}


%%%%% bullet list
\newenvironment{bulletlist}{%
\settowidth{\NumWidth}{\hspace*{-.5pt}$\bullet$\enspace}%
\begin{list}%
{\leavevmode\hbox to \NumWidth{\hss\hspace*{-.5pt}\raisebox{1.19pt}[0pt][0pt]{$\bullet$}\enspace}\hfil}%
{\setlength{\topsep}{6pt plus3pt minus2pt}%
\setlength{\partopsep}{0pt}%
\setlength{\parsep}{0pt}%
\setlength{\itemsep}{0pt}%
\setlength{\leftmargin}{1em}%
\addtolength{\leftmargin}{\NumWidth}%
\setlength{\rightmargin}{0pt}%
\setlength{\listparindent}{1em}%
\setlength{\labelwidth}{\NumWidth}%
\setlength{\labelsep}{0pt}%
\setlength{\itemindent}{0pt}}}%
{\end{list}}

%%% end deprecated lists

\newenvironment{description}%
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}%
               {\endlist}
\newcommand*{\descriptionlabel}[1]{\hspace\labelsep
                                   \normalfont\bfseries #1}
\newenvironment{blockdescription}%
               {\list{}{\labelwidth\z@ \itemindent 0.5em \labelsep 0.5em
                        \let\makelabel\blockdescriptionlabel}}%
               {\endlist}
\newcommand*{\blockdescriptionlabel}[1]{%%% \hspace\labelsep
                                   \normalfont\bfseries #1}
\newenvironment{quotation}%
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}%
               {\endlist}
\newenvironment{quote}%
               {\list{}{\rightmargin\leftmargin}%
                \item[]}%
               {\endlist}
\newcommand{\symbollabel}[1]{{#1 \hfill}}
\newenvironment{symbols}{\list{}%
    {\itemindent 0em \leftmargin 8em
     \labelsep 1em \labelwidth 5em
     \let\makelabel\symbollabel}}%
    {\endlist}
\newcommand{\symboldef}[2]{\item[#1] #2}
\newcounter{vslineno}
\newcounter{poemline}
\newcounter{modulo@vs}

\newcommand{\poemlines}[1]{\linenumberfrequency{#1}%
  \@pupwarn{Use \string\linenumberfrequency\space
                        instead of \string\poemlines}%
}

\newif\ifaltindent
  \altindentfalse
\newif\ifpattern
  \patternfalse
\newif\ifstarpattern
  \starpatternfalse

\newlength{\vleftskip}
  \setlength{\vleftskip}{3em}
\newlength{\vrightskip}
  \setlength{\vrightskip}{1em}

\newlength{\stanzaskip}
  \setlength{\stanzaskip}{\onelineskip}

\newcommand{\flagverse}[1]{%
  \hskip-\vleftskip\llap{#1}\hskip\vleftskip\ignorespaces}

\newlength{\versewidth}
\newlength{\vgap} \setlength{\vgap}{1.5em}
\newcommand{\vin}{\hspace*{\vgap}}
\newlength{\vindent} \setlength{\vindent}{2\vgap}
\newcommand{\vinphantom}[1]{\leavevmode\phantom{#1}}
\newcommand*{\vleftofline}[1]{\leavevmode\llap{#1}}
\newdimen\vleftmargin
  \vleftmargin=\leftmargini

\newcommand{\verselinebreak}[1][\z@]{\newline\hspace*{#1}}

\newcommand{\incr@vsline}{%
  \refstepcounter{poemline}%
  \stepcounter{vslineno}}

\newcommand{\@vsifbang}[1]{\@ifnextchar !{\@firstoftwo{#1}}}
\newcommand{\@vsifgt}[1]{\@ifnextchar >{\@firstoftwo{#1}}}

\newcommand{\@vscentercr}{%
  \ifhmode \unskip\else \@nolnerr\fi
  \hfill\rlap{\kern\vrightskip\kern\rightmargin%
              \vlvnumfont\getthelinenumber{poemline}}%
  \@vsifgt{\verselinebreak}{%
  \incr@vsline
  \par\@ifstar{\nobreak\@vsxcentercr}{%
    \@vsifbang{\@ifnextchar[ {\@vsicentercr}{}}{\@vsxcentercr}}}}
\newcommand{\@vsxcentercr}{\addvspace{-\parskip}%
  \@ifnextchar[ {\@vsicentercr}{\start@vsline}}
\def\@vsicentercr[#1]{\vskip #1\ignorespaces \start@vsline}
\newcommand{\start@vsline}{%
  \ifaltindent\ifodd\c@vslineno\else\vin\fi\fi%
  \ifpattern\get@vsindent\fi%
  \ifstarpattern\getstar@vsindent\fi}

\newcounter{verse}
\setcounter{verse}{0}
\newcommand{\theHpoemline}{\theverse.\thepoemline}

\newenvironment{verse}[1][\linewidth]{%
  \refstepcounter{verse}%
  \setcounter{poemline}{0}\refstepcounter{poemline}%
  \setcounter{vslineno}{1}%
  \let\\=\@vscentercr
  \list{}{\itemsep     \z@
          \itemindent  -\vindent
          \listparindent\itemindent
          \leftmargin   \vleftmargin
          \parsep       \stanzaskip
          \ifdim #1<\linewidth%   %% short line
            \rightmargin        \z@
            \leftmargin         \linewidth
            \advance\leftmargin -#1\relax
            \advance\leftmargin -0.5\leftmargin
            \advance\leftmargin \vindent
          \else
            \ifdim #1>\linewidth%  %% long line
              \rightmargin \z@
              \leftmargin  \vindent
            \else%                   %% default
              \rightmargin \leftmargin
              \advance\leftmargin \vindent
            \fi
          \fi}
  \item[]}{\endlist}

\newenvironment{altverse}%
  {\starpatternfalse\patternfalse\altindenttrue
   \setcounter{vslineno}{1}}%
  {\altindentfalse}

\newcommand{\@nameedef}[1]{
  \expandafter\protected@edef\csname #1\endcsname}

\newif\ifbounderror
  \bounderrorfalse
\newif\ifinteger

\newcounter{chrsinstr}  % CHARactersINSTRing

\newcommand{\newarray}[3]{%
  \@nameedef{#1-low}{#2}%
  \@nameedef{#1-high}{#3}%
  \ifnum #3<#2
    \@puperror{Limits for array #1 are in reverse order}{\@ehc}%
  \fi
}

\newcommand{\stringtoarray}[2]{%
  \def\@vsarrayname{#1}%
  \protected@edef\the@vsstring{#2}%
  \newarray{\@vsarrayname}{1}{1}%
  \@ifmtarg{#2}{%
    \c@chrsinstr \z@
    \@namedef{\@vsarrayname-1}{}
  }{%
    \c@chrsinstr \@ne
    \expandafter\@vsstringtoarray \the@vsstring\@vsend
  }
}

\def\@vsstringtoarray #1#2\@vsend{%
  \@namedef{\@vsarrayname-\the\c@chrsinstr}{#1}
  \@nameedef{\@vsarrayname-high}{\the\c@chrsinstr}
  \@ifmtarg{#2}{%
    \def\@vsinext{}%
  }{%
    \advance\c@chrsinstr \@ne
    \def\@vsinext{%
      \@vsstringtoarray #2\@vsend%
    }%
  }
  \@vsinext
}

\newcommand{\setarrayelement}[3]{%
  \checkarrayindex{#1}{#2}%
  \@nameedef{#1-#2}{#3}%
}

\newcommand{\getarrayelement}[3]{%
  \checkarrayindex{#1}{#2}%
  \protected@edef#3{\@nameuse{#1-#2}}%
}

\newcommand{\checkarrayindex}[2]{%
  \bounderrorfalse
  \expandafter\ifx\csname #1-low\endcsname\relax%
    \ifpattern\else
      \@puperror{No array called #1}{\@ehc}%
    \fi
    \bounderrortrue
  \fi
  \ifnum #2<\@nameuse{#1-low}\relax%
    \ifpattern\else
      \@puperror{Index #2 outside limits for array #1}{\@ehc}%
    \fi
    \bounderrortrue
  \fi
  \ifnum #2>\@nameuse{#1-high}\relax%
    \ifpattern\else
      \@puperror{Index #2 outside limits for array #1}{\@ehc}%
    \fi
    \bounderrortrue
  \fi
}

\newcommand{\arraytostring}[2]{%
  \def#2{}%
  \c@chrsinstr = \@nameuse{#1-low}%
  \@vsarraytostring{#1}{#2}%
}

\newcommand{\@vsarraytostring}[2]{%
  \ifnum\c@chrsinstr>\@nameuse{#1-high}\else
    \protected@edef#2{#2\@nameuse{#1-\thechrsinstr}}%
    \advance\c@chrsinstr\@ne%
    \@vsarraytostring{#1}{#2}%
  \fi%
}

\newcommand{\checkifinteger}[1]{%
  \protected@edef\@vsa{#1}%
  \ifcat _\ifnum9<1\gobm{#1} _\else A\fi
    \integertrue%
  \else
    \integerfalse%
  \fi%
}
\newcommand{\gobm}[1]{#1}

\newcommand{\indentpattern}[1]{%
  \stringtoarray{Array@vs}{#1}}

\newcommand{\get@vsindent}{%
  \getarrayelement{Array@vs}{\number\value{vslineno}}{\@vspat}%
  \ifbounderror
    \arraytostring{Array@vs}{\@vsp@t}%
    \@pupwarn{%
      Index `\thevslineno' for pattern `\@vsp@t' is out of bounds}%
    \def\@vspat{0}%
  \else
    \checkifinteger{\@vspat}%
    \ifinteger\else
      \arraytostring{Array@vs}{\@vsp@t}%
      \@pupwarn{%
       `\@vspat' at index `\thevslineno' in pattern `\@vsp@t'
       is not a digit}%
      \def\@vspat{0}%
    \fi
  \fi
  \ifcase\@vspat\else\hspace*{\@vspat\vgap}\fi}
\newcommand{\getstar@vsindent}{%
  \expandafter\ifx\csname Array@vs-high\endcsname\relax
    \@puperror{A pattern has not been specified}{\@ehc}
  \else
    \ifnum\c@vslineno>\@nameuse{Array@vs-high}%
      \setcounter{vslineno}{1}%
     \fi
     \get@vsindent
  \fi}

\newenvironment{patverse}%
  {\starpatternfalse\patterntrue\altindentfalse
   \setcounter{vslineno}{1}}%
  {\patternfalse}

\newenvironment{patverse*}%
  {\starpatterntrue\patternfalse\altindentfalse
   \setcounter{vslineno}{1}}%
  {\starpatternfalse}

\newcommand{\poemtitle}{\par%
  \secdef\@vsptitle\@vssptitle}
\newcommand{\poemtoc}{section}

\newcommand*{\puppoeminfo}[1]{}
\newcommand*{\puppoemstarinfo}[1]{}

\long\def\@vsptitle[#1]#2{%
  \phantomsection
  \addcontentsline{toc}{\poemtoc}{#1}%
  \M@gettitle{#1}%
  \puppoeminfo{#1}%
  \poemtitlemark{#1}%
  \@vstypeptitle{#2}%
  \@afterheading}

\long\def\@vssptitle#1{%
  \M@gettitle{#1}%
  \puppoemstarinfo{#1}%
  \@vstypeptitle{#1}%
  \@afterheading}

\newcommand{\@vstypeptitle}[1]{%
  \vspace{\beforepoemtitleskip}%
  {\poemtitlefont #1\par}%
  \vspace{\afterpoemtitleskip}%
}

\newcommand{\poemtitlefont}{\normalfont\large\bfseries\centering}
\newcommand{\poemtitlemark}[1]{}

\newlength{\beforepoemtitleskip}
  \setlength{\beforepoemtitleskip}{3.5ex \@plus 1ex \@minus .2ex}
\newlength{\afterpoemtitleskip}
  \setlength{\afterpoemtitleskip}{2.3ex \@plus.2ex}

\newif\if@numptitle
\newcommand*{\NumberPoemTitle}{\@numptitletrue}
\newcommand*{\PlainPoemTitle}{\@numptitlefalse}
\NumberPoemTitle

\newcounter{poem}\setcounter{poem}{0}
  \renewcommand*{\thepoem}{\@arabic\c@poem}
\newcommand*{\theHpoem}{\arabic{poem}}

\newcommand*{\poemtitlestarmark}[1]{}
\newcommand*{\poemtitlepstyle}{}
\newcommand*{\poemtitlestarpstyle}{}

\newcommand\PoemTitle{%
  \par
  \@afterindentfalse
  \@ifstar{\@p@psPoemTitle}{\@p@pPoemTitle}}

\newcommand{\@p@pPoemTitle}[1][]{%
  \def\poemt@c{#1}% capture first optional arg
  \@ifnextchar[{\@PoemTitle}{\@PoemTitle[]}%
}

\newcommand*{\pupPoemTitleinfo}[4]{}
\newcommand*{\pupPoemTitlestarinfo}[2]{}

\def\@PoemTitle[#1]#2{%
  \phantomsection
  \ifx\poemt@c\@empty % no optional args
    \def\poemf@rtoc{#2}%
    \def\poemf@rhdr{#2}%
  \else                  % at least one opt arg
    \let\poemf@rtoc\poemt@c
    \ifx\@empty#1\@empty
      \let\poemf@rhdr\poemt@c
    \else
      \def\poemf@rhdr{#1}%
    \fi
  \fi
  \p@p@Andfalse
  \if@numptitle
    \if@mainmatter
      \p@p@Andtrue
    \fi
  \fi
  \ifp@p@And
    \refstepcounter{poem}%
  \fi
  \@makePoemTitlehead{#2}%
  \@afterheading
  \poemtitlemark{\poemf@rhdr}%
  \poemtitlepstyle
  \ifp@p@And
    \addcontentsline{toc}{\poemtoc}{%
      \protect\numberline{\thepoem}\poemf@rtoc}%
    \pupPoemTitleinfo{\thepoem}{\poemf@rtoc}{\poemf@rhdr}{#2}%
  \else
    \addcontentsline{toc}{\poemtoc}{\poemf@rtoc}%
    \pupPoemTitleinfo{}{\poemf@rtoc}{\poemf@rhdr}{#2}%
  \fi
  \ifheadnameref\M@gettitle{\poemf@rhdr}\else\M@gettitle{\poemf@rtoc}\fi
}

\def\@makePoemTitlehead#1{{%
  \PoemTitleheadstart
  \parindent \z@ \normalfont
   \ifp@p@And
     \printPoemTitlenum
     \afterPoemTitlenum
   \else
     \printPoemTitlenonum
   \fi
   \interlinepenalty\@M
   \printPoemTitletitle{#1}%
   \afterPoemTitle
  }}

\newcommand{\@PTchs@def@ult}{%
  \def\PoemTitleheadstart{\vspace{\beforePoemTitleskip}}
  \def\printPoemTitlenum{\PoemTitlenumfont \thepoem}
  \def\afterPoemTitlenum{\par\nobreak\vskip \midPoemTitleskip}
  \def\printPoemTitlenonum{}
  \def\printPoemTitletitle##1{\PoemTitlefont ##1}
  \def\afterPoemTitle{\par\nobreak\vskip \afterPoemTitleskip}
}
\@PTchs@def@ult

\newcommand*{\PoemTitlenumfont}{\normalfont\large\centering}
\newcommand*{\PoemTitlefont}{\normalfont\large\centering}
\newlength{\beforePoemTitleskip}
  \setlength{\beforePoemTitleskip}{1\onelineskip}
\newlength{\midPoemTitleskip}
  \setlength{\midPoemTitleskip}{0pt}
\newlength{\afterPoemTitleskip}
  \setlength{\afterPoemTitleskip}{1\onelineskip}

\newcommand{\@p@psPoemTitle}[2][\@empty]{%
  \@sPoemTitle{#2}%
  \ifx \@empty#1
    \def\poemf@rhdr{#2}%
  \else   % opt arg
    \def\poemf@rhdr{#1}%
  \fi
  \poemtitlestarmark{\poemf@rhdr}%
  \poemtitlestarpstyle
  \pupPoemTitlestarinfo{\poemf@rhdr}{#2}%
}

\newcommand{\@sPoemTitle}[1]{%
  \@makesPoemTitlehead{#1}%
  \@afterheading
  \M@gettitle{#1}}

\def\@makesPoemTitlehead#1{{%
  \PoemTitleheadstart
  \parindent \z@ \normalfont
  \printPoemTitlenonum
  \interlinepenalty\@M
  \printPoemTitletitle{#1}
  \afterPoemTitle}}

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}

\skip\@mpfootins = \skip\footins

\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}

\@addtoreset{equation}{chapter}
\renewcommand{\theequation}{%
  \ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}


%%%%%%%%%% Array package code %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% With acknowledgements to %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Frank Mittelbach & David Carlisle %%%%%%%%%%%%%%%%%%%%%

\def\@addtopreamble#1{\xdef\@preamble{\@preamble #1}}
\def\@testpach{\@chclass
 \ifnum \@lastchclass=6 \@ne \@chnum \@ne \else
  \ifnum \@lastchclass=7 5 \else
   \ifnum \@lastchclass=8 \tw@ \else
    \ifnum \@lastchclass=9 \thr@@
   \else \z@
   \ifnum \@lastchclass = 10 \else
   \edef\@nextchar{\expandafter\string\@nextchar}%
   \@chnum
   \if \@nextchar c\z@ \else
    \if \@nextchar l\@ne \else
     \if \@nextchar r\tw@ \else
   \z@ \@chclass
   \if\@nextchar |\@ne \else
    \if \@nextchar !6 \else
     \if \@nextchar @7 \else
      \if \@nextchar <8 \else
       \if \@nextchar >9 \else
  10
  \@chnum
  \if \@nextchar m\thr@@\else
   \if \@nextchar p4 \else
    \if \@nextchar b5 \else
   \z@ \@chclass \z@ \@preamerr \z@ \fi \fi \fi \fi
   \fi \fi  \fi  \fi  \fi  \fi  \fi \fi \fi \fi \fi \fi}
\def\prepnext@tok{\advance \count@ \@ne
   \toks\count@{}}

\def\save@decl{\toks \count@ = \expandafter\expandafter\expandafter
                  {\expandafter\@nextchar\the\toks\count@}}

\def\insert@column{%
   \the@toks \the \@tempcnta
   \ignorespaces \@sharp \unskip
   \the@toks \the \count@ \relax}
\let\p@pold@addamp\@addamp
\newcommand*{\p@p@addamp}{%
  \if@firstamp
    \@firstampfalse
    \global\@curtab\@ne
  \else
    \@addtopreamble{&}
    \global\advance\@curtab\@ne
  \fi}
\let\@addamp\p@p@addamp

\newdimen\col@sep
\def\@acol{\@addtopreamble{\hskip\col@sep}}
\def\@mkpream#1{\gdef\@preamble{}\@lastchclass 4 \@firstamptrue
   \let\@sharp\relax \let\@startpbox\relax \let\@endpbox\relax
   \@temptokena{#1}\@tempswatrue
   \@whilesw\if@tempswa\fi{\@tempswafalse\the\NC@list}%
   \count@\m@ne
   \let\the@toks\relax
   \prepnext@tok
   \expandafter \@tfor \expandafter \@nextchar
    \expandafter :\expandafter =\the\@temptokena \do
   {\@testpach
   \ifcase \@chclass \@classz \or \@classi \or \@classii
     \or \save@decl \or \or \@classv \or \@classvi
     \or \@classvii \or \@classviii
     \or \@classx
     \or \@classx \fi
   \@lastchclass\@chclass}%
   \ifcase\@lastchclass
   \@acol \or
   \or
   \@acol \or
   \@preamerr \thr@@ \or
   \@preamerr \tw@ \@addtopreamble\@sharp \or
   \or
   \else  \@preamerr \@ne \fi
   \def\the@toks{\the\toks}}
\def\@classx{%
  \ifcase \@lastchclass
  \@acolampacol \or
  \@addamp \@acol \or
  \@acolampacol \or
  \or
  \@acol \@firstampfalse \or
  \@addamp
  \fi}
\def\@classz{\@classx
   \@tempcnta \count@
   \prepnext@tok
   \@addtopreamble{\ifcase \@chnum
      \hfil
      \d@llarbegin
      \insert@column
      \d@llarend \hfil \or
      \hskip1sp\d@llarbegin \insert@column \d@llarend \hfil \or
      \hfil\hskip1sp\d@llarbegin \insert@column \d@llarend \or
   $\vcenter
   \@startpbox{\@nextchar}\insert@column \@endpbox $\or
   \vtop \@startpbox{\@nextchar}\insert@column \@endpbox \or
   \vbox \@startpbox{\@nextchar}\insert@column \@endpbox
  \fi}\prepnext@tok}

\let\@classix\relax

\def\@classviii{\ifnum \@lastchclass >\z@\ifnum\@lastchclass=\tw@\else
      \@preamerr 4\@chclass 6 \@classvi \fi\fi}

\def\@arrayrule{\@addtopreamble \vline}

\def\@classvii{\ifnum \@lastchclass = \thr@@
   \@preamerr \thr@@ \fi}

\def\@classvi{\ifcase \@lastchclass
      \@acol \or
      \@addtopreamble{\hskip \doublerulesep}\or
      \@acol \or
      \@classvii
      \fi}

\def\@classii{\advance \count@ \m@ne
   \save@decl\prepnext@tok}

\def\@classv{\save@decl
   \expandafter\NC@ecs\@nextchar\extracolsep{}\extracolsep\@@@
   \@addtopreamble{\d@llarbegin\the@toks\the\count@\relax\d@llarend}%
   \prepnext@tok}
\def\NC@ecs#1\extracolsep#2#3\extracolsep#4\@@@{\def\@tempa{#2}%
  \ifx\@tempa\@empty\else\toks\count@={#1\tabskip#2\relax#3}\fi}

\def\@classi{\@classvi
   \ifcase \@chnum \@arrayrule \or
      \@classv \fi}

\def\@startpbox#1{\bgroup
  \setlength\hsize{#1}\@arrayparboxrestore
   \everypar{%
      \vrule \@height \ht\@arstrutbox \@width \z@
      \everypar{}}%
   }
\def\@endpbox{\@finalstrut\@arstrutbox \egroup\hfil}
\def\@array[#1]#2{%
  \@tempdima \ht \strutbox
  \advance \@tempdima by\extrarowheight
  \setbox \@arstrutbox \hbox{\vrule
             \@height \arraystretch \@tempdima
             \@depth \arraystretch \dp \strutbox
             \@width \z@}%
  \begingroup
  \@mkpream{#2}%
  \xdef\@preamble{\noexpand \ialign \@halignto
                  \bgroup \@arstrut \@preamble
                          \tabskip \z@ \cr}%
  \endgroup
  \@arrayleft
  \if #1t\vtop \else \if#1b\vbox \else \vcenter \fi \fi
  \bgroup
  \let \@sharp ##\let \protect \relax
  \lineskip \z@
  \baselineskip \z@
  \m@th
  \let\\\@arraycr \let\tabularnewline\\\let\par\@empty \@preamble}
\newdimen \extrarowheight
\extrarowheight=0pt
\def\@arstrut{\unhcopy\@arstrutbox}
\def\@arraycr{\relax\iffalse{\fi\ifnum 0=`}\fi
  \@ifstar \@xarraycr \@xarraycr}
\def\@xarraycr{\@ifnextchar [%
  \@argarraycr {\ifnum 0=`{}\fi\cr}}
\def\@argarraycr[#1]{\ifnum0=`{}\fi\ifdim #1>\z@
  \expandafter\@xargarraycr\else
  \expandafter\@yargarraycr\fi{#1}}
\def\@xargarraycr#1{\unskip
  \@tempdima #1\advance\@tempdima \dp\@arstrutbox
  \vrule \@depth\@tempdima \@width\z@ \cr}
\def\@yargarraycr#1{\cr\noalign{\vskip #1}}
\long\def\multicolumn#1#2#3{%
   \multispan{#1}\begingroup
   \def\@addamp{\if@firstamp \@firstampfalse \else
                \@preamerr 5\fi}%
   \@mkpream{#2}\@addtopreamble\@empty
   \endgroup
   \def\@sharp{#3}%
   \@arstrut \@preamble
   \null
   \ignorespaces}
\let\d@llarbegin\begingroup
\let\d@llarend\endgroup
\def\array{\col@sep\arraycolsep
  \def\d@llarbegin{$}\let\d@llarend\d@llarbegin\gdef\@halignto{}%
  \@tabarray}
\def\@tabarray{\@ifnextchar[{\@@array}{\@@array[c]}}
\let\@@array\@array
\def\tabular{\gdef\@halignto{}\@tabular}
\expandafter\def\csname tabular*\endcsname#1{%
       \setlength\dimen@{#1}%
       \xdef\@halignto{to\the\dimen@}\@tabular}
\def\@tabular{%
  \leavevmode
  \hbox \bgroup $\col@sep\tabcolsep \let\d@llarbegin\begingroup
                                    \let\d@llarend\endgroup
  \@tabarray}
\def\endarray{\crcr \egroup \egroup \@arrayright \gdef\@preamble{}}
\let\@arrayleft\@empty
\let\@arrayright\@empty
\def\endtabular{\endarray $\egroup}
\expandafter\let\csname endtabular*\endcsname=\endtabular
\let\@ampacol=\relax        \let\@expast=\relax
\let\@arrayclassiv=\relax   \let\@arrayclassz=\relax
\let\@tabclassiv=\relax     \let\@tabclassz=\relax
\let\@arrayacol=\relax      \let\@tabacol=\relax
\let\@tabularcr=\relax      \let\@@endpbox=\relax
\let\@argtabularcr=\relax   \let\@xtabularcr=\relax
\def\@preamerr#1{\def\@tempd{{..} at wrong position: }%
   \ClassError{pup}{%
   \ifcase #1 Illegal pream-token (\@nextchar): `c' used\or %0
    Missing arg: token ignored\or                           %1
    Empty preamble: `l' used\or                             %2
    >\@tempd token ignored\or                               %3
    <\@tempd changed to !{..}\or                            %4
    Only one column-spec. allowed.\fi}\@ehc}                %5

\def\newcolumntype#1{%
  \edef\NC@char{\string#1}%
  \@ifundefined{NC@find@\NC@char}%
    {\@tfor\next:=<>clrmbp@!|\do{\if\noexpand\next\NC@char
        \@pupwarn{Redefining primitive column \NC@char}\fi}%
     \NC@list\expandafter{\the\NC@list\NC@do#1}}%
    {\@pupwarn{Column \NC@char\space is already defined}}%
  \@namedef{NC@find@\NC@char}##1#1{\NC@{##1}}%
  \@ifnextchar[{\newcol@{\NC@char}}{\newcol@{\NC@char}[0]}}
\def\newcol@#1[#2]#3{\expandafter\@reargdef
     \csname NC@rewrite@#1\endcsname[#2]{\NC@find#3}}
\def\NC@#1{%
  \@temptokena\expandafter{\the\@temptokena#1}\futurelet\next\NC@ifend}
\def\NC@ifend{%
  \ifx\next\relax
    \else\@tempswatrue\expandafter\NC@rewrite\fi}
\def\NC@do#1{%
  \expandafter\let\expandafter\NC@rewrite
    \csname NC@rewrite@\string#1\endcsname
  \expandafter\let\expandafter\NC@find
    \csname NC@find@\string#1\endcsname
  \expandafter\@temptokena\expandafter{\expandafter}%
        \expandafter\NC@find\the\@temptokena#1\relax}
\def\showcols{{\def\NC@do##1{\let\NC@do\NC@show}\the\NC@list}}
\def\NC@show#1{%
  \typeout{Column #1\expandafter\expandafter\expandafter\NC@strip
  \expandafter\meaning\csname NC@rewrite@#1\endcsname\@@}}
\def\NC@strip#1:#2->#3 #4\@@{#2 -> #4}
\newtoks\NC@list
\newcolumntype{*}[2]{}
\long\@namedef{NC@rewrite@*}#1#2{%
  \count@#1\relax
  \loop
  \ifnum\count@>\z@
    \advance\count@\m@ne
    \@temptokena\expandafter{\the\@temptokena#2}%
  \repeat
  \NC@find}

\newlength{\extratabsurround}
\setlength{\extratabsurround}{2pt}
\newlength{\backup@length}
\newcommand{\firsthline}{%
  \multicolumn1c{%
    \global\backup@length\ht\@arstrutbox
    \global\advance\backup@length\dp\@arstrutbox
    \global\advance\backup@length\arrayrulewidth
     \raise\extratabsurround\copy\@arstrutbox
    }\\[-\backup@length]\hline
}
\newcommand{\lasthline}{\hline\multicolumn1c{%
    \global\backup@length2\ht\@arstrutbox
    \global\advance\backup@length2\dp\@arstrutbox
    \global\advance\backup@length\arrayrulewidth
    }\\[-\backup@length]%
    \multicolumn1c{%
       \lower\extratabsurround\copy\@arstrutbox
       }%
}
\CheckCommand*\@xhline{\ifx\reserved@a\hline
               \vskip\doublerulesep
               \vskip-\arrayrulewidth
             \fi
      \ifnum0=`{\fi}}
\renewcommand*\@xhline{\ifx\reserved@a\hline
               \vskip\doublerulesep
             \fi
      \ifnum0=`{\fi}}

%%%%%%%%%%% end Array package code %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Dcolumn package code %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% With acknowledgements to David Carlisle %%%%%%%%%%%%%%%%%%%%%

\def\DC@#1#2#3{%
  \uccode`\~=`#1\relax
  \m@th
  \afterassignment\DC@x\count@#3\relax{#1}{#2}}
\def\DC@x#1\relax#2#3{%
  \ifnum\z@>\count@
    \expandafter\DC@centre
  \else
    \expandafter\DC@right
  \fi
  {#2}{#3}{#1}}
\def\DC@centre#1#2#3{%
  \let\DC@end\DC@endcentre
  \uppercase{\def~}{$\egroup\setbox\tw@=\hbox\bgroup${#2}}%
  \setbox\tw@=\hbox{${\phantom{{#2}}}$}%
  \setbox\z@=\hbox\bgroup$\mathcode`#1="8000 }
\def\DC@endcentre{$\egroup
    \ifdim \wd\z@>\wd\tw@
      \setbox\tw@=\hbox to\wd\z@{\unhbox\tw@\hfill}%
    \else
      \setbox\z@=\hbox to\wd\tw@{\hfill\unhbox\z@}\fi
    \box\z@\box\tw@}
\def\DC@right#1#2#3{%
  \ifx\relax#3\relax
    \hfill
    \let\DC@rl\bgroup
  \else
    \edef\DC@rl{to\the\count@\dimen@ii\bgroup\hss\hfill}%
    \count@\@gobble#3\relax
  \fi
  \let\DC@end\DC@endright
  \uppercase{\def~}{$\egroup\setbox\tw@\hbox to\dimen@\bgroup${#2}}%
   \setbox\z@\hbox{$1$}\dimen@ii\wd\z@
   \dimen@\count@\dimen@ii
   \setbox\z@\hbox{${#2}$}\advance\dimen@\wd\z@
   \setbox\tw@\hbox to\dimen@{}%
   \setbox\z@\hbox\DC@rl$\mathcode`#1="8000 }
\def\DC@endright{$\hfil\egroup\box\z@\box\tw@}
\newcolumntype{D}[3]{>{\DC@{#1}{#2}{#3}}c<{\DC@end}}

%%%%%%%%%% end Dcolumn package code %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Delarray package code %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% With acknowledgements to David Carlisle %%%%%%%%%%%%%%%%%%%%%

\def\@@array[#1]{\@ifnextchar\bgroup
  {\let\@arrayleft\relax\let\@arrayright\relax\@array[#1]}%
  {\@del@array[#1]}}
\def\@del@array[#1]#2#3#4{%
  \setbox\z@\hbox{$\left#2\right#4$}%
  \if#1c\def\@arrayleft{\left#2}\def\@arrayright{\right#4}%
  \else\def\@arrayleft{\setbox\z@}%
  \def\@arrayright{%
     \dimen@=\dp\z@
     \advance\dimen@-\ht\z@
     \divide \dimen@ by \tw@
     \advance\dimen@ by\fontdimen22 \textfont\tw@
     \lower\dimen@\hbox{$\left#2\vcenter{\unvbox\z@}\right#4$}}%
  \fi
  \@array[#1]{#3}}
%%%%%%%%%% end Delarray package code %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Tabularx package code %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% With acknowledgements to David Carlisle %%%%%%%%%%%%%%%%%%%%%

\newdimen\TX@col@width
\newdimen\TX@old@table
\newdimen\TX@old@col
\newdimen\TX@target
\newdimen\TX@delta
\newcount\TX@cols
\newif\ifTX@
\def\tabularx#1{%
\edef\TX@{\@currenvir}%
  {\ifnum0=`}\fi
  \setlength\TX@target{#1}%
  \TX@typeout{Target width: #1 = \the\TX@target.}%
  \toks@{}\TX@get@body}

\let\endtabularx\relax
\long\def\TX@get@body#1\end
  {\toks@\expandafter{\the\toks@#1}\TX@find@end}
\def\TX@find@end#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\TX@\expandafter\TX@endtabularx
  \else\toks@\expandafter
    {\the\toks@\end{#1}}\expandafter\TX@get@body\fi}
\def\TX@{tabularx}
\def\TX@endtabularx{%
  \expandafter\TX@newcol\expandafter{\tabularxcolumn{\TX@col@width}}%
  \let\verb\TX@verb
  \def\@elt##1{\global\value{##1}\the\value{##1}\relax}%
  \edef\TX@ckpt{\cl@@ckpt}%
  \let\@elt\relax
  \TX@old@table\maxdimen
  \TX@col@width\TX@target
  \global\TX@cols\@ne
  \TX@typeout@
    {\@spaces Table Width\@spaces Column Width\@spaces X Columns}%
  \TX@trial{\def\NC@rewrite@X{%
          \global\advance\TX@cols\@ne\NC@find p{\TX@col@width}}}%
  \loop
    \TX@arith
    \ifTX@
    \TX@trial{}%
  \repeat
  {\let\@footnotetext\TX@ftntext\let\@xfootnotenext\TX@xftntext
    \csname tabular*\expandafter\endcsname\expandafter\TX@target
      \the\toks@
    \csname endtabular*\endcsname}%
  \global\TX@ftn\expandafter{\expandafter}\the\TX@ftn
  \ifnum0=`{\fi}%
  \expandafter\end\expandafter{\TX@}}
\def\TX@arith{%
  \TX@false
  \ifdim\TX@old@table=\wd\@tempboxa
    \TX@col@width\TX@old@col
    \TX@typeout@{Reached minimum width, backing up.}%
  \else
    \dimen@\wd\@tempboxa
    \advance\dimen@ -\TX@target
    \ifdim\dimen@<\TX@delta
      \TX@typeout@{Reached target.}%
    \else
      \ifnum\TX@cols>\@ne
        \advance\TX@cols\m@ne
      \fi
      \divide\dimen@\TX@cols
      \advance\dimen@ -\TX@col@width
      \ifdim \dimen@ >\z@
        \@pupwarn{X Columns too narrow (table too wide)\MessageBreak}%
        \TX@col@width\TX@error@width\relax
      \else
        \TX@old@col\TX@col@width
        \TX@old@table\wd\@tempboxa
        \TX@col@width-\dimen@
        \TX@true
      \fi
    \fi
  \fi}
\def\TX@error@width{1em}
\TX@delta\hfuzz
\newcolumntype{X}{}
\def\tabularxcolumn#1{p{#1}}
\def\TX@newcol{\newcol@{X}[0]}
\def\TX@trial#1{%
  \setbox\@tempboxa\hbox{%
    #1\relax
  \let\@footnotetext\TX@trial@ftn
  \let\TX@vwarn\@empty
   \expandafter\let\expandafter\tabularx\csname tabular*\endcsname
   \expandafter\let\expandafter\endtabularx\csname endtabular*\endcsname
   \def\write{\begingroup
     \def\let{\afterassignment\endgroup\toks@}%
        \afterassignment\let\count@}%
    \hbadness\@M
    \hfuzz\maxdimen
    \let\hbadness\@tempcnta
    \let\hfuzz\@tempdima
    \expandafter\tabular\the\toks@
    \endtabular}%
  \TX@ckpt
  \TX@typeout@{\@spaces
     \expandafter\TX@align
        \the\wd\@tempboxa\space\space\space\space\space\@@
     \expandafter\TX@align
        \the\TX@col@width\space\space\space\space\space\@@
     \@spaces\the\TX@cols}}
\def\TX@align#1.#2#3#4#5#6#7#8#9\@@{%
  \ifnum#1<10 \space\fi
  \ifnum#1<100 \space\fi
  \ifnum#1<\@m\space\fi
  \ifnum#1<\@M\space\fi
  #1.#2#3#4#5#6#7#8\space\space}
\def\arraybackslash{\let\\\@arraycr}
\def\tracingtabularx{%
  \def\TX@typeout{\ClassWarningNoLine{pup}}%
  \def\TX@typeout@##1{\typeout{(tabularx) ##1}}}
\let\TX@typeout\@gobble
\let\TX@typeout@\@gobble
\newtoks\TX@ftn
\long\def\TX@ftntext#1{%
  \edef\@tempa{\the\TX@ftn\noexpand\footnotetext
                    [\the\csname c@\@mpfn\endcsname]}%
  \global\TX@ftn\expandafter{\@tempa{#1}}}%
\long\def\TX@xftntext[#1]#2{%
  \global\TX@ftn\expandafter{\the\TX@ftn\footnotetext[#1]{#2}}}
\long\def\TX@trial@ftn#1{}
{\uccode`\*=`\ %
\uppercase{\gdef\TX@verb{%
  \leavevmode\null\TX@vwarn
  {\ifnum0=`}\fi\ttfamily\let\\\ignorespaces
  \@ifstar{\let~*\TX@vb}{\TX@vb}}}}
\def\TX@vb#1{\def\@tempa##1#1{\toks@{##1}\edef\@tempa{\the\toks@}%
    \expandafter\TX@v\meaning\@tempa\\ \\\ifnum0=`{\fi}}\@tempa!}
\def\TX@v#1!{\afterassignment\TX@vfirst\let\@tempa= }
\begingroup
\catcode`\*=\catcode`\#
\catcode`\#=12
\gdef\TX@vfirst{%
  \if\@tempa#%
    \def\@tempb{\TX@v@#}%
  \else
    \let\@tempb\TX@v@
    \if\@tempa\space~\else\@tempa\fi
  \fi
  \@tempb}
\gdef\TX@v@*1 *2{%
  \TX@v@hash*1##\relax\if*2\\\else~\expandafter\TX@v@\fi*2}
\gdef\TX@v@hash*1##*2{*1\ifx*2\relax\else#\expandafter\TX@v@hash\fi*2}
\endgroup
\def\TX@vwarn{%
  \@warning{\noexpand\verb may be unreliable inside tabularx}%
  \global\let\TX@vwarn\@empty}

%%%%%%%%%% end Tabularx package code %%%%%%%%%%%%%%%%%%%%%

\newcommand*{\bktabrule}[1]{%
  \hrule \@height#1}

%%%%%%%%%% Booktabs package code       %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% slightly modified by PRW    %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% by permission of Simon Fear %%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%
  \providecommand*{\CT@arc@}{}}

\newdimen\heavyrulewidth
\newdimen\lightrulewidth
\newdimen\cmidrulewidth
\newdimen\belowrulesep
\newdimen\belowbottomsep
\newdimen\aboverulesep
\newdimen\abovetopsep
\newdimen\cmidrulesep
\newdimen\cmidrulekern
\newdimen\defaultaddspace
\heavyrulewidth=.08em
\lightrulewidth=.05em
\cmidrulewidth=.03em
\belowrulesep=.65ex
\belowbottomsep=\z@
\aboverulesep=.4ex
\abovetopsep=\z@
\cmidrulesep=\doublerulesep
\cmidrulekern=.5em
\defaultaddspace=.5em

\newcount\@cmidla
\newcount\@cmidlb
\newdimen\@aboverulesep
\newdimen\@belowrulesep
\newcount\@thisruleclass
\newcount\@lastruleclass
\@lastruleclass=0
\newdimen\@thisrulewidth

\def\futurenonspacelet#1{\def\@BTcs{#1}%
 \afterassignment\@BTfnslone\let\nexttoken= }
\def\@BTfnslone{\expandafter\futurelet\@BTcs\@BTfnsltwo}
\def\@BTfnsltwo{\expandafter\ifx\@BTcs\@sptoken\let\next=\@BTfnslthree
 \else\let\next=\nexttoken\fi \next}
\def\@BTfnslthree{\afterassignment\@BTfnslone\let\next= }




\def\toprule{\noalign{\ifnum0=`}\fi
  \@aboverulesep=\abovetopsep
  \global\@belowrulesep=\belowrulesep
  \global\@thisruleclass=\@ne
  \@ifnextchar[{\@BTrule}{\@BTrule[\heavyrulewidth]}}

\def\midrule{\noalign{\ifnum0=`}\fi
  \@aboverulesep=\aboverulesep
  \global\@belowrulesep=\belowrulesep
  \global\@thisruleclass=\@ne
  \@ifnextchar[{\@BTrule}{\@BTrule[\lightrulewidth]}}

\def\bottomrule{\noalign{\ifnum0=`}\fi
  \@aboverulesep=\aboverulesep
  \global\@belowrulesep=\belowbottomsep
  \global\@thisruleclass=\@ne
  \@ifnextchar[{\@BTrule}{\@BTrule[\heavyrulewidth]}}

\def\specialrule#1#2#3{\noalign{\ifnum0=`}\fi
  \@aboverulesep=#2\global\@belowrulesep=#3\global\@thisruleclass=\tw@
  \@BTrule[#1]}

\def\addlinespace{\noalign{\ifnum0=`}\fi
  \@ifnextchar[{\@addspace}{\@addspace[\defaultaddspace]}}
\def\@addspace[#1]{\global\@belowrulesep=#1\global\@thisruleclass=\tw@
  \futurelet\@tempa\@BTendrule}

\def\@BTrule[#1]{%
  \global\@thisrulewidth=#1\relax
  \ifnum\@thisruleclass=\tw@\vskip\@aboverulesep\else
  \ifnum\@lastruleclass=\z@\vskip\@aboverulesep\else
  \ifnum\@lastruleclass=\@ne\vskip\doublerulesep\fi\fi\fi

  \ifx\longtable\undefined\let\@BTswitch\@BTnormal\else
  \ifx\hline\LT@hline\let\@BTswitch\@BLTrule
  \else\let\@BTswitch\@BTnormal\fi\fi
  \@BTswitch}

\def\@BTnormal{%
%%  \bktabrule{\@thisrulewidth}
  {\CT@arc@\bktabrule{\@thisrulewidth}}%
  \futurenonspacelet\@tempa\@BTendrule}
\def\@BLTrule{\@ifnextchar({\@@BLTrule}{\@@BLTrule()}}
\def\@@BLTrule(#1){\@setrulekerning{#1}%
\global\@cmidlb\LT@cols
\ifnum0=`{\fi}%
\@cmidruleb
\noalign{\ifnum0=`}\fi
\futurenonspacelet\@tempa\@BTendrule}

\def\@BTendrule{%
  \ifx\@tempa\toprule\global\@lastruleclass=\@thisruleclass
  \else\ifx\@tempa\midrule\global\@lastruleclass=\@thisruleclass
  \else\ifx\@tempa\bottomrule\global\@lastruleclass=\@thisruleclass
  \else\ifx\@tempa\cmidrule\global\@lastruleclass=\@thisruleclass
  \else\ifx\@tempa\specialrule\global\@lastruleclass=\@thisruleclass
  \else\ifx\@tempa\addlinespace\global\@lastruleclass=\@thisruleclass
  \else\global\@lastruleclass=\z@\fi\fi\fi\fi\fi\fi
  \ifnum\@lastruleclass=\@ne\relax\else\vskip\@belowrulesep\fi
  \ifnum0=`{\fi}}
\def\@setrulekerning#1{%
  \global\let\cmrkern@l\z@
  \global\let\cmrkern@r\z@
  \@tfor\@tempa :=#1\do
  {\def\@tempb{r}%
   \ifx\@tempa\@tempb
     \global\let\cmrkern@r\cmidrulekern
      \def\cmrsideswitch{\cmrkern@r}%
   \else
     \def\@tempb{l}%
     \ifx\@tempa\@tempb
       \global\let\cmrkern@l\cmidrulekern
       \def\cmrsideswitch{\cmrkern@l}%
     \else
       \global\expandafter\let\cmrsideswitch\@tempa
     \fi
   \fi}}

\def\cmidrule{\noalign{\ifnum0=`}\fi
    \@ifnextchar[{\@cmidrule}{\@cmidrule[\cmidrulewidth]}}
\def\@cmidrule[#1]{\@ifnextchar({\@@cmidrule[#1]}{\@@cmidrule[#1]()}}
\def\@@cmidrule[#1](#2)#3{\@@@cmidrule[#3]{#1}{#2}}

\def\@@@cmidrule[#1-#2]#3#4{\global\@cmidla#1\relax
    \global\advance\@cmidla\m@ne
    \ifnum\@cmidla>0\global\let\@gtempa\@cmidrulea\else
    \global\let\@gtempa\@cmidruleb\fi
    \global\@cmidlb#2\relax
    \global\advance\@cmidlb-\@cmidla
    \global\@thisrulewidth=#3
    \@setrulekerning{#4}
    \ifnum\@lastruleclass=\z@\vskip \aboverulesep\fi
    \ifnum0=`{\fi}\@gtempa
    \noalign{\ifnum0=`}\fi\futurenonspacelet\@tempa\@xcmidrule}
\def\@xcmidrule{\ifx\@tempa\cmidrule\vskip-\@thisrulewidth
    \global\@lastruleclass=\@ne\else
    \ifx\@tempa\morecmidrules\vskip \cmidrulesep
    \global\@lastruleclass=\@ne\else
    \vskip \belowrulesep\global\@lastruleclass=\z@\fi\fi
    \ifnum0=`{\fi}}

\def\@cmidrulea{%
  \multispan\@cmidla&\multispan\@cmidlb
%%    \unskip\hskip \cmrkern@l\leaders\bktabrule{\@thisrulewidth}\hfill
    \unskip\hskip \cmrkern@l{%
    \CT@arc@\leaders\bktabrule{\@thisrulewidth}\hfill}%
    \hskip \cmrkern@r\cr}
\def\@cmidruleb{%
  \multispan\@cmidlb
%%    \unskip\hskip \cmrkern@l\leaders\bktabrule{\@thisrulewidth}\hfill
  \unskip\hskip \cmrkern@l{%
    \CT@arc@\leaders\bktabrule{\@thisrulewidth}\hfill}%
    \hskip \cmrkern@r\cr}

\def\morecmidrules{\noalign{\relax}}

%%%%%%%%%% end of Booktabs package code %%%%%%%%%%%%%%%%%%%%%

\newskip\ctableftskip \ctableftskip=\fill
\newskip\ctabrightskip \ctabrightskip=\fill

\expandafter\def\csname ctabular*\endcsname{%
  \@ifnextchar[ {\@ctabularstar}{\@ctabularstar[c]}}
\def\@ctabularstar[#1]#2{\global\@curtab\@ne
  \ctableftskip\fill
  \ctabrightskip\fill
  \if l#1% left
    \ctableftskip\z@
  \else
    \if r#1% right
       \ctabrightskip\z@
    \fi
  \fi
  \setlength\dimen@{#2}%
  \xdef\@halignto{to\the\dimen@}\NC@tabular}
\newcommand*{\ctabular}[1][c]{\global\@curtab\@ne
  \ctableftskip\fill
  \ctabrightskip\fill
  \if l#1% left
    \ctableftskip\z@
  \else
    \if r#1% right
      \ctabrightskip\z@
    \fi
  \fi
  \gdef\@halignto{to\hsize}\NC@tabular}

\newcommand*{\NC@tabular}{%
  \par
  \addvspace{\topsep}
  \col@sep\tabcolsep
  \let\d@llarbegin\begingroup
  \let\d@llarend\endgroup
  \@NCtabarray}

\newcommand*{\@NCialign}{\everycr{}\tabskip\ctableftskip\halign}

\newcommand*{\@NCtabarray}[1]{%
  \@tempdima \ht\strutbox
  \advance\@tempdima\extrarowheight
  \setbox \@arstrutbox \hbox{\vrule
    \@height \arraystretch \@tempdima
    \@depth \arraystretch \dp\strutbox
    \@width\z@}%
  \begingroup
%%    \@mkpream{@{\hspace{\@totalleftmargin}}#1@{}}%
    \@mkpream{#1}%
    \xdef\@preamble{\@NCialign \@halignto
                    \bgroup & \tabskip\z@
                      \@arstrut
                      \@preamble
                      \tabskip\ctabrightskip
                      \cr}%
  \endgroup
  \let\@sharp ##\let\protect\relax
  \lineskip\z@
  \baselineskip\z@
  \let\\\@arraycr
  \let\tabularnewline\\%
  \let\par\@empty
  \ctabsetlines
  \@preamble
}

\def\endctabular{%
  \crcr \egroup
  \gdef\@preamble{}%
  \addvspace{\topsep}
  \noindent}
\expandafter\let\csname endctabular*\endcsname=\endctabular

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand*{\pupcline}[2]{\p@p@cline[#1]#2\@nil}
\def\p@p@cline[#1]#2-#3\@nil{%
  \omit
  \@multicnt#2%
  \advance\@multispan\m@ne
  \ifnum\@multicnt=\@ne\@firstofone{&\omit}\fi
  \@multicnt#3%
  \advance\@multicnt-#2%
  \advance\@multispan\@ne
  \leaders\hrule\@height #1\hfill  % <- variable \@height value
  \cr
  \noalign{\vskip- #1}}            % <- variable \@height value

\newcommand*{\puphline}[1][\arrayrulewidth]{\pupcline{#1}{1-\@curtab}}
\newcommand*{\p@phline}{\cline{1-\@curtab}}
\def\p@p@BTnormal{%
  \ifnum0=`{\fi}   % closes the \noalign
  \multispan{\@curtab} \leaders\bktabrule{\@thisrulewidth}\hfill\cr
  \noalign{\ifnum0=`}\fi
  \futurenonspacelet\@tempa\@BTendrule}

\def\ctabsetlines{%
  \let\hline\p@phline
  \let\@BTnormal\p@p@BTnormal
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcount\abovecolumnspenalty
  \abovecolumnspenalty=10000
\newcount\@linestogo           % lines remaining to be procesed
\newcount\@cellstogo           % cells remaining in column or row
\newcount\@cellsincolumn         % number of lines per column
\newtoks\crtok
  \crtok = {\cr}%

\newdimen\@mincolumnwidth
\let\c@lleftskip\hfil   % left skip within a column
\let\c@lrightskip\hfil % right skip within a column

\let\preautotab\relax
\let\postautotab\relax

\newcommand{\autocols}[5][0pt]{\par\begingroup
  \ctabsetlines
  \if l#2
    \raggedright
  \else
    \if r#2
      \raggedleft
    \else
      \centering
    \fi
  \fi
  \let\c@lleftskip\hfil
  \let\c@lrightskip\hfil
  \if l#4
    \let\c@lleftskip\relax
  \else
    \if r#4
      \let\c@lrightskip\relax
    \fi
  \fi
  \@mincolumnwidth\z@
  \TX@cols=#3
  \@curtab=#3
  \@linestogo\z@
  \@for\@tempa:=#5\do{
    \advance\@linestogo\@ne
    \settowidth{\@tempdima}{\@tempa}
    \ifdim\@tempdima>\@mincolumnwidth
      \@mincolumnwidth=\@tempdima
    \fi
  }
  \advance\@mincolumnwidth\tabcolsep
  \linespercol
  \def\@endcolumnactions{%
    \global\advance\@linestogo\m@ne
    \ifnum\@cellstogo<\tw@
      \global\advance\TX@cols\m@ne
      \ifnum\TX@cols>\z@\linespercol\fi
      \the\crtok
    \else
        &\global\advance\@cellstogo\m@ne
    \fi
  }
  \ifdim #1 > \z@
    \TX@col@width=#1
    \divide\TX@col@width \TX@cols
  \else
    \TX@col@width=\@mincolumnwidth
  \fi
  \penalty\abovecolumnspenalty
  \noindent % usually not a paragraph
  \def\@preamble{}
  \begingroup
    \let\@sharp\relax
    \ifnum\@cellsincolumn>\@ne
      \loop
        \g@addto@macro{\@preamble}{%
          \hb@xt@ \TX@col@width{%
               \c@lleftskip\strut\@sharp\c@lrightskip} &}%
        \advance\@cellsincolumn\m@ne
      \ifnum\@cellsincolumn>\@ne
      \repeat
    \fi
    \g@addto@macro{\@preamble}{%
      \hb@xt@ \TX@col@width{\c@lleftskip\strut\@sharp\c@lrightskip}}%
  \endgroup
  \let\@sharp ##
  \tabskip\ctableftskip
%%  \tabskip\z@
  \valign \bgroup
    \tabskip\z@
    \@preamble
    \tabskip\ctabrightskip\cr
    \@for\@tempa:=#5\do{
      \@tempa\unskip\space\@endcolumnactions}%
    \the\crtok \egroup \par \endgroup
}

\newcommand*{\linespercol}{%
  \@cellsincolumn=\@linestogo
  \divide\@cellsincolumn \TX@cols
  \@cellstogo=\@cellsincolumn
  \multiply\@cellstogo \TX@cols
  \@tempcnta=\@linestogo
  \advance\@tempcnta -\@cellstogo
  \ifnum \@tempcnta>\z@
    \advance\@cellsincolumn \@ne
  \fi
  \global\@cellstogo=\@cellsincolumn
}

\newcommand{\autorows}[5][0pt]{\par\begingroup
 \ctabsetlines
  \ctableftskip\fill
  \ctabrightskip\fill
  \if l#2
    \ctableftskip\z@
  \else
    \if r#2
      \ctabrightskip\z@
    \fi
  \fi
  \let\c@lleftskip\hfil
  \let\c@lrightskip\hfil
  \if l#4
    \let\c@lleftskip\relax
  \else
    \if r#4
      \let\c@lrightskip\relax
    \fi
  \fi
  \TX@cols=#3\relax
  \@curtab=#3\relax
  \@cellstogo = \TX@cols
  \@mincolumnwidth\z@
  \@linestogo\z@
  \@for\@tempa:=#5\do{%
    \advance\@linestogo\@ne
    \settowidth{\@tempdima}{\@tempa}
    \ifdim\@tempdima>\@mincolumnwidth
      \@mincolumnwidth=\@tempdima
    \fi}%
  \advance\@mincolumnwidth\tabcolsep
  \def\@endcolumnactions{%
    \global\advance\@linestogo\m@ne
    \global\advance\@cellstogo\m@ne
    \ifnum\@cellstogo<\@ne
      \global\@cellstogo=\TX@cols
      \the\crtok
    \else
      &
    \fi}%
  \ifdim #1>\z@
    \TX@col@width=#1
  \else
    \TX@col@width=\hsize
  \fi
  \divide\TX@col@width \TX@cols
  \ifdim #1=\z@
    \TX@col@width=\@mincolumnwidth
  \fi
  \penalty\abovecolumnspenalty
  \noindent % usually not a paragraph
  \vskip -\z@ % don't know why we need this, but looks bad without it
  \def\@preamble{}
  \begingroup
    \let\@sharp\relax
    \ifnum\TX@cols>\@ne
      \loop
        \ifdim #1<\z@
          \g@addto@macro{\@preamble}{%
            \strut\c@lleftskip\@sharp\c@lrightskip &}%
        \else
          \g@addto@macro{\@preamble}{%
            \hb@xt@ \TX@col@width{%
                    \strut\c@lleftskip\@sharp\c@lrightskip} &}%
        \fi
        \advance\TX@cols\m@ne
      \ifnum\TX@cols>\@ne
      \repeat
    \fi
    \ifdim #1<\z@
      \g@addto@macro{\@preamble}{%
        \strut\c@lleftskip\@sharp\c@lrightskip}%
    \else
      \g@addto@macro{\@preamble}{%
        \hb@xt@ \TX@col@width{\strut\c@lleftskip\@sharp\c@lrightskip}}%
    \fi
  \endgroup
  \let\@sharp ##
  \tabskip\ctableftskip
  \halign to \hsize \bgroup
    \tabskip\z@
    \@preamble
%%    \tabskip\ctabrightskip\cr \preautotab
    \tabskip\ctabrightskip\cr
    \@for\@tempa:=#5\do{%
      \@tempa\unskip\space\@endcolumnactions}%
%%    \the\crtok \postautotab \the\crtok \egroup \endgroup \par
    \the\crtok \egroup \endgroup \par
}

\newcounter{newflo@tctr}
  \setcounter{newflo@tctr}{1}

\newcommand{\newfloat}[4][\@empty]{%
  \@namedef{ftype@#2}{\value{newflo@tctr}}
  \addtocounter{newflo@tctr}{\value{newflo@tctr}}
  \@ifundefined{c@#2}{% counter is not defined
    \ifx \@empty#1\relax
      \newcounter{#2}
    \else
      \newcounter{#2}[#1]
      \expandafter\edef\csname the#2\endcsname{%
  \expandafter\noexpand\csname the#1\endcsname.\noexpand\arabic{#2}}
    \fi}{}
  \setcounter{#2}{0}

  \@namedef{ext@#2}{#3}  % file extension
  \@ifundefined{c@#3depth}{\newcounter{#3depth}}{}
  \setcounter{#3depth}{1}

  \@namedef{fps@#2}{tbp}                     % position
  \@namedef{fnum@#2}{#4~\@nameuse{the#2}}    % caption naming
  \@namedef{fleg#2}{#4}                      % legend naming
  \@namedef{flegtoc#2}##1{}                  % legend name in ToC

  \newenvironment{#2}{\@float{#2}}{\end@float}
  \newenvironment{#2*}{\@dblfloat{#2}}{\end@dblfloat}
} % end \newfloat

\newcommand{\newsubfloat}[1]{%
  \newlistentry[#1]{sub#1}{\@nameuse{ext@#1}}{1}
  \@namedef{ext@sub#1}{\csname ext@#1\endcsname}
  \@namedef{thesub#1}{(\alph{sub#1})}
  \@namedef{@thesub#1}{\@nameuse{thesub#1}%
            \if@tightsubcap\hskip\subfloatlabelskip\else\space\fi}
  \@namedef{@@thesub#1}{\@nameuse{thesub#1}}
  \@namedef{p@sub#1}{\csname the#1\endcsname}
  \@namedef{toclevel@sub#1}{1}
}

\newif\ifdonemaincaption
  \donemaincaptionfalse

\let\@pupoldfloat\@float
\renewcommand{\@float}[1]{\donemaincaptionfalse
  \@ifundefined{c@sub#1}{}{\csname c@sub#1\endcsname = 0\relax}%
  \@pupoldfloat{#1}}
\let\@pupolddblfloat\@dblfloat
\renewcommand{\@dblfloat}[1]{\donemaincaptionfalse
  \@ifundefined{c@sub#1}{}{\csname c@sub#1\endcsname = 0\relax}%
  \@pupolddblfloat{#1}}

\let\@pupoldefloat\end@float
\def\end@float{%
  \@puplistsubcaptions{\@captype}\@pupoldefloat}
\let\@pupoldedblfloat\end@dblfloat
\def\end@dblfloat{%
  \@puplistsubcaptions{\@captype}\@pupoldedblfloat}

\AtBeginDocument{\@ifpackageloaded{fixltx2e}{%
  \def\end@dblfloat{%
    \if@twocolumn
      \@endfloatbox
      \ifnum\@floatpenalty<\z@
        \@largefloatcheck
        \global\dp\@currbox1sp %
        \@cons\@deferlist\@currbox
      \fi
      \ifnum\@floatpenalty=-\@Mii \@Esphack\fi
    \else
      \end@float
    \fi}}{}}

\newif\if@contcw
\newif\if@conthang
\newif\if@contindent

\newcommand{\captiondelim}[1]{\def\@contdelim{#1}}
\captiondelim{: }

\newcommand{\captionnamefont}[1]{\def\@contnfont{#1}}
\captionnamefont{}

\newcommand{\captiontitlefont}[1]{\def\@conttfont{#1}}
\captiontitlefont{}

\newcommand{\flushleftright}{%
  \leftskip\z@ \rightskip\z@
  \parfillskip=\z@ plus 1fil}
\newcommand{\centerlastline}{%
  \leftskip=\z@ plus 1fil
  \rightskip=\z@ plus -1fil
  \parfillskip=\z@ plus 2fil}

\newcommand{\captionstyle}[1]{\def\@contcstyle{#1}}
\captionstyle{}

\renewcommand{\captionstyle}{%
  \@ifnextchar[ {\@pupcshort}{\@pupcnorm}}
\def\@pupcshort[#1]#2{%
  \def\@contcshortstyle{#1}
  \def\@contcstyle{#2}}
\def\@pupcnorm#1{%
  \def\@contcshortstyle{#1}
  \def\@contcstyle{#1}}
\captionstyle{}

\newlength{\@contcwidth}
\newcommand{\captionwidth}[1]{\setlength{\@contcwidth}{#1}}
\captionwidth{\linewidth}
\newcommand{\changecaptionwidth}{\@contcwtrue}
\newcommand{\normalcaptionwidth}{\@contcwfalse}
\normalcaptionwidth

\newlength{\@contindw}
\newcommand{\hangcaption}{\@conthangtrue\@contindentfalse}
\newcommand{\indentcaption}[1]{\setlength{\@contindw}{#1}%
  \@conthangfalse\@contindenttrue}
\newcommand{\normalcaption}{\@conthangfalse\@contindentfalse}
\normalcaption

\newcommand{\precaption}[1]{\def\@contpre{#1}}
\precaption{}
\newcommand{\postcaption}[1]{\def\@contpost{#1}}
\postcaption{}
\newcommand{\midbicaption}[1]{\def\@contmidbi{#1}}
\midbicaption{}

\newlength{\abovecaptionskip}
  \setlength{\abovecaptionskip}{0.5\onelineskip}
\newlength{\belowcaptionskip}
  \setlength{\belowcaptionskip}{0.5\onelineskip}

\let\@pupoldcaption\caption
\def\caption{\donemaincaptiontrue\@pupoldcaption}

\newcommand*{\pupcaptioninfo}[4]{}

\let\@pupold@caption\@caption
\long\def\@caption#1[#2]#3{%
  \M@gettitle{#2}%
  \pupcaptioninfo{#1}{\csname the#1\endcsname}{#2}{#3}%
  \@pupold@caption{#1}[{#2}]{#3}}

\long\def\@makecaption#1#2{\let\@puptempa\relax
  \ifdim\prevdepth>-99\p@ \vskip\abovecaptionskip
  \else \def\@puptempa{\vbox to\topskip{}}\fi
  \let\@contfnote\footnote \renewcommand{\footnote}[2][]{}
  \let\@contfmark\footnotemark \renewcommand{\footnotemark}[1][]{}
  \sbox\@tempboxa{\@contnfont #1\@contdelim \@conttfont #2}
  \let\footnote\@contfnote
  \let\footnotemark\@contfmark
  \ifdim\wd\@tempboxa<\linewidth \centering \fi
  \if@contcw
    \centering
    \parbox{\@contcwidth}{%
    \ifdim\wd\@tempboxa<\@contcwidth \centering \fi
  \fi
  \if@conthang
    \sbox\@tempboxa{\@contnfont #1\@contdelim}
    \@contpre%
    {\@contcstyle\hangindent=\wd\@tempboxa
     \noindent\box\@tempboxa\@puptempa \@conttfont #2\par}
  \else
    \if@contindent
      \@contpre%
      {\@contnfont #1\@contdelim}\@puptempa
      {\@contcstyle\hangindent=\@contindw
                   \hangafter=\@ne\@conttfont #2\par}% <- v1.4
    \else
      \@contpre%
      {\@contnfont #1\@contdelim}\@puptempa
      {\ifdim\wd\@tempboxa<\linewidth
         \@contcshortstyle\else \@contcstyle\fi%  <- v1.4
       \@conttfont #2\par}
    \fi
  \fi
  \@contpost
  \if@contcw
    \par
    }  % end of the \parbox
  \fi
  \vskip\belowcaptionskip}

\newcommand{\contcaption}{%
  \addtocounter{\@captype}{\m@ne}\refstepcounter{\@captype}%
  \@contcaption\@captype}

\long\def\@@contcaption#1#2{%
  \par
  \begingroup
     \@parboxrestore
     \if@minipage
       \@setminipage
     \fi
     \normalsize
     \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #2}\par
  \endgroup}

\long\def\@contcaption#1#2{%
  \if@contbotsub
    \@puplistsubcaptions{#1}%
    \@@contcaption{#1}{#2}%
  \else
    \@@contcaption{#1}{#2}%
    \@puplistsubcaptions{#1}%
  \fi}

\newcommand*{\puplegendinfo}[1]{}
\newcommand{\legend}[1]{%
  \M@gettitle{#1}%
  \puplegendinfo{#1}%
  \par
  \begingroup
     \@parboxrestore
     \if@minipage
       \@setminipage
     \fi
     \normalsize
     \captiondelim{\mbox{}}
     \@makecaption{}{\ignorespaces #1}\par
  \endgroup}

\newcommand{\namedlegend}{\@dblarg{\@legend\@captype}}
\newcommand*{\pupnamedlegendinfo}[3]{}

\long\def\@legend#1[#2]#3{%
  \M@gettitle{#2}%
  \pupnamedlegendinfo{#1}{#2}{#3}%
  \par
  \csname flegtoc#1\endcsname{#2}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption{\csname fleg#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\newcommand{\newfixedcaption}[3][\caption]{%
  \newcommand{#2}{\def\@captype{#3}#1}}
\newcommand{\renewfixedcaption}[3][\caption]{%
  \renewcommand{#2}{\def\@captype{#3}#1}}
\newcommand{\providefixedcaption}[3][\caption]{%
  \providecommand{#2}{\def\@captype{#3}#1}}

\newcommand*{\pupbitwonumcaptioninfo}[7]{}
\newcommand*{\pupbionenumcaptioninfo}[7]{}
\newcommand*{\pupbicaptioninfo}[6]{}

\newcommand{\bitwonumcaption}[6][\@empty]{%
  \begingroup
  \let\pupcaptioninfo\@gobblefour
  \@ifmtarg{#2}{\def\p@pscapi{#3}\caption{#3}}%
               {\def\p@pscapi{#2}\caption[#2]{#3}}%
  \ifx \@empty #1\else
    \label{#1}%
  \fi
  \setlength{\abovecaptionskip}{0pt}%
  \setlength{\belowcaptionskip}{0pt}%
  \edef\@puptempc{#4}%
  \expandafter\renewcommand\csname \@captype name\endcsname{\@puptempc}%
  \addtocounter{\@captype}{-1}%
  \@contmidbi
  \@ifmtarg{#5}{\def\p@pscapii{#6}\caption{#6}}%
               {\def\p@pscapii{#5}\caption[#5]{#6}}%
  \pupbitwonumcaptioninfo{\@captype}{\@nameuse{the\@captype}}%
                         {\p@pscapi}{#3}{#4}{\p@pscapii}{#6}%
  \endgroup
}

\newcommand{\bionenumcaption}[6][\@empty]{%
  \begingroup
  \let\pupcaptioninfo\@gobblefour
  \@ifmtarg{#2}{\def\p@pscapi{#3}\caption{#3}}%
               {\def\p@pscapi{#2}\caption[#2]{#3}}%
  \ifx \@empty #1\else
    \label{#1}%
  \fi
  \setlength{\abovecaptionskip}{0pt}%
  \setlength{\belowcaptionskip}{0pt}%
  \edef\@puptempc{#4}%
  \expandafter\renewcommand\csname \@captype name\endcsname{\@puptempc}
  \@contmidbi
  \contcaption{#6}%
  \@ifmtarg{#5}{%
    \def\p@pscapii{#6}%
    \addcontentsline{\csname ext@\@captype\endcsname}{\@captype}%
      {\protect\numberline{}{\ignorespaces #6}}}{%
    \def\p@pscapii{#5}%
    \addcontentsline{\csname ext@\@captype\endcsname}{\@captype}%
      {\protect\numberline{}{\ignorespaces #5}}}%
  \pupbionenumcaptioninfo{\@captype}{\@nameuse{the\@captype}}%
                         {\p@pscapi}{#3}{#4}{\p@pscapii}{#6}%
  \endgroup
}

\newcommand{\bicaption}[5][\@empty]{%
  \begingroup
  \let\pupcaptioninfo\@gobblefour
  \@ifmtarg{#2}{\def\p@pscapi{#3}\caption{#3}}%
               {\def\p@pscapi{#2}\caption[#2]{#3}}%
  \ifx \@empty #1\else
    \label{#1}%
  \fi
  \setlength{\abovecaptionskip}{0pt}%
  \setlength{\belowcaptionskip}{0pt}%
  \edef\@puptempc{#4}
  \expandafter\renewcommand\csname \@captype name\endcsname{\@puptempc}%
  \@contmidbi
  \contcaption{#5}%
  \pupbicaptioninfo{\@captype}{\@nameuse{the\@captype}}%
                   {\p@pscapi}{#3}{#4}{#5}%
  \endgroup
}

\newcommand{\bicontcaption}[3]{%
  \begingroup
  \contcaption{#1}%
  \setlength{\abovecaptionskip}{0pt}%
  \setlength{\belowcaptionskip}{0pt}%
  \edef\@puptempc{#2}%
  \expandafter\renewcommand\csname \@captype name\endcsname{\@puptempc}%
  \@contmidbi
  \contcaption{#3}%
  \endgroup
}

\newcommand{\subcaptionstyle}[1]{\def\@contsubcstyle{#1}}
\subcaptionstyle{}

\newif\if@shortsubcap
\newif\if@hangsubcap
\newcommand*{\shortsubcaption}{\@shortsubcaptrue}
\newcommand*{\hangsubcaption}{\@hangsubcaptrue}
\newcommand*{\normalsubcaption}{\@shortsubcapfalse\@hangsubcapfalse}
\normalsubcaption

\newskip\subfloattopskip
\newskip\subfloatcapskip
\newskip\subfloatcaptopadj
\newskip\subfloatbottomskip
\newskip\subfloatlabelskip
\newdimen\subfloatcapmargin
\newif\if@tightsubcap
\newcommand{\loosesubcaptions}{%
  \subfloattopskip = 10\p@
  \subfloatcapskip  = 10\p@
  \subfloatcaptopadj = \z@
  \subfloatbottomskip = 10\p@
  \subfloatlabelskip = 0.33em
  \subfloatcapmargin = 10\p@
  \@tightsubcapfalse
}

\newcommand{\tightsubcaptions}{%
  \subfloattopskip = 5\p@
  \subfloatcapskip  = \z@
  \subfloatcaptopadj = 3\p@
  \subfloatbottomskip = 5\p@
  \subfloatlabelskip = 0.33em \@plus 0.07em \@minus 0.03em
  \subfloatcapmargin = \z@
  \@tightsubcaptrue
}
\tightsubcaptions

\newcommand*{\subcaptionsize}[1]{\def\@subcapsize{#1}}
\newcommand*{\subcaptionlabelfont}[1]{\def\@subcaplabelfont{#1}}
\newcommand*{\subcaptionfont}[1]{\def\@subcapfont{#1}}
\subcaptionsize{\footnotesize}
\subcaptionlabelfont{\normalfont}
\subcaptionfont{\normalfont}

  \newcounter{@contsubnum}
  \newcommand{\@contkeep}{%
    \setcounter{@contsubnum}{\value{sub\@captype}}}
  \newcommand{\@contset}{%
    \setcounter{sub\@captype}{\value{@contsubnum}}}
  \newcommand{\subconcluded}{%
    \setcounter{sub\@captype}{0}}
\newif\if@contbotsub
  \@contbotsubtrue

\newcommand{\subcaption}{%
  \bgroup
    \let\label=\pupsub@label
    \ifdonemaincaption\else
      \advance\csname c@\@captype\endcsname\@ne
    \fi
    \refstepcounter{sub\@captype}\@contkeep
    \@ifnextchar [%
      {\@pupsubcap{sub\@captype}}%
      {\@pupsubcap{sub\@captype}[\@empty]}}
\long\def\@pupsubcap#1[#2]#3{%
  \@tempdima=\hsize
  \vskip\subfloatcapskip
  \ifx \@empty #2
    \@pupsubcaption{#1}{#3}{#3}%
  \else
    \@pupsubcaption{#1}{#2}{#3}%
  \fi
  \vskip\subfloatcapskip
  \egroup}
\newcommand{\@pupsubcaption}[3]{%
  \ifx \relax#2\relax \else
    \bgroup
      \let\label\@gobble
      \let\protect\string
      \def\@pupsubcaplabel{\@nameuse{@@the#1}}%
      \xdef\@pupsubfigcaptionlist{%
        \@pupsubfigcaptionlist,%
  {\protect\numberline{\@pupsubcaplabel}\noexpand{\ignorespaces #2}}}%
    \egroup
  \fi
  \@makesubfloatcaption{\@nameuse{@the#1}}{#3}}

\newcommand{\contsubcaption}{%
  \bgroup
    \let\label=\pupsub@label
    \@contset
    \refstepcounter{sub\@captype}\@contkeep
    \@ifnextchar [%
      {\@pupsubcap{sub\@captype}}%
      {\@pupsubcap{sub\@captype}[\@empty]}}
\newenvironment{subfloat}{}{}

\newcommand{\subbottom}{%
  \@contbotsubtrue
  \@pupsubbody}

\newcommand{\@pupsubbody}{%
  \bgroup
  \let\label=\pupsub@label
  \ifdonemaincaption\else
    \advance\csname c@\@captype\endcsname\@ne
  \fi
  \refstepcounter{sub\@captype}\@contkeep%
  \leavevmode
  \@ifnextchar [%
    {\@pupsubfig}%
    {\@pupsubfig[\@empty]}}

\newcommand{\contsubbottom}{%
  \@contbotsubtrue
  \@pupcontsubbody}

\newcommand{\@pupcontsubbody}{%
  \bgroup
  \let\label=\pupsub@label
  \@contset
  \refstepcounter{sub\@captype}\@contkeep%
  \leavevmode
  \@ifnextchar [%
    {\@pupsubfig}%
    {\@pupsubfig[\@empty]}}

\newcommand{\subtop}{%
  \@contbotsubfalse
  \@pupsubbody}

\newcommand{\contsubtop}{%
  \@contbotsubfalse
  \@pupcontsubbody}

\def\@pupsubfig[#1]{%
  \@ifnextchar [%
    {\@pupsubfloat{sub\@captype}[#1]}%
    {\@pupsubfloat{sub\@captype}[\@empty #1][#1]}}

\def\@pupsubfloat#1[#2][#3]#4{%
  \@tempcnta=\@ne
  \if@tightsubcap
    \if@minipage
      \@tempcnta=\z@
    \else
      \ifdim\lastskip=\z@
        \@tempcnta=\@ne
      \else
        \@tempcnta=\tw@
      \fi
    \fi
  \fi
  \if@contbotsub
    \def\subfig@top{\subfloattopskip}%
    \def\subfig@bottom{\subfloatbottomskip}%
  \else
    \def\subfig@top{\subfloatbottomskip}%
    \def\subfig@bottom{\subfloattopskip}%
  \fi
  \setbox\@tempboxa \hbox{#4}%
  \@tempdima=\wd\@tempboxa
  \vtop\bgroup
    \vbox\bgroup
    \ifcase\@tempcnta
      \@minipagefalse
    \or
      \vspace{\subfig@top}
    \or
      \ifdim \lastskip=\z@ \else
        \@tempskipb\subfig@top\@xaddvskip
      \fi
    \fi
    \if@contbotsub
      \box\@tempboxa\egroup
      \ifx \@empty#3\relax \else
        \vskip\subfloatcapskip
        \@pupsubcaption{#1}{#2}{#3}%
      \fi
    \else
      \ifx \@empty#3\relax \else
        \@pupsubcaption{#1}{#2}{#3}%
        \vskip\subfloatcapskip
        \vskip\subfloatcaptopadj
      \fi\egroup
      \box\@tempboxa
    \fi
    \vspace{\subfig@bottom}
  \egroup
\egroup}

\newcommand*{\@pupsubfigcaptionlist}{}
\newcommand*{\puplistsubcaptions}{%
  \@ifstar
    {\gdef\@pupsubfigcaptionlist{}}%
    {\@puplistsubcaptions{\@captype}}}

\newcommand*{\@puplistsubcaptions}[1]{%
  \@ifundefined{@captype}{}{%
    \@ifundefined{ext@sub#1}{}{%
      \@for \@tempa:=\@pupsubfigcaptionlist \do {%
        \ifx \@empty\@tempa\relax \else
          \addcontentsline{\@nameuse{ext@sub#1}}{sub#1}{\@tempa}%
        \fi}}}%
  \gdef\@pupsubfigcaptionlist{}}

\newcommand{\@makesubfloatcaption}[2]{%
  \setbox\@tempboxa\hbox{%
    \@subcapsize
    {\@subcaplabelfont #1}{\@subcapfont\ignorespaces #2}}%
  \@tempdimb=-\subfloatcapmargin
  \multiply\@tempdimb\tw@
  \advance\@tempdimb\@tempdima
  \hb@xt@\@tempdima{%
    \hss
    \ifdim \wd\@tempboxa >\@tempdimb
      \pupsubfig@caption{#1}{#2}%
    \else
      \if@shortsubcap
        \pupsubfig@caption{#1}{#2}%
      \else
        \box\@tempboxa
      \fi
    \fi
    \hss}}

\newcommand{\pupsubfig@caption}[2]{%
  \if@hangsubcap
    \sbox{\@tempboxa}{\@subcapsize\@subcaplabelfont #1}%
    \addtolength{\@tempdimb}{-\wd\@tempboxa}%
    \usebox{\@tempboxa}%
    \pupsubfig@captionpar{\@tempdimb}{%
      {\@subcapfont\ignorespaces #2}}%
  \else
    \pupsubfig@captionpar{\@tempdimb}{{\@subcaplabelfont #1}%
      {\@subcapfont\ignorespaces #2}}%
  \fi}

\newcommand{\pupsubfig@captionpar}[2]{%
  \parbox[t]{#1}{\@subcapsize\@contsubcstyle #2}}

\newcommand{\pupsub@label}{%
  \@ifnextchar (%
    {\sf@pupsub@label}%
    {\sf@pupsub@label(Sub\@captype\space
                     \@nameuse{p@sub\@captype}%
                     \@nameuse{thesub\@captype})}}
\def\sf@pupsub@label(#1)#2{%
  \protected@edef\pup@currentlabelname{#1}%
  \sf@@pupsub@label{#2}}

\AtBeginDocument{%
  \@ifpackageloaded{nameref}{%
    \newcommand*{\sf@@pupsub@label}[1]{%
      \@bsphack
      \protected@write\@auxout{}{%
        \string\newlabel{#1}%
          {{\@nameuse{p@sub\@captype}\@nameuse{@@thesub\@captype}}%
          {\thepage}%
          {\pup@currentlabelname\relax}%
          {\@currentHref}{}}}%
      \protected@write\@auxout{}{%
        \string\newlabel{sub@#1}%
          {{\@nameuse{@@thesub\@captype}}%
          {\thepage}%
          {\pup@currentlabelname\relax}%
          {\@currentHref}{}}}%
  \@esphack}
  }{\@ifpackageloaded{hyperref}{%
    \newcommand*{\sf@@pupsub@label}[1]{%
      \@bsphack
      \protected@write\@auxout{}{%
        \string\newlabel{#1}%
          {{\@nameuse{p@sub\@captype}\@nameuse{@@thesub\@captype}}%
          {\thepage}%
          {\pup@currentlabelname\relax}%
          {\@currentHref}{}}}%
      \protected@write\@auxout{}{%
        \string\newlabel{sub@#1}%
          {{\@nameuse{@@thesub\@captype}}%
          {\thepage}%
          {\pup@currentlabelname\relax}%
          {\@currentHref}{}}}%
  \@esphack}
  }{%
    \let\@pupoldlabel\label
    \newcommand*{\sf@@pupsub@label}[1]{%
      \@bsphack
      \@pupoldlabel{#1}%
      \protected@write\@auxout{}{%
        \string\newlabel{sub@#1}%
          {{\@nameuse{@@thesub\@captype}}%
          {\thepage}}}%
  \@esphack}
  }{}%
  }
}

\newcommand*{\subcaptionref}{%
  \@ifstar{\ssc@ref}{\sc@ref}}
\newcommand*{\ssc@ref}[1]{\ref{sub@#1}}
\newcommand*{\sc@ref}[1]{{\@subcaplabelfont\ref{sub@#1}}}

\newlength{\beforeepigraphskip}
  \setlength{\beforeepigraphskip}{.5\baselineskip}
\newlength{\afterepigraphskip}
  \setlength{\afterepigraphskip}{.5\baselineskip}
\newlength{\epigraphwidth}
  \setlength{\epigraphwidth}{.4\textwidth}
\newlength{\epigraphrule}
  \setlength{\epigraphrule}{.4\p@}
\newcommand{\epigraphsize}{\small}
\newcommand{\epigraphflush}{flushright}
\newcommand{\textflush}{flushleft}
\newcommand{\sourceflush}{flushright}
\newcommand{\epigraphfontsize}[1]{\def\epigraphsize{#1}}
\newcommand{\epigraphposition}[1]{\long\def\epigraphflush{#1}}
\newcommand{\epigraphtextposition}[1]{\def\textflush{#1}}
\newcommand{\epigraphsourceposition}[1]{\def\sourceflush{#1}}

\newcommand{\@epirule}{\rule[.5ex]{\epigraphwidth}{\epigraphrule}}
\newcommand{\@epitext}[1]{%
  \begin{minipage}{\epigraphwidth}\begin{\textflush} #1\\
    \ifdim\epigraphrule>\z@ \@epirule \else \vspace*{1ex} \fi
  \end{\textflush}\end{minipage}}
\newcommand{\@episource}[1]{%
  \begin{minipage}{\epigraphwidth}
    \begin{\sourceflush} #1\end{\sourceflush}
  \end{minipage}}
\newcommand{\epigraph}[2]{\vspace{\beforeepigraphskip}
  {\epigraphsize\begin{\epigraphflush}\begin{minipage}{\epigraphwidth}
    \@epitext{#1}\\ \@episource{#2}
    \end{minipage}\end{\epigraphflush}
    \vspace{\afterepigraphskip}}}
\newcommand{\qitem}[2]{{%
  \raggedright\item \begin{minipage}{\epigraphwidth}
    \@epitext{#1}\\ \@episource{#2}
  \end{minipage}}}
\newcommand{\qitemlabel}[1]{\hfill}
\newenvironment{epigraphs}{%
  \vspace{\beforeepigraphskip}\begin{\epigraphflush}
  \epigraphsize
  \begin{minipage}{\epigraphwidth}
   \list{}%
    {\itemindent\z@ \labelwidth\z@ \labelsep\z@
     \leftmargin\z@ \rightmargin\z@
     \let\makelabel\qitemlabel}}%
  {\endlist\end{minipage}\end{\epigraphflush}
   \vspace{\afterepigraphskip}}
\newcommand{\dropchapter}[1]{%
  \let\@epichapapp\@chapapp
  \renewcommand{\@chapapp}{\vspace*{#1}\@epichapapp}}
\newcommand{\undodrop}{\let\@chapapp\@epichapapp}
\newif\if@epirhs     \@epirhstrue
\newif\if@epicenter  \@epicentertrue
\newcommand{\@epipos}{
  \long\def\@ept{flushleft}
  \ifx\epigraphflush\@ept
    \@epirhsfalse \@epicenterfalse
  \else
    \long\def\@ept{center}
    \ifx\epigraphflush\@ept
      \@epirhsfalse \@epicentertrue
    \else
      \@epirhstrue  \@epicenterfalse
    \fi
  \fi}
\newcommand{\epigraphhead}[2][95]{%
  \def\@epitemp{\begin{minipage}{\epigraphwidth}#2\end{minipage}}
  \def\ps@epigraph{\let\@mkboth\@gobbletwo
    \@epipos
    \if@epirhs
      \def\@oddhead{\hfil\begin{picture}(0,0)
                         \put(0,-#1){\makebox(0,0)[r]{\@epitemp}}
                         \end{picture}}
    \else
      \if@epicenter
        \def\@oddhead{\hfil\begin{picture}(0,0)
                           \put(0,-#1){\makebox(0,0)[b]{\@epitemp}}
                           \end{picture}\hfil}
      \else
        \def\@oddhead{\begin{picture}(0,0)
                           \put(0,-#1){\makebox(0,0)[l]{\@epitemp}}
                           \end{picture}\hfil}
      \fi
    \fi
    \let\@evenhead\@oddhead
    \def\@oddfoot{\reset@font\hfil\thepage\hfil}
    \let\@evenfoot\@oddfoot}
  \thispagestyle{epigraph}}

\newcommand{\the@epigraph}{}
\newcommand{\@epidrop}{95}
\newcommand{\epigraphforheader}[2][95]{%
  \def\@epidrop{#1}\long\def\the@epigraph{#2}}

\newcommand{\epigraphpicture}{%
  \def\@epitemp{%
    \begin{minipage}{\epigraphwidth}\the@epigraph\end{minipage}}%
  \@epipos
  \if@epirhs
    \begin{picture}(0,0)%
      \put(0,-\@epidrop){\makebox(0,0)[r]{\@epitemp}}%
    \end{picture}%
  \else
    \if@epicenter
      \begin{picture}(0,0)%
        \put(0,-\@epidrop){\makebox(0,0)[b]{\@epitemp}}%
      \end{picture}%
    \else
      \begin{picture}(0,0)%
        \put(0,-\@epidrop){\makebox(0,0)[l]{\@epitemp}}%
      \end{picture}%
    \fi
  \fi}

\newenvironment{bookepigraph}{\normalsize\parindent0pt\sffamily\thispagestyle{empty}\vspace*{5.75pc}\advance\leftskip4.25pc}{\par}
\newcommand{\epigraphsource}[1]{\vskip.5\baselineskip#1\par}

\newcommand*{\@pupoldfonterr}[3]{%
  \@puperror{Font command \protect#1\space is not supported}{%
    Use \protect#2, or \protect#3{...}, or the oldfontcommands option}}
\newcommand*{\@pupoldfontwarn}[3]{%
  \@pupwarn{The \protect#1\space font command is deprecated.
    \MessageBreak Use \protect#2{...} or {\protect#3... } instead}}

\if@pupoldfont
  \def\@pup@rmwarn{\@pupoldfontwarn{\rm}{\textrm}{\rmfamily}}
  \DeclareOldFontCommand{\rm}{\@pup@rmwarn\gdef\@pup@rmwarn{}%
    \normalfont\rmfamily}{\mathrm}
\else
  \def\rm{\@pupoldfonterr{\rm}{\textrm}{\rmfamily}}
\fi

\if@pupoldfont
  \def\@pup@sfwarn{\@pupoldfontwarn{\sf}{\textsf}{\sffamily}}
  \DeclareOldFontCommand{\sf}{\@pup@sfwarn\gdef\@pup@sfwarn{}%
    \normalfont\sffamily}{\mathsf}
\else
  \def\sf{\@pupoldfonterr{\sf}{\textsf}{\sffamily}}
\fi

\if@pupoldfont
  \def\@pup@ttwarn{\@pupoldfontwarn{\tt}{\texttt}{\ttfamily}}
  \DeclareOldFontCommand{\tt}{\@pup@ttwarn\gdef\@pup@ttwarn{}%
    \normalfont\ttfamily}{\mathtt}
\else
  \def\tt{\@pupoldfonterr{\tt}{\texttt}{\ttfamily}}
\fi

\if@pupoldfont
  \def\@pup@bfwarn{\@pupoldfontwarn{\bf}{\textbf}{\bfseries}}
  \DeclareOldFontCommand{\bf}{\@pup@bfwarn\gdef\@pup@bfwarn{}%
    \normalfont\bfseries}{\mathbf}
\else
  \def\bf{\@pupoldfonterr{\bf}{\textbf}{\bfseries}}
\fi

\if@pupoldfont
  \def\@pup@itwarn{\@pupoldfontwarn{\it}{\textit}{\itshape}}
  \DeclareOldFontCommand{\it}{\@puppup@itwarn\gdef\@pup@itwarn{}%
    \normalfont\itshape}{\mathit}
\else
  \def\it{\@pupoldfonterr{\it}{\textit}{\itshape}}
\fi

\if@pupoldfont
  \def\@pup@slwarn{\@pupoldfontwarn{\sl}{\textsl}{\slshape}}
  \DeclareOldFontCommand{\sl}{\@pup@slwarn\gdef\@pup@slwarn{}%
    \normalfont\slshape}{\@nomath\sl}
\else
  \def\sl{\@pupoldfonterr{\sl}{\textsl}{\slshape}}
\fi

\if@pupoldfont
  \def\@pup@scwarn{\@pupoldfontwarn{\sc}{\textsc}{\scshape}}
  \DeclareOldFontCommand{\sc}{\@pup@scwarn\gdef\@pup@scwarn{}%
    \normalfont\scshape}{\@nomath\sc}
\else
  \def\sc{\@pupoldfonterr{\sc}{\textsc}{\scshape}}
\fi

\if@pupoldfont
  \def\@pup@calwarn{%
    \@pupwarn{The \protect\cal\space font command is deprecated.
    \MessageBreak Try to use \protect\mathcal\space instead}}
  \DeclareRobustCommand*\cal{\@pup@calwarn\gdef\@pup@calwarn{}%
    \@fontswitch\relax\mathcal}
\else
  \def\cal{%
    \@puperror{Font command \protect\cal\space is not supported}{%
    Use \protect\mathcal, or the oldfontcommands option}}
\fi

\if@pupoldfont
  \def\@mep@pitwarn{%
    \@pupwarn{The \protect\mit\space font command is deprecated.
    \MessageBreak Try to use \protect\mathnormal\space instead}}
  \DeclareRobustCommand*\mit{\@mep@pitwarn\gdef\@mep@pitwarn{}%
    \@fontswitch\relax\mathnormal}
\else
  \def\mit{%
  \@puperror{Font command \protect\mit\space is not supported}{%
             Use \protect\mathnormal, or the oldfontcommands option}}
\fi

\DeclareRobustCommand{\em}{%
  \@nomath\em
  \ifdim\fontdimen\@ne\font > \z@
    \eminnershape
  \else
    \itshape
  \fi}
\providecommand{\eminnershape}{\upshape}
\DeclareTextFontCommand{\emph}{\em}

\newcommand{\fref}[1]{\figurerefname~\ref{#1}}
\newcommand{\tref}[1]{\tablerefname~\ref{#1}}
\newcommand{\pref}[1]{\pagerefname~\pageref{#1}}
\newcommand{\Pref}[1]{\partrefname\ref{#1}}
\newcommand{\Cref}[1]{\chapterrefname\ref{#1}}
\newcommand{\Sref}[1]{\sectionrefname\ref{#1}}

\newif\ifheadnameref
  \headnamereffalse

\newcommand{\theTitleReference}[2]{#2}

\let\@pup@old@label\label
\def\label#1{\@bsphack\begingroup
  \protected@edef\@currentlabel{\protect\M@TitleReference
      {\@currentlabel}{\M@currentTitle}}%
  \@pup@old@label{#1}%
  \endgroup \@esphack}%

\def\@pup@@gettitle#1{\begingroup \let\protect\@unexpandable@protect
    \let\label\@pup@nestwarn
    \let\index\@gobble \let\glossary\@gobble
    \let\markboth\@gobbletwo \let\@mkboth\@gobbletwo
    \let\markright\@gobble
    \edef\@tempa{\noexpand\def\noexpand\M@currentTitle{#1}}%
  \expandafter\endgroup\@tempa}

\let\@pup@nestwarn\@gobble
\let\M@TitleReference\@firstoftwo

\DeclareRobustCommand{\titleref}[1]{\begingroup \let\numberline\@gobble
  \let\M@TitleReference\@pup@theTR % interrupt recursion of \ref
  \ref{#1}\endgroup}
\DeclareRobustCommand{\currenttitle}{\begingroup \let\numberline\@gobble
  \theTitleReference\@currentlabel\M@currentTitle\endgroup}

\let\M@currentTitle\@empty

\def\@pup@theTR{\let\M@TitleReference\@firstoftwo \theTitleReference}

\newcommand*{\namerefon}{\let\M@gettitle\@pup@@gettitle}
\newcommand*{\namerefoff}{\let\M@gettitle\@gobble}
  \namerefon
\let\M@old@caption\@caption
\long\def\@caption#1[#2]#3{\M@gettitle{#2}\M@old@caption{#1}[{#2}]{#3}}

\let\M@oldlegend\legend
\long\def\legend#1{\M@gettitle{#1}\M@oldlegend{#1}}
\let\M@old@legend\@legend
\long\def\@legend#1[#2]#3{\M@gettitle{#2}\M@old@legend{#1}[{#2}]{#3}}

\let\M@old@vsptitle\@vsptitle
\long\def\@vsptitle[#1]#2{\M@gettitle{#1}\M@old@vsptitle[{#1}]{#2}}
\let\M@old@vssptitle\@vssptitle
\long\def\@vssptitle#1{\M@gettitle{#1}\M@old@vssptitle{#1}}

%%%\let\M@old@spart\@spart
%%%\def\@spart#1{\M@gettitle{#1}\M@old@spart{#1}}
%%%\let\M@old@part\@part
%%%\def\@part[#1]{\M@gettitle{#1}\M@old@part[{#1}]}


\newcommand{\@pnumwidth}{1.85em}
\newcommand{\@tocrmarg} {2.55em}
\newcommand{\@dotsep}{4.5}
\newlength{\tocentryskip} \setlength{\tocentryskip}{1em}
\newlength{\tocbaseline} \setlength{\tocbaseline}{20pt}
\newcommand{\tocskip}[1]{%
    \addtocontents{toc}{\protect\vspace{#1}}}
\newcommand*{\ensureonecol}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi}
\newcommand*{\restorefromonecol}{\if@restonecol\twocolumn\fi}

\newlength{\cftparskip}
\setlength{\cftparskip}{0pt}

\newcommand{\newlistof}[3]{%
  \@namedef{ext@#2}{#2}
  \@ifundefined{c@#2depth}{\newcounter{#2depth}}{}
  \setcounter{#2depth}{1}
  \@namedef{#2mark}{\markboth{#3}{#3}}
  \@namedef{#1}{\@ifstar{\@nameuse{@star#2}}{\@nameuse{@plain#2}}}
  \@namedef{@star#2}{%
    \ensureonecol
    \par
    \begingroup
%%%      \parindent\z@ \parskip\cftparskip
      \@nameuse{@#2maketitle}
      \@starttoc{#2}%
    \endgroup
    \restorefromonecol}
  \@namedef{@plain#2}{%
    \ensureonecol
    \par
    \begingroup
%%%      \parindent\z@ \parskip\cftparskip
      \@nameuse{@#2maketitle}
      \phantomsection
      \addcontentsline{toc}{chapter}{#3}
      \@starttoc{#2}%
    \endgroup
    \restorefromonecol}
  \@namedef{@#2maketitle}{%
    \@nameuse{#2headstart}
   {\parindent\z@ \parskip\cftparskip
    \interlinepenalty\@M
    \@nameuse{print#2nonum}%
    \@nameuse{print#2title}{#3}%
    \@nameuse{#2mark}%
    \thispagestyle{chapter}%
    \@nameuse{after#2title}
   }
    \@afterheading}
  \@namedef{#2headstart}{\chapterheadstart}
  \@namedef{after#2title}{\afterchaptertitle}
  \@namedef{print#2nonum}{\printchapternonum}
  \@namedef{print#2title}##1{\printchaptertitle{##1}}
} % end \newlistof

\renewcommand{\@starttoc}[1]{%
  \begingroup\makeatletter
    \@input{\jobname.#1}%
    \if@filesw
      \AtEndDocument{%
        \expandafter\newwrite\csname tf@#1\endcsname
        \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax
      }%
    \fi
  \@nobreakfalse
  \endgroup}

\newcommand{\tableofcontents}{%
\clearpage\if@twoside 
\ifodd\c@page\else
    \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
  \columnseprule \z@
  \columnsep 35\p@
  \chapter*{\contentsname}
  \addtocontents{toc}{\relax}%
\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
 \@starttoc{toc}%
 \cleartorecto
 \noindent\ignorespaces}
{\if@restonecol\onecolumn\else\clearpage\fi}


\newcommand{\setpnumwidth}[1]{\renewcommand{\@pnumwidth}{#1}}
\newcommand{\setrmarg}[1]{\renewcommand{\@tocrmarg}{#1}}
\providecommand{\cftdot}{.}
\providecommand{\cftdotfill}[1]{%
  \leaders\hbox{$\m@th\mkern #1 mu\hbox{\cftdot}\mkern #1 mu$}\hfill}
\providecommand{\cftdotsep}{4.5}
\newcommand{\cftnodots}{2000}
\newcommand{\cftparfillskip}{\parfillskip=0pt plus1fil}
\renewcommand{\numberline}[1]{%
  \hb@xt@\@tempdima{\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb}
\newcommand{\@cftbsnum}{}
\newcommand{\@cftasnum}{}
\newcommand{\@cftasnumb}{}
\newcommand{\newlistentry}[4][\@empty]{%
  \@ifundefined{c@#2}{%    check & set the counter
    \ifx \@empty#1\relax
      \newcounter{#2}
    \else
      \newcounter{#2}[#1]%
      \expandafter\edef\csname the#2\endcsname{%
  \expandafter\noexpand\csname the#1\endcsname.\noexpand\arabic{#2}}
    \fi}{}
  \setcounter{#2}{0}

  \@namedef{l@#2}##1##2{%
    \ifnum \@nameuse{c@#3depth} > #4\relax
      \vskip \@nameuse{cftbefore#2skip}
      {\leftskip \@nameuse{cft#2indent}\relax
       \rightskip \@tocrmarg
       \parfillskip -\rightskip
       \parindent \@nameuse{cft#2indent}\relax\@afterindenttrue
       \interlinepenalty\@M
       \leavevmode
       \@tempdima \@nameuse{cft#2numwidth}\relax
 \expandafter\let\expandafter\@cftbsnum\csname cft#2presnum\endcsname
 \expandafter\let\expandafter\@cftasnum\csname cft#2aftersnum\endcsname
 \expandafter\let\expandafter\@cftasnumb\csname cft#2aftersnumb\endcsname
       \advance\leftskip\@tempdima \null\nobreak\hskip -\leftskip
       {\@nameuse{cft#2font}##1}\nobreak
       \@nameuse{cft#2fillnum}{##2}}
    \fi
  }  % end of \l@#2

  \expandafter\newlength\csname cftbefore#2skip\endcsname
    \setlength{\@nameuse{cftbefore#2skip}}{\z@ \@plus .2\p@}
  \expandafter\newlength\csname cft#2indent\endcsname
  \expandafter\newlength\csname cft#2numwidth\endcsname
  \ifcase #4\relax  % 0   (level 1)
    \setlength{\@nameuse{cft#2indent}}{0em}
    \setlength{\@nameuse{cft#2numwidth}}{2.3em}
  \or               % 1   (level 2)
    \setlength{\@nameuse{cft#2indent}}{2.3em}
    \setlength{\@nameuse{cft#2numwidth}}{3.2em}
  \or               % 2   (level 3)
    \setlength{\@nameuse{cft#2indent}}{5.5em}
    \setlength{\@nameuse{cft#2numwidth}}{4.1em}
  \or               % 3   (level 4)
    \setlength{\@nameuse{cft#2indent}}{8.5em}
    \setlength{\@nameuse{cft#2numwidth}}{5.0em}
  \else             % anything else
    \setlength{\@nameuse{cft#2indent}}{10.5em}
    \setlength{\@nameuse{cft#2numwidth}}{6.0em}
  \fi
  \@namedef{cft#2font}{\normalfont}
  \@namedef{cft#2presnum}{}
  \@namedef{cft#2aftersnum}{}
  \@namedef{cft#2aftersnumb}{}
  \@namedef{cft#2dotsep}{\cftdotsep}
  \@namedef{cft#2leader}{\normalfont\cftdotfill{\@nameuse{cft#2dotsep}}}
  \@namedef{cft#2pagefont}{\normalfont}
  \@namedef{cft#2afterpnum}{}
  \@namedef{toclevel@#2}{#4}
  \@namedef{cft#2fillnum}##1{%
    {\@nameuse{cft#2leader}}\nobreak
    \hb@xt@\@pnumwidth{%
      \hfil\@nameuse{cft#2pagefont}##1}\@nameuse{cft#2afterpnum}\par}
} % end \newlistentry

\newcommand{\cftsetindents}[3]{%
  \setlength{\@nameuse{cft#1indent}}{#2}
  \setlength{\@nameuse{cft#1numwidth}}{#3}
}

\newcommand*{\cftpartname}{}

\newcommand*{\l@part}[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{\cftbeforepartskip}%
    \begingroup
      {\leftskip \cftpartindent\relax
       \rightskip \@tocrmarg
       \parfillskip -\rightskip
       \parindent \cftpartindent\relax\@afterindenttrue
       \interlinepenalty\@M
       \leavevmode
       \settowidth{\@tempdima}{\cftpartfont\cftpartname}%
       \addtolength{\@tempdima}{\cftpartnumwidth}%
       \let\@cftbsnum \cftpartpresnum
       \let\@cftasnum \cftpartaftersnum
       \let\@cftasnumb \cftpartaftersnumb
       \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
       {\cftpartfont #1}%
       \cftpartfillnum{#2}}
      \nobreak
        \global\@nobreaktrue
        \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}

\newcommand{\sectionnumberline}[1]{%
  \hb@xt@\@tempdima{%
    \cftpartname\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb}

\newcommand{\partnumberline}[1]{%
  \hb@xt@\@tempdima{%
    \cftpartname\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb}

  \newlength{\cftbeforepartskip}
    \setlength{\cftbeforepartskip}{2.25em \@plus\p@}
  \newlength{\cftpartindent}
    \setlength{\cftpartindent}{0em}
  \newlength{\cftpartnumwidth}
    \setlength{\cftpartnumwidth}{1.5em}
  \newcommand{\cftpartfont}{\large\bfseries}
  \newcommand{\cftpartpresnum}{}
  \newcommand{\cftpartaftersnum}{}
  \newcommand{\cftpartaftersnumb}{}
  \newcommand{\cftpartleader}{%
              \large\bfseries\cftdotfill{\cftpartdotsep}}
  \newcommand{\cftpartdotsep}{\cftnodots}
  \newcommand{\cftpartpagefont}{\large\bfseries}
  \newcommand{\cftpartafterpnum}{}
  \newcommand{\cftpartfillnum}[1]{%
    {\cftpartleader}%
    {\hb@xt@\@pnumwidth{\hss {\cftpartpagefont #1}}}%
     \cftpartafterpnum\par}

\newcommand*{\cftchaptername}{}

\newcommand*{\l@chapapp}[3]{%
  \ifnum \c@tocdepth >\m@ne
    \cftchapterbreak
    \vskip \cftbeforechapterskip
    {\leftskip \cftchapterindent\relax
     \rightskip \@tocrmarg
     \parfillskip -\rightskip
     \parindent \cftchapterindent\relax
     \@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \let\@cftbsnum \cftchapterpresnum
     \let\@cftasnum \cftchapteraftersnum
     \let\@cftasnumb \cftchapteraftersnumb
     \def\@chapapp@head{#3}%
     \settowidth{\@tempdima}{\cftchapterfont\@chapapp@head}%
     \addtolength{\@tempdima}{\cftchapternumwidth}%
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {\cftchapterfont #1}\nobreak
     \cftchapterfillnum{#2}}
  \fi}

\newcommand*{\l@chapter}[2]{%
  \l@chapapp{#1}{#2}{\cftchaptername}}

\newcommand*{\cftappendixname}{}

\newcommand*{\l@appendix}[2]{%
  \l@chapapp{#1}{#2}{\cftappendixname}}
\newcommand{\toclevel@appendix}{0}

\newcommand{\chapternumberline}[1]{%
  \hb@xt@\@tempdima{\@chapapp@head\@cftbsnum #1\@cftasnum\hfil}%
  \@cftasnumb}

  \newlength{\cftbeforechapterskip}
    \setlength{\cftbeforechapterskip}{1.0em \@plus\p@}
  \newlength{\cftchapterindent}
    \setlength{\cftchapterindent}{0em}
  \newlength{\cftchapternumwidth}
    \setlength{\cftchapternumwidth}{1.5em}
  \newcommand{\cftchapterfont}{\bfseries}
  \newcommand{\cftchapterpresnum}{}
  \newcommand{\cftchapteraftersnum}{}
  \newcommand{\cftchapteraftersnumb}{}
  \newcommand{\cftchapterleader}{%
              \bfseries\cftdotfill{\cftchapterdotsep}}
  \newcommand{\cftchapterdotsep}{\cftnodots}
  \newcommand{\cftchapterpagefont}{\bfseries}
  \newcommand{\cftchapterafterpnum}{}
  \newcommand{\cftchapterfillnum}[1]{
    {\cftchapterleader}\nobreak
    \hb@xt@\@pnumwidth{\hfil\cftchapterpagefont #1}%
    \cftchapterafterpnum\par}
  \newcommand{\cftchapterbreak}{\addpenalty{-\@highpenalty}}

\newlistentry[chapter]{section}{toc}{0}
  \cftsetindents{section}{1.5em}{2.3em}
\newlistentry[section]{subsection}{toc}{1}
  \cftsetindents{subsection}{3.8em}{3.2em}
\newlistentry[subsection]{subsubsection}{toc}{2}
  \cftsetindents{subsubsection}{7.0em}{4.1em}
\newlistentry[subsubsection]{paragraph}{toc}{3}
  \cftsetindents{paragraph}{10.0em}{5.0em}
\newlistentry[paragraph]{subparagraph}{toc}{4}
  \cftsetindents{subparagraph}{12.0em}{6.0em}

\newcommand{\@cftl@subfigtab}{
\newlistentry[figure]{subfigure}{lof}{1}
  \cftsetindents{subfigure}{2.3em}{2.5em}
\newlistentry[table]{subtable}{lot}{1}
  \cftsetindents{subtable}{2.3em}{2.5em}
}

\AtBeginDocument{\@ifpackageloaded{subfigure}{\@cftl@subfigtab}{}}

\DeclareRobustCommand{\cftpagenumbersoff}[1]{%
  \@namedef{cft#1fillnum}##1{%
    \cftparfillskip\@nameuse{cft#1afterpnum}\par}}

\DeclareRobustCommand{\cftpagenumberson}[1]{%
  \@namedef{cft#1fillnum}##1{%
    {\@nameuse{cft#1leader}}\nobreak
    \hb@xt@\@pnumwidth{%
      \hfil\@nameuse{cft#1pagefont}##1}\@nameuse{cft#1afterpnum}\par}}

\newcommand{\chapterprecis}[1]{%
  \chapterprecishere{#1}
  \chapterprecistoc{#1}}
\newcommand{\chapterprecishere}[1]{%
  \prechapterprecis #1\postchapterprecis}
\newcommand{\prechapterprecis}{%
  \vspace*{-2\baselineskip}%
  \begin{quote}\normalfont\itshape}
\newcommand{\postchapterprecis}{\end{quote}}

\newcommand{\precistocfont}{\normalfont\itshape}
\newcommand{\chapterprecistoc}[1]{%
  \addtocontents{toc}{\precistoctext{#1}}}
\DeclareRobustCommand{\precistoctext}[1]{%
  {\leftskip \cftchapterindent\relax
   \advance\leftskip \cftchapternumwidth\relax
   \rightskip \@tocrmarg\relax
   \precistocfont #1\par}}
\newcommand{\cftlocalchange}[3]{%
  \addtocontents{#1}{\protect\setpnumwidth{#2} \protect\setrmarg{#3}}}
\newcommand{\cftaddtitleline}[4]{%
  \addtocontents{#1}{\protect\contentsline{#2}{#3}{#4}}}
\newcommand{\cftaddnumtitleline}[5]{%
  \addtocontents{#1}%
    {\protect\contentsline{#2}{\protect\numberline{#3}%
                              {\protect\ignorespaces #4}}{#5}}}
\newcommand{\@setclcnt}[2]{
  \@tempswafalse
  \nametest{#1}{none}
  \ifsamename
    \setcounter{#2}{-10}
    \@tempswatrue
  \fi
  \nametest{#1}{part}
  \ifsamename
    \setcounter{#2}{-1}
    \@tempswatrue
  \fi
  \nametest{#1}{chapter}
  \ifsamename
    \setcounter{#2}{0}
    \@tempswatrue
  \fi
  \nametest{#1}{section}
  \ifsamename
    \setcounter{#2}{1}
    \@tempswatrue
  \fi
  \nametest{#1}{subsection}
  \ifsamename
    \setcounter{#2}{2}
    \@tempswatrue
  \fi
  \nametest{#1}{subsubsection}
  \ifsamename
    \setcounter{#2}{3}
    \@tempswatrue
  \fi
  \nametest{#1}{paragraph}
  \ifsamename
    \setcounter{#2}{4}
    \@tempswatrue
  \fi
  \nametest{#1}{subparagraph}
  \ifsamename
    \setcounter{#2}{5}
    \@tempswatrue
  \fi
  \nametest{#1}{all}
  \ifsamename
    \setcounter{#2}{50}
    \@tempswatrue
  \fi
    \if@tempswa\else
    \@puperror{%
      Unknown document division name (#1)
    }{%
      I'll ignore it.
      Type \space <return> and I'll continue.\MessageBreak
      If you haven't mistyped the name then use
      \protect\setcounter\space instead.}
  \fi
}
\newcommand{\settocdepth}[1]{%
  \@tempswafalse
  \nametest{#1}{none}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{-10}}
    \@tempswatrue
  \fi
  \nametest{#1}{part}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{-1}}
    \@tempswatrue
  \fi
  \nametest{#1}{chapter}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{0}}
    \@tempswatrue
  \fi
  \nametest{#1}{section}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{1}}
    \@tempswatrue
  \fi
  \nametest{#1}{subsection}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{2}}
    \@tempswatrue
  \fi
  \nametest{#1}{subsubsection}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{3}}
    \@tempswatrue
  \fi
  \nametest{#1}{paragraph}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{4}}
    \@tempswatrue
  \fi
  \nametest{#1}{subparagraph}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{5}}
    \@tempswatrue
  \fi
  \nametest{#1}{all}
  \ifsamename
    \addtocontents{toc}{\changetocdepth{50}}
    \@tempswatrue
  \fi
    \if@tempswa\else
    \@puperror{%
      Unknown document division name (#1)
    }{%
      I'll ignore it. Type \space <return> and I'll continue.}
  \fi
}
\DeclareRobustCommand{\changetocdepth}[1]{\setcounter{tocdepth}{#1}}

\newcommand{\maxtocdepth}[1]{%
  \@setclcnt{#1}{tocdepth}}
\newcommand{\setsecnumdepth}[1]{%\leavevmode%
  \@setclcnt{#1}{secnumdepth}}
\newcounter{maxsecnumdepth}
\newcommand{\maxsecnumdepth}[1]{%
  \@setclcnt{#1}{secnumdepth}\@setclcnt{#1}{maxsecnumdepth}}

\newdimen\bibindent
  \setlength\bibindent{1.5em}
\newlength{\bibitemsep}
  \setlength{\bibitemsep}{\itemsep}
\newcommand{\biblistextra}{\itemsep=\bibitemsep}

\newenvironment{bibitemlist}[1]{%
  \typeout{bibitemlist}
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}%
        \biblistextra}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}%
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist}

\newcommand{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newcommand*{\setbiblabel}[1]{%
  \renewcommand*{\@biblabel}[1]{#1}}
\setbiblabel{[#1]\hfill}
\newcommand{\@pupb@bchap}{%
  \chapter*{\bibname}%
  \bibmark
  \ifnobibintoc\else
    \phantomsection
    \addcontentsline{toc}{chapter}{\bibname}%
  \fi
  \prebibhook}
\newcommand{\@pupb@bsec}{\section{\bibname}\prebibhook}
\newcommand{\bibsection}{\@pupb@bchap}

\newenvironment{thebibliography}[1]{%
  \bibsection
  \begin{bibitemlist}{#1}}{\end{bibitemlist}\postbibhook}
\newif\ifnobibintoc
\newcommand*{\bibintoc}{\nobibintocfalse}
\newcommand*{\nobibintoc}{\nobibintoctrue}
\bibintoc

\newcommand{\prebibhook}{}
\newcommand{\postbibhook}{}

\AtBeginDocument{%
  \@ifpackageloaded{natbib}{% natbib is loaded
    \addtodef{\endthebibliography}{}{\vskip-\lastskip\postbibhook}
    \@ifpackagewith{natbib}{sectionbib}{% with sectionbib option
      \renewcommand{\bibsection}{\@pupb@bsec}}%
      {\renewcommand{\bibsection}{\@pupb@bchap}}}%
  {}
  \@ifpackagewith{chapterbib}{sectionbib}{%
    \renewcommand{\sectionbib}[2]{}
    \renewcommand{\bibsection}{\@pupb@bsec}}{}
}

\newif\ifonecolindex
  \onecolindexfalse

\newenvironment{theindex}{%
  \if@twocolumn
    \@restonecolfalse
  \else
    \@restonecoltrue
  \fi
  \ifonecolindex
    \onecolumn
    \chapter*{\indexname}
    \preindexhook
  \else
    \setlength{\columnseprule}{\indexrule}%
    \setlength{\columnsep}{\indexcolsep}%
    \twocolumn[\@makeschapterhead{\indexname}
               \preindexhook]%
  \fi
  \indexmark
  \ifnoindexintoc\else
    \phantomsection
    \addcontentsline{toc}{chapter}{\indexname}%
  \fi
  \thispagestyle{chapter}\parindent\z@
  \parskip\z@ \@plus .3\p@\relax
  \let\item\@idxitem}%
  {\if@restonecol\onecolumn\else\twocolumn\fi}

\newif\ifnoindexintoc
\newcommand*{\indexintoc}{\noindexintocfalse}
\newcommand*{\noindexintoc}{\noindexintoctrue}
\indexintoc

\newlength{\indexcolsep} \setlength{\indexcolsep}{35pt}
\newlength{\indexrule}   \setlength{\indexrule}{0pt}

\newcommand{\preindexhook}{}
\newcommand{\l@index}{\@dottedtocline{1}{0em}{0pt}}
\newcommand{\@idxitem}  {\par\hangindent 40\p@}
\newcommand{\subitem}   {\par\hangindent 40\p@ \hspace*{20\p@}}
\newcommand{\subsubitem}{\par\hangindent 40\p@ \hspace*{30\p@}}
\newcommand{\indexspace}{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}

\newcommand*{\makepupindexhook}{}
\providecommand*{\makeindex}{}
\renewcommand*{\makeindex}[1][\jobname]{%
  \if@filesw
    \def\index{\@bsphack%
      \@ifnextchar [{\@index}{\@index[\jobname]}}
    \def\specialindex{\@bsphack\@spindex}%
    \makepupindexhook
    \expandafter\newwrite\csname #1@idxfile\endcsname
    \expandafter\immediate\openout \csname #1@idxfile\endcsname #1.idx\relax
    \typeout{Writing index file #1.idx }%
  \fi}

\renewcommand{\index}[2][\jobname]{\@bsphack\@esphack}
\newcommand{\specialindex}[3]{\@bsphack\@esphack}

\newcommand{\printindex}[1][\jobname]{\@input@{#1.ind}}

\newif\ifreportnoidxfile
  \reportnoidxfilefalse
\newif\ifshowindexmark
  \showindexmarkfalse

\def\@index[#1]{%
  \@ifundefined{#1@idxfile}%
  {\ifreportnoidxfile
     \@pupwarn{Undefined index file #1}%
    \fi
    \begingroup
    \@sanitize
    \@nowrindex}%
  {\def\@idxfile{#1}%
   \begingroup
   \@sanitize
   \@wrindexp@p}}
\newcommand{\@nowrindex}[1]{%
  \ifshowindexmark\@showidx{#1}\fi\endgroup\@esphack}

\newcommand{\@wrindexp@p}[1]{\@@wrindexhyp#1||\\}
\def\@@wrindexhyp#1|#2|#3\\{%
  \ifshowindexmark\@showidx{#1}\fi
  \ifx\\#2\\%
    \protected@write\@auxout{}%
      {\string\@@wrindexp@p{\@idxfile}{#1|hyperpage}{\thepage}}%
  \else
    \def\Hy@temp@A{#2}%
    \ifx\Hy@temp@A\HyInd@ParenLeft
      \protected@write\@auxout{}%
        {\string\@@wrindexp@p{\@idxfile}{#1|#2hyperpage}{\thepage}}%
    \else
      \protected@write\@auxout{}%
        {\string\@@wrindexp@p{\@idxfile}{#1|#2}{\thepage}}%
    \fi
  \fi
  \endgroup
  \@esphack}
\newcommand{\hyperpage}[1]{#1}
\newcommand{\hyperlink}[2]{#2}

\newcommand{\@@wrindexp@p}[1]{\begingroup
  \def\@idxfile{\@nameuse{#1@idxfile}}
  \@sanitize
  \@@@wrindexp@p}

\newcommand{\@@@wrindexp@p}[2]{\endgroup}
\AtBeginDocument{%
  \def\@@@wrindexp@p#1#2{%
    \if@filesw
      \immediate\write \@idxfile{\string\indexentry{#1}{#2}}%
    \fi
    \endgroup}%
}
\newcommand{\@spindex}[2]{%
  \@ifundefined{#1@idxfile}%
  {\ifreportnoidxfile
     \@pupwarn{Undefined index file #1}%
    \fi
    \begingroup
    \@sanitize
    \@nowrindex}%
  {\def\@idxfile{#1}%
   \def\@sptheidx{#2}%
   \begingroup
   \@sanitize
   \@wrspindex}}

\newcommand{\@wrspindex}[1]{\@@wrspindexhyp#1||\\}
\def\@@wrspindexhyp#1|#2|#3\\{%
  \ifshowindexmark\@showidx{#1}\fi
  \ifx\\#2\\%
    \protected@write\@auxout{}%
      {\string\@@wrindexp@p{\@idxfile}%
        {#1|hyperspindexpage(\thepage)}%
      {\@nameuse{the\@sptheidx}}}%
  \else
    \def\Hy@temp@A{#2}%
    \ifx\Hy@temp@A\HyInd@ParenLeft
      \protected@write\@auxout{}%
        {\string\@@wrindexp@p{\@idxfile}%
         {#1|#2hyperspindexpage(\thepage)}%
         {\@nameuse{the\@sptheidx}}}%
    \else
      \protected@write\@auxout{}%
        {\string\@@wrindexp@p{\@idxfile}{#1|#2}%
        {\@nameuse{the\@sptheidx}}}%
    \fi
  \fi
  \endgroup
  \@esphack}
\def\hyperspindexpage(#1)#2{\hyperlink{page.#1}{#2}}

\newif\ifpuphyperindex
  \puphyperindextrue

\AtBeginDocument{%
  \@ifpackageloaded{hyperref}{}{\puphyperindexfalse}%
  \ifpuphyperindex\else
    \def\@@wrindexhyp#1||\\{%
      \ifshowindexmark\@showidx{#1}\fi
      \protected@write\@auxout{}%
        {\string\@@wrindexp@p{\@idxfile}{#1}{\thepage}}%
      \endgroup
      \@esphack}%
    \def\@@wrspindexhyp#1||\\{%
      \ifshowindexmark\@showidx{#1}\fi
      \protected@write\@auxout{}%
        {\string\@@wrindexp@p{\@idxfile}{#1}{\@nameuse{the\@sptheidx}}}%
      \endgroup
      \@esphack}%
  \fi
}

\newcommand*{\see}[2]{\emph{\seename} #1}
\newcommand*{\seename}{see}
\newcommand*{\seealso}[2]{\emph{\alsoname} #1}
\newcommand*{\alsoname}{see also}

\newcommand{\citeindexfile}{\jobname}
\AtBeginDocument{\@ifpackageloaded{natbib}{%
  \def\NAT@index{\index[\citeindexfile]{\NAT@idxtxt}}}{}}

\newtoks\indexmarkstyle
  \indexmarkstyle{\normalfont\footnotesize\ttfamily}
\newinsert\@indexbox
  \dimen\@indexbox\maxdimen

\begingroup
  \catcode`\@\active
  \expandafter\gdef\csname\string @sanitizeat\endcsname
  {\def @{\char`\@}}
\endgroup

\newcommand{\@showidx}[1]{%
  \insert\@indexbox{%
    \@sanitizeat
    \the\indexmarkstyle
    \hsize\marginparwidth
    \hangindent\marginparsep \parindent\z@
    \everypar{}\let\par\@@par \parfillskip\@flushglue
    \lineskip\normallineskip
    \baselineskip .8\normalbaselineskip\sloppy
    \raggedright \leavevmode
    \vrule \@height .7\normalbaselineskip \@width \z@\relax
      #1\relax
    \vrule \@height \z@ \@depth .3\normalbaselineskip \@width \z@\relax
  }%
  \ifhmode\penalty\@M \hskip\z@skip\fi
}

\newcommand{\@leftidx}{\hskip-\marginparsep \hskip-\marginparwidth}
\newcommand{\@rightidx}{\hskip\columnwidth \hskip\marginparsep}

\newcommand{\@mkidx}{\vbox to \z@{%
  \rlap{%
    \if@twocolumn
      \if@firstcolumn \@leftidx \else \@rightidx \fi
    \else
      \if@twoside
        \ifodd\c@page \@rightidx \else \@leftidx \fi
      \else
        \@rightidx
      \fi
    \fi
    \box\@indexbox
  }%
  \vss
}}

\renewcommand{\raggedbottom}{%
  \def\@textbottom{\vskip\z@ plus.0001fil}%
  \let\@texttop\@mkidx}
\renewcommand{\flushbottom}{%
  \let\@textbottom\relax
  \let\@texttop\@mkidx}
\let\@texttop\@mkidx

\newif\ifonecolglossary
  \onecolglossarytrue

\newenvironment{theglossary}{%
  \if@twocolumn
    \@restonecolfalse
  \else
    \@restonecoltrue
  \fi
  \ifonecolglossary
    \onecolumn
    \chapter*{\glossaryname}
    \preglossaryhook
  \else
    \setlength{\columnseprule}{\glossaryrule}
    \setlength{\columnsep}{\glossarycolsep}
    \twocolumn[\@makeschapterhead{\glossaryname}
               \preglossaryhook]%
  \fi
  \glossarymark
  \ifnoglossaryintoc\else
    \phantomsection
    \addcontentsline{toc}{chapter}{\glossaryname}
  \fi
  \thispagestyle{chapter}\parindent\z@
  \parskip\z@ \@plus .3\p@\relax
  \begintheglossaryhook}%
  {\atendtheglossaryhook\if@restonecol\onecolumn\else\twocolumn\fi}

\newcommand*{\begintheglossaryhook}{}
\newcommand*{\atendtheglossaryhook}{}
\newcommand*{\preglossaryhook}{}

\newif\ifnoglossaryintoc
\newcommand*{\glossaryintoc}{\noglossaryintocfalse}
\newcommand*{\noglossaryintoc}{\noglossaryintoctrue}
  \glossaryintoc

\newdimen\glossarycolsep \glossarycolsep=35\p@
\newdimen\glossaryrule \glossaryrule=0\p@
\newcommand*{\glossaryspace}{%
    \par \vskip 1.0\onelineskip \@plus 5\p@ \@minus3\p@\relax}

\providecommand*{\makeglossary}{}
\renewcommand*{\makeglossary}[1][\jobname]{%
  \makepupglossaryhook
  \@namedef{pupglsact#1}{@}%           actual
  \@namedef{pupglsnx#1}{}%             no ref
  \@namedef{pupglsn#1}{\thepage}%      num  by page
  \@namedef{pupglsnf#1}{|pupjustarg}%  no special number format
  \if@filesw \expandafter\newwrite\csname #1pupglofile\endcsname
    \expandafter\immediate\openout \csname #1pupglofile\endcsname #1.glo\relax
    \typeout{Writing glossary file #1.glo }%
  \fi}

\newcommand*{\makepupglossaryhook}{}

  \def\glossary{\@bsphack%
    \@ifnextchar [{\@glossary}{\@glossary[\jobname]}}%
\def\@glossary[#1]{%
  \@ifnextchar ({\@@glossary[#1]}{\@@glossary[#1]()}}
\def\@@glossary[#1](#2)#3#4{%
  \@ifundefined{#1pupglofile}{%
    \begingroup
    \@sanitize
    \endgroup
    \@esphack%
   }{%
    \def\pupglofile{#1}%
    \begingroup
    \@sanitize
    \ifx\@empty#2\@empty
      \@wrglop@p{#3}{#3}{#4}%
    \else
      \@wrglop@p{#2}{#3}{#4}%
    \fi}}

\newcommand{\@wrglop@p}[3]{%
  \protected@write\@auxout{}%
    {\string\@@wrglop@p{\pupglofile}{#1}{#2}{#3}{\@nameuse{pupglsnx\pupglofile}}{\@nameuse{pupglsn\pupglofile}}}%
  \endgroup
  \@esphack}

\newcommand{\@@wrglop@p}[1]{\begingroup
  \def\pupglofile{\@nameuse{#1pupglofile}}%
  \def\p@pgf{#1}%
  \@sanitize
  \pupwritetoglo}

\newcommand{\pupwritetoglo}[5]{\endgroup}
\newcommand{\@ctualp@pwritetoglo}[5]{%
  \immediate\write \pupglofile{\string\glossaryentry{#1\@nameuse{pupglsact\p@pgf}
                    {\string\pupgloterm{#2}}{\string\pupglodesc{#3}}
                    {\string\pupgloref{#4}}\@nameuse{pupglsnf\p@pgf}}{#5}}%
  \endgroup}
\AtBeginDocument{%
  \let\pupwritetoglo\@ctualp@pwritetoglo}

\newcommand*{\changeglossactual}[2][\jobname]{%
  \@namedef{pupglsact#1}{#2}}
\newcommand*{\changeglossref}[2][\jobname]{%
  \@namedef{pupglsnx#1}{#2}}
\newcommand*{\changeglossnum}[2][\jobname]{%
  \@namedef{pupglsn#1}{#2}}
\newcommand*{\changeglossnumformat}[2][\jobname]{%
  \@namedef{pupglsnf#1}{#2}}

\newcommand{\glossitem}[4]{#1 #2 #3 #4\par}

\newcommand*{\pupgloterm}[1]{#1}
\newcommand*{\pupglodesc}[1]{#1}
\newcommand*{\pupgloref}[1]{#1}
\newcommand*{\pupglonum}[1]{#1}

\newcommand*{\printglossary}[1][\jobname]{\@input@{#1.gls}}

\def\@addmarginpar{%
    \checkoddpage
    \@next\@marbox\@currlist{\@cons\@freelist\@marbox
    \@cons\@freelist\@currbox}\@latexbug\@tempcnta\@ne
    \if@twocolumn
        \if@firstcolumn \@tempcnta\m@ne \fi
    \else
      \if@mparswitch
        \ifoddpage \else \@tempcnta\m@ne \fi
      \fi
    \if@reversemargin \@tempcnta -\@tempcnta \fi
    \fi
    \ifnum\@tempcnta <\z@  \global\setbox\@marbox\box\@currbox \fi
    \@tempdima\@mparbottom
    \advance\@tempdima -\@pageht
    \advance\@tempdima\ht\@marbox
    \ifdim\@tempdima >\z@
      \@latex@warning@no@line {Marginpar on page
                               \thepage\space moved by \the\@tempdima}%
    \else
      \@tempdima\z@
    \fi
    \global\@mparbottom\@pageht
    \global\advance\@mparbottom\@tempdima
    \global\advance\@mparbottom\dp\@marbox
    \global\advance\@mparbottom\marginparpush
    \advance\@tempdima -\ht\@marbox
    \global\setbox \@marbox
                   \vbox {\vskip \@tempdima
                          \box \@marbox}%
    \global \ht\@marbox \z@
    \global \dp\@marbox \z@
    \kern -\@pagedp
    \nointerlineskip
    \hb@xt@\columnwidth
      {\ifnum \@tempcnta >\z@
          \hskip\columnwidth \hskip\marginparsep
       \else
          \hskip -\marginparsep \hskip -\marginparwidth
       \fi
       \box\@marbox \hss}%
    \nointerlineskip
    \hbox{\vrule \@height\z@ \@width\z@ \@depth\@pagedp}%
}

\newcommand{\parnopar}{\parfillskip=0pt\par\parskip=0pt\noindent}

\newlength{\sideparvshift}
  \setlength{\sideparvshift}{-2.08ex}% seems to work for all font sizes

\newif\ifreversesidepar
  \reversesidepartrue
\newif\ifsideparswitch
  \sideparswitchfalse
\if@twoside \sideparswitchtrue \fi

\newcommand{\sidepar}{\@dblarg{\@sidepar}}
\long\def\@sidepar[#1]#2{\@bsphack\leavevmode\vadjust{% %
  \checkoddpage
  \ifsideparswitch
    \ifreversesidepar
      \ifoddpage
        \oddpagefalse
      \else
        \oddpagetrue
      \fi
    \fi
  \else
    \oddpagetrue
    \ifreversesidepar
      \oddpagefalse
    \fi
  \fi
  \rlap{\kern-\parindent
    \if@twocolumn
      \if@firstcolumn     % put at left
        \kern -\marginparsep \kern -\marginparwidth % at left
      \else               % put at right
        \kern \columnwidth \kern \marginparsep % at right
      \fi
    \else
      \ifoddpage            % put at right
        \kern \textwidth \kern \marginparsep        % at right
      \else                 % put at left
        \kern -\marginparsep \kern -\marginparwidth % at left
      \fi
    \fi
    \vbox to 0pt{%
     \kern \sideparvshift%  % vertical shift to align top text lines
     \begin{minipage}{\marginparwidth}%
      \ifoddpage #2\else #1\fi%
      \end{minipage}%
  \vss}}}\@esphack}

\newinsert\sideins
  \skip\sideins=0pt
  \count\sideins=0

\newcommand{\setsidebarheight}[1]{\dimen\sideins= #1}
  \setsidebarheight{20\onelineskip}

\newlength{\sidebarhsep} \setlength{\sidebarhsep}{\marginparsep}
\newlength{\sidebarvsep} \setlength{\sidebarvsep}{2\onelineskip}
\newlength{\sidebarwidth} \setlength{\sidebarwidth}{\marginparwidth}

\newcommand{\sidebarfont}{\normalfont}
\newcommand{\sidebarform}{\rightskip=\z@ \@plus 2em}

\newif\ifsidebaroneside
  \if@twoside\sidebaronesidefalse\else\sidebaronesidetrue\fi

\newcommand*{\sidebarmargin}[1]{%
  \def\@tempa{#1}\def\@tempb{left}%
  \ifx\@tempa\@tempb
    \gdef\p@psidebar@margin{0}%
  \else
    \def\@tempb{right}%
    \ifx\@tempa\@tempb
      \gdef\p@psidebar@margin{1}%
    \else
      \def\@tempb{outer}%
      \ifx\@tempa\@tempb
        \gdef\p@psidebar@margin{2}%
      \else
        \def\@tempb{inner}%
        \ifx\@tempa\@tempb
          \gdef\p@psidebar@margin{3}%
        \else
          \@pupwarn{Bad \string\sidebarmargin\space argument}%
          \gdef\p@psidebar@margin{1}%
        \fi
       \fi
     \fi
  \fi}
%%%% default outer
\gdef\p@psidebar@margin{2}
\newcommand{\sidecontents}{{%
  \if@twocolumn%    %% put outside nearest column
    \if@firstcolumn%  %% move to left
      \setlength{\@tempdimc}{\sidebarwidth}%
      \advance\@tempdimc\sidebarhsep
      \moveleft\@tempdimc
    \else%            %% move to right
      \setlength{\@tempdimc}{\columnwidth}%
      \advance\@tempdimc\sidebarhsep
      \moveright\@tempdimc
    \fi
  \else%            %% put into foremargin?
    \ifsidebaroneside%  %% put into right hand margin
      \setlength{\@tempdimc}{\hsize}%
      \advance\@tempdimc\sidebarhsep
      \moveright\@tempdimc
    \else%              %% ???
      \ifcase\p@psidebar@margin%   0 to left
        \setlength{\@tempdimc}{\sidebarwidth}%
        \advance\@tempdimc\sidebarhsep
        \moveleft\@tempdimc
      \or%                         1 to right
        \setlength{\@tempdimc}{\hsize}%
        \advance\@tempdimc\sidebarhsep
        \moveright\@tempdimc
      \or%                         2 to outer
        \ifodd\c@page%  %% move to right
          \setlength{\@tempdimc}{\hsize}%
          \advance\@tempdimc\sidebarhsep
          \moveright\@tempdimc
        \else%          %% move to left
          \setlength{\@tempdimc}{\sidebarwidth}%
          \advance\@tempdimc\sidebarhsep
          \moveleft\@tempdimc
        \fi
      \or%                        3 to inner
        \ifodd\c@page%  %% move to left
          \setlength{\@tempdimc}{\sidebarwidth}%
          \advance\@tempdimc\sidebarhsep
          \moveleft\@tempdimc
        \else%          %% move to right
          \setlength{\@tempdimc}{\hsize}%
          \advance\@tempdimc\sidebarhsep
          \moveright\@tempdimc
        \fi
      \fi
    \fi
  \fi
  \vtop to0pt{%
    \vskip\onelineskip
    \unvbox\sideins \vss}%
}}

\newcommand{\sidebar}[1]{%
  \insert\sideins{%
    \splittopskip\sidebarvsep\relax
    \hsize \sidebarwidth
    \@parboxrestore                % <- added in v1.4
    \sidebarform \sidebarfont
    \noindent\vbox to \sidebarvsep{}\ignorespaces #1%
    \ifhmode\unskip\strut\fi\par}}

\let\pupold@makecol\@makecol
\gdef\mep@pakecol{%
  \ifvoid\footins
    \setbox\@outputbox \box\@cclv
  \else
    \setbox\@outputbox \vbox{%
    \boxmaxdepth\@maxdepth
    \@tempdima\dp\@cclv
    \unvbox\@cclv
    \vskip-\@tempdima
    \vskip \skip\footins
    \color@begingroup
      \normalcolor
      \footnoterule
      \unvbox \footins
    \color@endgroup
    }
  \fi
  \ifvoid\sideins\else    %%% start of change
    \setbox\@outputbox \vbox{%
      \sidecontents
      \unvbox\@outputbox
    }
  \fi                     %%% end of change
  \xdef\@freelist{\@freelist\@midlist}%
  \global\let\@midlist\@empty
  \@combinefloats
  \ifvbox\@kludgeins
    \@makespecialcolbox
  \else
    \setbox\@outputbox \vbox to\@colht{%
      \boxmaxdepth \maxdepth
      \@texttop
      \dimen@ \dp\@outputbox
      \unvbox \@outputbox
      \vskip -\dimen@
      \@textbottom
    }%
  \fi
  \global \maxdepth \@maxdepth
}

\newif\if@pup@nofoot
\newcommand*{\@pup@testifnofoot}{%
  \@pup@nofoottrue
  \ifvoid\footins\else\@pup@nofootfalse\fi
  \ifvoid\footinsv@r\else\@pup@nofootfalse\fi
  \ifvoid\sideins\else\@pup@nofootfalse\fi
  \@pup@extranofeet}
\newcommand*{\@pup@extranofeet}{}

\let\pupold@doclearpage\@doclearpage
\newcommand{\pup@doclearpage}{%
%%%%  \typeout{Redefining @doclearpage}
  \@pup@testifnofoot
  \if@pup@nofoot
    \setbox\@tempboxa\vsplit\@cclv to\z@ \unvbox\@tempboxa
    \setbox\@tempboxa\box\@cclv
    \xdef\@deferlist{\@toplist\@botlist\@deferlist}%
    \global\let\@toplist\@empty
    \global\let\@botlist\@empty
    \global\@colroom\@colht
    \ifx \@currlist\@empty
    \else
      \@latexerr{Float(s) lost}\@ehb
      \global\let\@currlist\@empty
    \fi
    \@makefcolumn\@deferlist
    \@whilesw\if@fcolmade \fi{\@opcol\@makefcolumn\@deferlist}%
    \if@twocolumn
      \if@firstcolumn
        \xdef\@dbldeferlist{\@dbltoplist\@dbldeferlist}%
        \global\let\@dbltoplist\@empty
        \global\@colht\textheight
        \begingroup
          \@dblfloatplacement
          \@makefcolumn\@dbldeferlist
          \@whilesw\if@fcolmade \fi{\@outputpage
                                    \@makefcolumn\@dbldeferlist}%
        \endgroup
      \else
        \vbox{}\clearpage
      \fi
    \fi
  \else
    \setbox\@cclv\vbox{\box\@cclv\vfil}%
    \@makecol\@opcol
    \clearpage
  \fi
}

\let\pupold@reinserts\@reinserts
\gdef\pup@reinserts{%
  \ifvoid\footins\else\insert\footins{\unvbox\footins}\fi
  \ifvbox\@kludgeins\insert\@kludegins{\unvbox\@kludgeins}\fi
  \ifvoid\sideins\else\sidecontents\fi
}

\gdef\@makecol{\mep@pakecol}
\gdef\@doclearpage{\pup@doclearpage}

\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\skip\footins=\bigskipamount
\@addtoreset{footnote}{chapter}
\newcommand*{\multfootsep}{\textsuperscript{\normalfont,}}
\newcommand*{\multiplefootnotemarker}{3sp}
\newcommand*{\p@pmf@prepare}{%
  \kern-\multiplefootnotemarker
  \kern\multiplefootnotemarker\relax}
\newcommand*{\p@pmf@check}{%
  \ifdim\lastkern=\multiplefootnotemarker\relax
    \edef\@x@sf{\the\spacefactor}%
    \unkern
    \multfootsep
    \spacefactor\@x@sf\relax
  \fi}

\let\p@pold@footnotetext\@footnotetext
\renewcommand{\@footnotetext}[1]{%
  \rest@font\p@pold@footnotetext{#1}\p@pmf@prepare}
\renewcommand*{\@footnotemark}{%
  \leavevmode
  \ifhmode
    \edef\@x@sf{\the\spacefactor}%
    \p@pmf@check
    \nobreak
  \fi
  \@makefnmark
  \p@pmf@prepare
  \ifhmode\spacefactor\@x@sf\fi
  \relax}

\newlength{\footmarkwidth}
\newlength{\footmarksep}
\newlength{\footparindent}
\newcommand*{\footmarkstyle}[1]{\def\footscript##1{#1}}
\newcommand{\makefootmarkhook}{}

\newcommand{\footfootmark}{%
  \ifdim\footmarkwidth < \z@
    \llap{\hb@xt@ -\footmarkwidth{%
            \hss\normalfont\footscript{\@thefnmark}}%
          \hspace*{-\footmarkwidth}}%
  \else
    \ifdim\footmarkwidth = \z@
      {\normalfont\footscript{\@thefnmark}}%
    \else
      \hb@xt@\footmarkwidth{\hss\normalfont\footscript{\@thefnmark}}%
    \fi
  \fi}

\newcommand{\makefootmark}[1]{%
  \leavevmode
  \parindent \footparindent\noindent
  \leftskip\footmarksep\relax
  \advance\leftskip \footmarkwidth \null\nobreak\hskip -\leftskip\relax
  \makefootmarkhook\relax
  \footfootmark #1}
\newcommand{\@makefntext}[1]{\makefootmark #1}
\footmarkstyle{\textsuperscript{#1}}
\setlength{\footmarkwidth}{1.8em}
\setlength{\footmarksep}{-1.8em}
\setlength{\footparindent}{1em}

\newcommand{\footref}[1]{%
  \begingroup
    \unrestored@protected@xdef\@thefnmark{\ref{#1}}%
  \endgroup
  \@footnotemark}

\def\verbfootnote{\@ifnextchar[\@xverbfootnote{\stepcounter\@mpfn
  \protected@xdef\@thefnmark{\thempfn}%
  \@footnotemark\@verbfootnotetext}}

\def\@xverbfootnote[#1]{%
  \begingroup
    \csname c@\@mpfn\endcsname #1\relax
    \unrestored@protected@xdef\@thefnmark{\thempfn}%
  \endgroup
  \@footnotemark\@verbfootnotetext}

\long\def\@verbfootnotetext{%
  \insert\footins\bgroup
    \footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}%
%%%%    \color@begingroup
    \@makefntext{\rule{\z@}{\footnotesep}\ignorespaces}%
    \futurelet\next\fo@t
}
\def\fo@t{\ifcat\bgroup\noexpand\next \let\next\f@@t
          \else \let\next\f@t\fi \next}
\def\f@@t{\bgroup\aftergroup\@foot\let\next}
\def\f@t#1{%
  \color@begingroup
  #1\@foot
  \color@endgroup}
\def\@foot{%
  \strut\egroup
%%%%  \color@endgroup
  }

\long\def\@verbmpfootnotetext{%
  \global\setbox\@mpfootins\vbox{%
    \reset@font\footnotesize
    \unvbox\@mpfootins
    \bgroup
    \hsize\columnwidth
    \@parboxrestore
    \edef\@currentlabel{\csname p@mpfootnote\endcsname\@thefnmark}%
    \color@begingroup
    \@makefntext{\rule{\z@}{\footnotesep}\ignorespaces}%
    }
    \futurelet\next\fo@t
}

\def\@minipagerestore{\let\@verbfootnotetext\@verbmpfootnotetext}

%%%%%%%%%%%%%% major extension to footnoting

\newcommand{\p@p@makecolfloats}{%
  \xdef\@freelist{\@freelist\@midlist}%
  \global\let\@midlist\@empty
  \@combinefloats}
\newcommand{\p@p@makecoltext}{%
  \ifvbox\@kludgeins
    \@makespecialcolbox
  \else
    \setbox\@outputbox \vbox to\@colht{%
      \@texttop
      \dimen@ \dp\@outputbox
      \unvbox \@outputbox
      \vskip -\dimen@
      \@textbottom}%
  \fi}

\newcommand{\p@p@makecolintro}{}

\gdef\mep@pakecol{%
  \p@p@makecolintro
  \ifvoid\footins
    \setbox\@outputbox \box\@cclv
  \else
    \setbox\@outputbox \vbox{%
    \boxmaxdepth\@maxdepth
    \@tempdima\dp\@cclv
    \unvbox\@cclv
    \vskip \skip\footins
    \color@begingroup
      \normalcolor
      \footnoterule
      \unvbox \footins
    \color@endgroup
    }%
  \fi
  \p@pdoextrafeet
  \ifvoid\sideins\else
    \setbox\@outputbox \vbox{%
      \sidecontents
      \unvbox\@outputbox}%
  \fi
  \p@p@makecolfloats
  \p@p@makecoltext
  \global \maxdepth \@maxdepth}

\gdef\mep@pakecolbf{%
  \p@p@makecolintro
  \setbox\@outputbox \box\@cclv
  \p@p@makecolfloats
  \ifvoid\footins
  \else
    \setbox\@outputbox \vbox{%
    \boxmaxdepth\@maxdepth
    \unvbox\@outputbox
    \vskip \skip\footins
    \color@begingroup
      \normalcolor
      \footnoterule
      \unvbox \footins
    \color@endgroup
    }%
  \fi
  \p@pdoextrafeet
  \ifvoid\sideins\else
    \setbox\@outputbox \vbox{%
      \sidecontents
      \unvbox\@outputbox}%
  \fi
  \p@p@makecoltext
  \global \maxdepth \@maxdepth}

\newcommand{\feetabovefloat}{\gdef\@makecol{\mep@pakecol}}
\newcommand{\feetbelowfloat}{\gdef\@makecol{\mep@pakecolbf}}
\feetabovefloat

\newcommand{\p@pdoextrafeet}{\extrafeetins}
\newcommand*{\extrafeetins}{%
  \setbox\@outputbox \vbox{%
    \boxmaxdepth \@maxdepth
    \unvbox\@outputbox
    \ifvoid\footinsv@r\else\@footstartv@r\@footgroupv@r\fi
    \extrafeetinshook}}
\newcommand{\extrafeetinshook}{}

\gdef \@reinserts{%
  \ifvoid\footins\else\insert\footins{\unvbox\footins}\fi
  \p@pdodoreinextrafeet
  \ifvoid\sideins\else\sidecontents\fi
  \ifvbox\@kludgeins\insert\@kludgeins{\unvbox\@kludgeins}\fi}
\newcommand{\p@pdodoreinextrafeet}{%
  \ifvoid\footinsv@r\else\insert\footinsv@r{\unvbox\footinsv@r}\fi
  \extrafeetreinshook}
\newcommand{\extrafeetreinshook}{}

\newcommand{\foottextfont}{\footnotesize}
\newlength{\footinsdim}
  \setlength{\footinsdim}{8in}   % standard for \dimen\footins
\newcommand{\@preamfntext}{%
  \interlinepenalty\interfootnotelinepenalty
  \floatingpenalty \@MM
  \splittopskip=\footnotesep
  \splitmaxdepth=\dp\strutbox
  \@parboxrestore}

\renewcommand{\@footnotetext}[1]{\insert\footins{%
  \foottextfont
  \@preamfntext
  \hsize\columnwidth
  \protected@edef\@currentlabel{%
    \csname p@footnote\endcsname\@thefnmark}%
  \color@begingroup
    \@makefntext{%
      \rule\z@\footnotesep\ignorespaces{\foottextfont #1}%
      \@finalstrut\strutbox}%
  \color@endgroup}\p@pmf@prepare}
\renewcommand{\@mpfootnotetext}[1]{%
  \global\setbox\@mpfootins\vbox{%
    \unvbox\@mpfootins
    \foottextfont \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote\endcsname\@thefnmark}%
  \color@begingroup
    \@makefntext{%
      \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
  \color@endgroup}}

\let\p@pold@footnotetext\@footnotetext
\let\p@pold@mpfootnotetext\@mpfootnotetext

\newcommand{\p@pdoextrafeetmini}{%
  \extrafeetminihook}
\newcommand{\extrafeetminihook}{}
\renewcommand{\@minipagerestore}{\p@pdoextrafeetmini}

\newcommand{\extrafeetendmini}{%
  \ifvoid\@mpfootinsv@r\else
    \vskip\skip\@mpfootins
    \normalcolor\footnoterule\mp@footgroupv@r
  \fi
  \extrafeetendminihook}
\newcommand{\extrafeetendminihook}{}

\newcommand{\p@pdoextrafeetendmini}{\extrafeetendmini}
\def\endminipage{%
  \par
  \unskip
  \ifvoid\@mpfootins\else
    \vskip\skip\@mpfootins
    \normalcolor
    \footnoterule
    \unvbox\@mpfootins
  \fi
  \p@pdoextrafeetendmini
  \@minipagefalse
  \color@endgroup
  \egroup
  \expandafter\@iiiparbox\@mpargs{\unvbox\@tempboxa}}

\newcommand{\plainfootnotes}{%
  \let\@footnotetext\p@pold@footnotetext
  \let\@mpfootnotetext\p@pold@mpfootnotetext}

\newcommand{\newfootnoteseries}[1]{%
  \expandafter\newinsert\csname footins#1\endcsname%  -> \footins#1
  \expandafter\skip\csname footins#1\endcsname \bigskipamount%
%%%                                      - > \skip\footins#1 % [RS]
  \newcounter{footnote#1}%                       -> \c@footnote#1
  \@nameuse{c@footnote#1} \z@%                   -> \c@footnote#1=0
  \global\@namelet{p@footnote#1} \@empty%        -> \p@footnote#1
  \@namedef{thefootnote#1}{\arabic{footnote#1}}% -> \thefootnote#1
  \@namedef{foottextfont#1}{\foottextfont}%      -> \foottextfont#1
  \p@pakefootnote{#1}%                           -> \footnote#1
  \p@pake@xfootnote{#1}%                         -> \@xfootnote#1
  \p@pake@footnotetext{#1}%                      -> \@footnotetext#1
  \p@pakefootnotemark{#1}%                       -> \footnotemark#1
  \p@pake@xfootnotemark{#1}%                     -> \@xfootnotemark#1
  \p@pake@footnotemark{#1}%                      -> \@footnotemark#1
  \p@pakefootnotetext{#1}%                       -> \footnotetext#1
  \p@pake@xfootnotenext{#1}%                     -> \@xfootnotenext#1
  \p@pake@mpfn{#1}%                              -> \@mpfn#1
  \p@pakethempfn{#1}%                            -> \thempfn#1
  \p@pake@makefnmark{#1}%                        -> \@makefnmark#1
  \p@pakefootref{#1}%                            -> \footref#1
  \p@pakefootfootmark{#1}%                       -> \footfootmark#1
  \p@pakemakefootmark{#1}%                       -> \makefootmark#1
  \p@pakefootmarkstyle{#1}%                      -> \footmarkstyle#1
  \@namedef{@makefntext#1}##1{\@nameuse{makefootmark#1} ##1}%
  \p@pake@footstart{#1}%                         -> \@footstart#1
  \p@pake@footgroup{#1}%                         -> \@footgroup#1
  \expandafter\newinsert\csname @mpfootins#1\endcsname% -> \@mpfootins#1
  \newcounter{mpfootnote#1}%                     -> \c@mpfootnote#1
  \global\@namelet{p@mpfootnote#1}\@empty
  \@namedef{thempfootnote#1}{\itshape\alph{mpfootnote#1}}%
  \p@pake@mpfootnotetext{#1}%                    -> \@mpfootnotetext#1
  \ifartopt\else%  [RS]
    \expandafter\@cons\csname cl@chapter\endcsname {{footnote#1}}%
  \fi
  \g@addto@macro{\extrafeetinshook}{%
    \ifvoid\@nameuse{footins#1}\else
      \@nameuse{@footstart#1}\@nameuse{@footgroup#1}\fi}
  \g@addto@macro{\extrafeetreinshook}{%
    \ifvoid\@nameuse{footins#1}\else
      \insert\@nameuse{footins#1}{\unvbox\@nameuse{footins#1}}\fi}
  \g@addto@macro{\extrafeetendminihook}{%
    \ifvoid\@nameuse{@mpfootins#1}\else
      \vskip\skip\@mpfootins
      \normalcolor\footnoterule\@nameuse{mp@footgroup#1}\fi}
  \g@addto@macro{\extrafeetminihook}{%
    \@namedef{@mpfn#1}{mpfootnote#1}
    \@namedef{thempfn#1}{\@nameuse{thempfootnote#1}}
    \csname c@mpfootnote#1\endcsname\z@
     \expandafter\let\expandafter\@t@mp \csname @mpfootnotetext#1\endcsname
     \expandafter\let \csname @footnotetext#1\endcsname \@t@mp}
  \g@addto@macro{\@pup@extranofeet}{%  % [RS]
    \ifvoid\@nameuse{footins#1}\else\@pup@nofootfalse\fi}
  \plainfootstyle{#1}%
}

\newcommand{\p@pakefootnote}[1]{
  \@namedef{footnote#1}{\@ifnextchar[
    {\@nameuse{@xfootnote#1}}{%\advance \@nameuse{c@\@mpfn#1} by \@ne
                              \stepcounter{\@mpfn#1}%
      \@name@p@xdef{@thefnmark#1}{\@nameuse{thempfn#1}}%
      \@nameuse{@footnotemark#1}\@nameuse{@footnotetext#1}}}}

\newcommand{\p@pake@xfootnote}[1]{
  \@namedef{@xfootnote#1}[##1]{%
  \begingroup
    \csname c@\@mpfn#1\endcsname ##1\relax
    \@name@unresp@xdef{@thefnmark#1}{\@nameuse{thempfn#1}}%
  \endgroup
  \@nameuse{@footnotemark#1}\@nameuse{@footnotetext#1}}}

\newcommand{\p@pake@footnotetext}[1]{%
  \@namelongdef{@footnotetext#1}##1{%
  \insert\@nameuse{footins#1}{%
  \@nameuse{foottextfont#1}%
  \@preamfntext
  \hsize\columnwidth
  \protected@edef\@currentlabel{%
    \csname p@footnote#1\endcsname\@nameuse{@thefnmark#1}}%
  \color@begingroup
    \@nameuse{@makefntext#1}{%
      \rule\z@\footnotesep\ignorespaces##1\@finalstrut\strutbox}%
  \color@endgroup}%
  \p@pmf@prepare}}

\newcommand{\p@pake@mpfootnotetext}[1]{%
  \@namelongdef{@mpfootnotetext#1}##1{%
    \global\setbox\@nameuse{@mpfootins#1}\vbox{%
      \unvbox\@nameuse{@mpfootins#1}%
      \@nameuse{foottextfont#1} \hsize\columnwidth \@parboxrestore
      \protected@edef\@currentlabel{%
        \csname p@mpfootnote#1\endcsname\@nameuse{@thefnmark#1}}%
    \color@begingroup
      \@nameuse{@makefntext#1}{%
        \rule\z@\footnotesep\ignorespaces##1\@finalstrut\strutbox}%
    \color@endgroup}%
    \p@pmf@prepare}}

\newcommand{\p@pakefootnotemark}[1]{
\@namedef{footnotemark#1}{%
  \@ifnextchar[ {\@nameuse{@xfootnotemark#1}}
    {%\advance\@nameuse{c@footnote#1} by \@ne%
     \stepcounter{footnote#1}%
     \@name@p@xdef{@thefnmark#1}{\@nameuse{thefootnote#1}}%
     \@nameuse{@footnotemark#1}}}}

\newcommand{\p@pake@xfootnotemark}[1]{%
  \@namedef{@xfootnotemark#1}[##1]{%
  \begingroup
    \@nameuse{c@footnote#1} ##1\relax
    \@name@unresp@xdef{@thefnmark#1}{\@nameuse{thefootnote#1}}%
  \endgroup
  \@nameuse{@footnotemark#1}}}

\newcommand{\p@pake@footnotemark}[1]{%
\@namedef{@footnotemark#1}{%
  \leavevmode
  \ifhmode
    \edef\@x@sf{\the\spacefactor}%
    \p@pmf@check
    \nobreak
  \fi
  \@nameuse{@makefnmark#1}%
  \p@pmf@prepare
  \ifhmode\spacefactor\@x@sf\fi
  \relax}}

\newcommand{\p@pakefootmarkstyle}[1]{%
 \@namedef{footmarkstyle#1}##1{%
    \@namedef{footscript#1}####1{##1}}}

\newcommand{\p@pakefootnotetext}[1]{%
\@namedef{footnotetext#1}{%
  \@ifnextchar[  {\@nameuse{@xfootnotenext#1}}%
  {\@name@p@xdef{@thefnmark#1}{\@nameuse{thempfn#1}}%
  \@nameuse{@footnotetext#1}}}}

\newcommand{\p@pake@xfootnotenext}[1]{
\@namedef{@xfootnotenext#1}[##1]{%
  \begingroup
    \csname c@\@mpfn#1\endcsname ##1\relax
    \@name@unresp@xdef{@thefnmark#1}{\@nameuse{thempfn#1}}%
  \endgroup
  \@nameuse{@footnotetext#1}}}

\newcommand{\p@pake@mpfn}[1]{%
  \@namedef{@mpfn#1}{\@nameuse{footnote#1}}}

\newcommand{\p@pakethempfn}[1]{%
  \@namedef{thempfn#1}{\@nameuse{thefootnote#1}}}

\newcommand{\p@pake@makefnmark}[1]{%
  \@namedef{@makefnmark#1}{%
    \hbox{\@textsuperscript{\normalfont\@nameuse{@thefnmark#1}}}}}

\newcommand{\p@pakefootref}[1]{%
  \@namedef{footref#1}##1{%
    \begingroup
      \@name@unresp@xdef{@thefnmark#1}{\ref{##1}}%
    \endgroup
    \@nameuse{@footnotemark#1}}}

\newcommand{\p@pakefootfootmark}[1]{%
  \@namedef{footfootmark#1}{%
    \ifdim\footmarkwidth < \z@
      \llap{\hb@xt@ -\footmarkwidth{%
            \hss\normalfont\@nameuse{footscript#1}%
            {\@nameuse{@thefnmark#1}}}%
            \hspace*{-\footmarkwidth}}%
    \else
      \ifdim\footmarkwidth = \z@
        {\normalfont\@nameuse{footscript#1}{\@nameuse{@thefnmark#1}}}%
      \else
        \hb@xt@\footmarkwidth{%
            \hss\normalfont\@nameuse{footscript#1}%
            {\@nameuse{@thefnmark#1}}}%
      \fi
    \fi}}

\newcommand{\p@pakemakefootmark}[1]{%
  \@namedef{makefootmark#1}##1{%
    \leavevmode
    \parindent \footparindent\noindent
    \leftskip\footmarksep\relax
    \advance\leftskip \footmarkwidth
    \null\nobreak\hskip -\leftskip\relax
    \makefootmarkhook\relax
    \@nameuse{footfootmark#1}##1}}

\newcommand{\p@pake@footgroup}[1]{%
  \@namedef{@footgroup#1}{\unvbox\@nameuse{footins#1}}}

\newcommand{\p@pakemp@footgroup}[1]{%
  \@namedef{mp@footgroup#1}{\unvbox\@nameuse{@mpfootins#1}}}

\newcommand{\p@pake@footstart}[1]{%
  \@namedef{@footstart#1}{%
    \vskip\bigskipamount
    \leftskip=\z@
    \rightskip=\z@
    \footnoterule}}

\newcommand{\plainfootstyle}[1]{%
  \p@pake@footnotetext{#1}%
  \p@pake@footgroup{#1}%
  \p@pake@footstart{#1}%
  \p@pake@mpfootnotetext{#1}%
  \p@pakemp@footgroup{#1}%
  \@nameuse{footmarkstyle#1}{\textsuperscript{##1}}
  \expandafter\dimen\csname footins#1\endcsname=\footinsdim
  \expandafter\count\csname footins#1\endcsname=1000\relax}

\newinsert\footinsv@r
  \skip\footinsv@r\bigskipamount
  \count\footinsv@r=1000 % no magnifcation
  \dimen\footinsv@r=\footinsdim
\p@pake@footstart{v@r}
\newcommand{\@footgroupv@r}{}

\newinsert\@mpfootinsv@r
\newcommand{\mp@footgroupv@r}{}

\newcount\p@p@k \newdimen\p@p@h
\newcommand*{\p@prigidbalance}[3]{\setbox0=\box#1 \p@p@k=#2 \p@p@h=#3
  \@@line{\splittopskip=\p@p@h \vbadness=\@M \hfilneg
  \valign{##\vfill\cr\p@pdosplits}}}
\newcommand*{\p@pdosplits}{\ifnum\p@p@k>0 \noalign{\hfil}\p@psplitoff
  \global\advance\p@p@k-1\cr\p@pdosplits\fi}
\newcommand*{\p@psplitoff}{\dimen0=\ht0
  \divide\dimen0 by\p@p@k \advance\dimen0 by\p@p@h
  \setbox2 \vsplit0 to \dimen0
  \unvbox2 }

\newcommand{\twocolumnfootnotes}{%
  \@namedef{foottextfontv@r}{\foottextfont}%  % [RS]
  \let\@footnotetext\@twocolfootnotetext
  \dimen\footinsv@r=2\footinsdim
  \count\footinsv@r=500\relax
  \p@pake@twocol@footgroup{v@r}%
  \let\@footgroupv@r\@twocol@footgroupv@r
  \let\@mpfootnotetext\@mptwocolfootnotetext
  \p@pake@mptwocol@footgroup{v@r}%
  \let\mp@footgroupv@r\@mptwocol@footgroupv@r}

\newcommand{\@twocolfootnotetext}[1]{\insert\footinsv@r{%
  \foottextfont
  \@preamfntext
  \protected@edef\@currentlabel{%
    \csname p@footnote\endcsname\@thefnmark}%
  \color@begingroup
    \@twocolfootfmt{#1}%
  \color@endgroup}%
  \p@pmf@prepare}

\newcommand{\@preamtwofmt}{%
  \hsize .45\hsize
  \parindent=\z@
  \tolerance=5000\relax
  \raggedright
  \leavevmode}

\newcommand{\@twocolfootfmt}[1]{%
  \@preamtwofmt
  {\footfootmark\strut {\foottextfont #1}\strut\par}\allowbreak}

\newcommand{\@mptwocolfootnotetext}[1]{%
  \global\setbox\@mpfootinsv@r\vbox{%
    \unvbox\@mpfootinsv@r
    \foottextfont \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote\endcsname\@thefnmark}%
  \color@begingroup
    \@twocolfootfmt{#1}%
  \color@endgroup}%
  \p@pmf@prepare}

\newcommand{\twocolumnfootstyle}[1]{%
  \p@pake@twocolfootnotetext{#1}%
  \p@pake@mptwocolfootnotetext{#1}%
  \p@pake@twocolfootfmt{#1}%
  \p@pake@twocol@footgroup{#1}%
  \p@pake@mptwocol@footgroup{#1}%
  \p@pake@footstart{#1}%
  \@namelongdef{@footnotetext#1}##1{%
     \@nameuse{@twocolfootnotetext#1}{##1}}%
  \@namelongdef{@mpfootnotetext#1}##1{%
     \@nameuse{@mptwocolfootnotetext#1}{##1}}%
  \@namedef{@footgroup#1}{\@nameuse{@twocol@footgroup#1}}%
  \@namedef{mp@footgroup#1}{\@nameuse{@mptwocol@footgroup#1}}%
  \expandafter\dimen\csname footins#1\endcsname=2\footinsdim
  \expandafter\count\csname footins#1\endcsname=500\relax}

\newcommand{\p@pake@twocolfootnotetext}[1]{%
  \@namelongdef{@twocolfootnotetext#1}##1{%
    \insert\@nameuse{footins#1}{
    \@nameuse{foottextfont#1}%
    \@preamfntext
    \protected@edef\@currentlabel{%
      \csname p@footnote#1\endcsname \@nameuse{@thefnmark#1}}%
    \color@begingroup
      \@nameuse{@twocolfootfmt#1}{##1}%
    \color@endgroup}%
    \p@pmf@prepare}}

\newcommand{\p@pake@mptwocolfootnotetext}[1]{%
\@namelongdef{@mptwocolfootnotetext#1}##1{%
  \global\setbox\@nameuse{@mpfootins#1}\vbox{%
    \unvbox\@nameuse{@mpfootins#1}
    \@nameuse{foottextfont#1} \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote#1\endcsname\@nameuse{@thefnmark#1}}%
  \color@begingroup
    \@nameuse{@twocolfootfmt#1}{##1}%
  \color@endgroup}%
  \p@pmf@prepare}}

\newcommand{\p@pake@twocolfootfmt}[1]{%
  \@namedef{@twocolfootfmt#1}##1{%
    \@preamtwofmt
    {\@nameuse{footfootmark#1}\strut
     {\@nameuse{foottextfont#1}##1}\strut\par}\allowbreak}}

\newcommand{\p@pake@twocol@footgroup}[1]{%
  \@namedef{@twocol@footgroup#1}{{%
    \@nameuse{foottextfont#1} \splittopskip=\ht\strutbox
     \p@prigidbalance{\@nameuse{footins#1}}{\tw@}{\splittopskip}}}}

\newcommand{\p@pake@mptwocol@footgroup}[1]{%
\@namedef{@mptwocol@footgroup#1}{{%
  \@nameuse{foottextfont#1} \splittopskip=\ht\strutbox
  \p@prigidbalance{\@nameuse{@mpfootins#1}}{\tw@}{\splittopskip}}}}

\newcommand{\threecolumnfootnotes}{%
  \@namedef{foottextfontv@r}{\foottextfont}%  % [RS]
  \let\@footnotetext\@threecolfootnotetext
  \dimen\footinsv@r=3\footinsdim
  \count\footinsv@r=333\relax
  \p@pake@threecol@footgroup{v@r}%
  \let\@footgroupv@r\@threecol@footgroupv@r
  \let\@mpfootnotetext\@mpthreecolfootnotetext
  \p@pake@mpthreecol@footgroup{v@r}%
  \let\mp@footgroupv@r\@mpthreecol@footgroupv@r}

\newcommand{\@threecolfootnotetext}[1]{\insert\footinsv@r{%
  \foottextfont
  \@preamfntext
  \protected@edef\@currentlabel{%
    \csname p@footnote\endcsname\@thefnmark}%
  \color@begingroup
    \@threecolfootfmt{#1}%
  \color@endgroup}%
  \p@pmf@prepare}

\newcommand{\@preamthreefmt}{%
  \hsize .3\hsize
  \parindent=\z@
  \tolerance=5000\relax
  \raggedright
  \leavevmode}

\newcommand{\@threecolfootfmt}[1]{%
  \@preamthreefmt
  {\footfootmark\strut {\foottextfont #1}\strut\par}\allowbreak}

\newcommand{\@mpthreecolfootnotetext}[1]{%
  \global\setbox\@mpfootinsv@r\vbox{%
    \unvbox\@mpfootinsv@r
    \foottextfont \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote\endcsname\@thefnmark}%
  \color@begingroup
    \@threecolfootfmt{#1}%
  \color@endgroup}%
  \p@pmf@prepare}

\newcommand{\threecolumnfootstyle}[1]{%
  \p@pake@threecolfootnotetext{#1}%
  \p@pake@mpthreecolfootnotetext{#1}%
  \p@pake@threecolfootfmt{#1}%
  \p@pake@threecol@footgroup{#1}%
  \p@pake@mpthreecol@footgroup{#1}%
  \p@pake@footstart{#1}%
  \@namelongdef{@footnotetext#1}##1{%
    \@nameuse{@threecolfootnotetext#1}{##1}}%
  \@namelongdef{@mpfootnotetext#1}##1{%
    \@nameuse{@mpthreecolfootnotetext#1}{##1}}%
  \@namedef{@footgroup#1}{\@nameuse{@threecol@footgroup#1}}%
  \@namedef{mp@footgroup#1}{\@nameuse{@mpthreecol@footgroup#1}}%
  \expandafter\dimen\csname footins#1\endcsname=3\footinsdim
  \expandafter\count\csname footins#1\endcsname=333\relax}

\newcommand{\p@pake@threecolfootnotetext}[1]{%
\@namelongdef{@threecolfootnotetext#1}##1{%
  \insert\@nameuse{footins#1}{
  \@nameuse{foottextfont#1}%
  \@preamfntext
  \protected@edef\@currentlabel{%
    \csname p@footnote#1\endcsname \@nameuse{@thefnmark#1}}%
  \color@begingroup
    \@nameuse{@threecolfootfmt#1}{##1}%
  \color@endgroup}%
  \p@pmf@prepare}}

\newcommand{\p@pake@mpthreecolfootnotetext}[1]{%
\@namelongdef{@mpthreecolfootnotetext#1}##1{%
  \global\setbox\@nameuse{@mpfootins#1}\vbox{%
    \unvbox\@nameuse{@mpfootins#1}
    \@nameuse{foottextfont#1} \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote#1\endcsname\@nameuse{@thefnmark#1}}%
  \color@begingroup
    \@nameuse{@threecolfootfmt#1}{##1}%
  \color@endgroup}%
  \p@pmf@prepare}}

\newcommand{\p@pake@threecolfootfmt}[1]{%
\@namelongdef{@threecolfootfmt#1}##1{%
  \@preamthreefmt
  {\@nameuse{footfootmark#1}\strut
   {\@nameuse{foottextfont#1}##1}\strut\par}\allowbreak}}

\newcommand{\p@pake@threecol@footgroup}[1]{%
\@namedef{@threecol@footgroup#1}{{%
  \@nameuse{foottextfont#1} \splittopskip=\ht\strutbox
  \p@prigidbalance{\@nameuse{footins#1}}{\thr@@}{\splittopskip}}}}

\newcommand{\p@pake@mpthreecol@footgroup}[1]{%
\@namedef{@mpthreecol@footgroup#1}{{%
  \@nameuse{foottextfont#1} \splittopskip=\ht\strutbox
  \p@prigidbalance{\@nameuse{@mpfootins#1}}{\thr@@}{\splittopskip}}}}

\newcommand{\p@punvxh}[1]{%
  \setbox0=\vbox{\unvbox#1%
    \global\setbox1=\lastbox}%
  \unhbox1
  \unskip
  \unskip
  \unpenalty
  \hskip\p@pipn@skip}

\newcommand{\p@pungebox}{%
  \setbox0=\hbox{\p@punvxh0}%
  \dp0=\z@
  \ht0=\footfudgefactor\wd0
  \box0
  \penalty0}

\newskip\p@pipn@skip
\newcommand*{\p@pinterparanoteglue}[1]{%
  {\foottextfont\global\p@pipn@skip=#1\relax}}
\p@pinterparanoteglue{1em plus.4em minus.4em}

\newcommand*{\p@pmakehboxofhboxes}{\setbox0=\hbox{}%
  \loop
    \unpenalty
    \setbox2=\lastbox
  \ifhbox2
    \setbox0=\hbox{\box2\unhbox0}
  \repeat}

\newcommand*{\p@premovehboxes}{\setbox0=\lastbox
  \ifhbox0{\p@premovehboxes}\unhbox0 \fi}

\newcommand*{\footfudgefiddle}{64}

\newcommand{\paragraphfootnotes}{%
  \@namedef{foottextfontv@r}{\foottextfont}%  % [RS]
  \let\@footnotetext\@parafootnotetext
  \dimen\footinsv@r=\footinsdim
  \count\footinsv@r=1000\relax
  \p@pake@para@footgroup{v@r}%
  \let\@footgroupv@r\@para@footgroupv@r
  \let\@mpfootnotetext\@mpparafootnotetext
  \p@pake@mppara@footgroup{v@r}%
  \let\mp@footgroupv@r\@mppara@footgroupv@r
  {\foottextfont
   \dimen0=\baselineskip
   \multiply\dimen0 by 1024
   \divide\dimen0 by \hsize \multiply\dimen0 by \footfudgefiddle
   \xdef\footfudgefactor{\expandafter\strip@pt\dimen0 }}}

\newcommand{\@parafootnotetext}[1]{\insert\footinsv@r{
  \foottextfont
  \@preamfntext
  \protected@edef\@currentlabel{%
    \csname p@footnote\endcsname\@thefnmark}%
  \setbox0=\vbox{\hsize=\maxdimen
    \color@begingroup
      \noindent \@parafootfmt{#1}%
    \color@endgroup}%
  \p@pungebox}%
  \p@pmf@prepare}

\newcommand{\@parafootfmt}[1]{%
  \parindent=\z@
  \parfillskip=0pt \@plus 1fil
  {\footfootmark\strut {\foottextfont #1}\penalty-10}}

\newcommand{\@mpparafootnotetext}[1]{%
  \global\setbox\@mpfootinsv@r\vbox{%
    \unvbox\@mpfootinsv@r
    \foottextfont \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote\endcsname\@thefnmark}%
    \setbox0=\vbox{\hsize=\maxdimen
      \color@begingroup
      \noindent \@parafootfmt{#1}%
      \color@endgroup}%
  \p@pungebox}%
  \p@pmf@prepare}

\newcommand{\paragraphfootstyle}[1]{%
  \p@pake@parafootnotetext{#1}%
  \p@pake@mpparafootnotetext{#1}%
  \p@pake@parafootfmt{#1}%
  \p@pake@para@footgroup{#1}%
  \p@pake@mppara@footgroup{#1}%
  \p@pake@para@footstart{#1}%
  \@namelongdef{@footnotetext#1}##1{%
    \@nameuse{@parafootnotetext#1}{##1}}%
  \@namelongdef{@mpfootnotetext#1}##1{%
    \@nameuse{@mpparafootnotetext#1}{##1}}%
  \@namedef{@footgroup#1}{\@nameuse{@para@footgroup#1}}%
  \@namedef{mp@footgroup#1}{\@nameuse{@mppara@footgroup#1}}%
  \@namedef{@footstart#1}{\@nameuse{@para@footstart#1}}%
  \expandafter\dimen\csname footins#1\endcsname=\footinsdim
  \expandafter\count\csname footins#1\endcsname=1000\relax
  {\@nameuse{foottextfont#1}%
   \dimen0=\baselineskip
   \multiply\dimen0 by 1024
   \divide\dimen0 by \hsize \multiply\dimen0 by 64
   \xdef\footfudgefactor{\expandafter\strip@pt\dimen0 }}}

\newcommand{\p@pake@parafootnotetext}[1]{%
\@namelongdef{@parafootnotetext#1}##1{%
  \insert\@nameuse{footins#1}{
  \@nameuse{foottextfont#1}%
  \@preamfntext
  \protected@edef\@currentlabel{%
    \csname p@footnote#1\endcsname \@nameuse{@thefnmark#1}}%
  \setbox0=\vbox{\hsize=\maxdimen
    \color@begingroup
      \noindent \@nameuse{@parafootfmt#1}{##1}%
    \color@endgroup}%
  \p@pungebox}%
  \p@pmf@prepare}}

\newcommand{\p@pake@mpparafootnotetext}[1]{%
\@namelongdef{@mpparafootnotetext#1}##1{%
  \global\setbox\@nameuse{@mpfootins#1}\vbox{%
    \unvbox\@nameuse{@mpfootins#1}
    \@nameuse{foottextfont#1} \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote#1\endcsname\@nameuse{@thefnmark#1}}%
    \setbox0=\vbox{\hsize=\maxdimen
      \color@begingroup
        \noindent \@nameuse{@parafootfmt#1}{##1}%
      \color@endgroup}%
    \p@pungebox}%
    \p@pmf@prepare}}

\newcommand{\p@pake@parafootfmt}[1]{%
\@namelongdef{@parafootfmt#1}##1{%
  \parindent=\z@
  \parfillskip=0pt \@plus 1fil
  {\@nameuse{footfootmark#1}\strut
   {\@nameuse{foottextfont#1}##1}\penalty-10}}}

\newcommand{\p@pake@para@footgroup}[1]{%
\@namedef{@para@footgroup#1}{%
  \unvbox\@nameuse{footins#1}
  \p@pmakehboxofhboxes
  \setbox0=\hbox{\unhbox0 \p@premovehboxes}%
  \@nameuse{foottextfont#1}%
  \noindent\unhbox0\par}}

\newcommand{\p@pake@mppara@footgroup}[1]{%
\@namedef{@mppara@footgroup#1}{%
  \unvbox\@nameuse{@mpfootins#1}
  \p@pmakehboxofhboxes
  \setbox0=\hbox{\unhbox0 \p@premovehboxes}%
  \@nameuse{foottextfont#1}%
  \noindent\unhbox0\par}}

\newcommand{\p@pake@para@footstart}[1]{%
\@namedef{@para@footstart#1}{%
  \vskip\bigskipamount
  \leftskip=\z@
  \rightskip=\z@
  \parindent=\z@
  \vskip\skip\@nameuse{footins#1}%
  \footnoterule}}

\newif\ifchangemarks\changemarksfalse
\newcommand{\v@rid}[2]{%
  \@bsphack
  \ifchangemarks
     \ifdraftdoc
       \marginpar[#1]{#2}%
  \fi\fi
  \@esphack}

\newcommand{\added}[1]{%
  \@bsphack
  \ifchangemarks
    \v@rid{\small$\oplus$ #1}{\small$\oplus$ #1}%
  \fi
  \@esphack}
\newcommand{\deleted}[1]{%
  \@bsphack
  \ifchangemarks
    \v@rid{\small$\neq$ #1}{\small$\neq$ #1}%
  \fi
  \@esphack}
\newcommand{\changed}[1]{%
  \@bsphack
  \ifchangemarks
    \v@rid{\small$\Leftrightarrow$ #1}{\small$\Leftrightarrow$ #1}%
  \fi
  \@esphack}

\newcommand*{\trimmark}{%
  \begin{picture}(0,0)
    \unitlength 1cm
    \thinlines
    \put(-2,0){\line(1,0){4}}
    \put(0,-2){\line(0,1){4}}
  \end{picture}}

\newcommand*{\Ltrimpictl}{%
  \begin{picture}(0,0)
    \unitlength 1mm
    \thinlines
    \put(-2,0){\line(-1,0){18}}
    \put(0,2){\line(0,1){18}}
  \end{picture}}
\newcommand*{\Ltrimpictr}{%
  \begin{picture}(0,0)
    \unitlength 1mm
    \thinlines
    \put(2,0){\line(1,0){18}}
    \put(0,2){\line(0,1){18}}
  \end{picture}}
\newcommand*{\Ltrimpicbl}{%
  \begin{picture}(0,0)
    \unitlength 1mm
    \thinlines
    \put(-2,0){\line(-1,0){18}}
    \put(0,-2){\line(0,-1){18}}
  \end{picture}}
\newcommand*{\Ltrimpicbr}{%
  \begin{picture}(0,0)
    \unitlength 1mm
    \thinlines
    \put(2,0){\line(1,0){18}}
    \put(0,-2){\line(0,-1){18}}
  \end{picture}}

\newcommand*{\Ftrimpicbl}{%
  \begin{picture}(0,0)
    \unitlength 1pt
    \thinlines
    \put(0,0){\framebox(\strip@pt\paperwidth,\strip@pt\paperheight){}}
  \end{picture}}

\newcommand*{\tmarktl}{\trimmark}
\newcommand*{\tmarktr}{\trimmark}
\newcommand*{\tmarkbl}{\trimmark}
\newcommand*{\tmarkbr}{\trimmark}

\newcommand*{\tmarktm}{}
\newcommand*{\tmarkml}{}
\newcommand*{\tmarkmr}{}
\newcommand*{\tmarkbm}{}

\newcommand*{\trimXmarks}{%
  \let\tmarktl\trimmark
  \let\tmarktr\trimmark
  \let\tmarkbl\trimmark
  \let\tmarkbr\trimmark
}
\newcommand*{\trimLmarks}{%
  \let\tmarktl\Ltrimpictl
  \let\tmarktr\Ltrimpictr
  \let\tmarkbl\Ltrimpicbl
  \let\tmarkbr\Ltrimpicbr
}
\newcommand*{\trimFrame}{%
  \let\tmarktl\null
  \let\tmarktr\null
  \let\tmarkbl\Ftrimpicbl
  \let\tmarkbr\null
}
\newcommand*{\trimNone}{%
  \let\tmarktl\relax
  \let\tmarktr\relax
  \let\tmarkbl\relax
  \let\tmarkbr\relax
  \let\tmarktm\relax
  \let\tmarkml\relax
  \let\tmarkmr\relax
  \let\tmarkbm\relax
}

\newcommand*{\trimmarks}{%
  \vbox to \z@{\vskip-1in \vskip\trimtop % top of logical page
    \hb@xt@\z@{\hskip-1in
      \ifodd\c@page
        \hskip\stockwidth \hskip-\trimedge \hskip-\paperwidth
      \else
        \if@twoside
          \hskip\trimedge  % left of logical page
        \else
          \hskip\stockwidth \hskip-\trimedge \hskip-\paperwidth
        \fi
      \fi
      \vbox to \paperheight{%
        \let\protect\relax        % <- v1.4 addition
        \hb@xt@\paperwidth{\tmarktl\hfil\tmarktm\hfil\tmarktr}%
        \vfil
        \hb@xt@\paperwidth{\tmarkml\hfil\tmarkmr}%
        \vfil
        \hb@xt@\paperwidth{\tmarkbl\hfil\tmarkbm\hfil\tmarkbr}}%
    \hss}%
  \vss}}

\newcounter{sheetsequence}
  \setcounter{sheetsequence}{1}
  \renewcommand{\thesheetsequence}{\@arabic\c@sheetsequence}
\g@addto@macro{\@outputpage}{\stepcounter{sheetsequence}}

\newcounter{lastsheet}
  \setcounter{lastsheet}{0}
\newcounter{lastpage}
  \setcounter{lastpage}{0}
\newcommand{\dol@stsheet}{%
  \if@filesw
    \addtocounter{sheetsequence}{-1}%
    \immediate\write\@auxout%
      {\string\setcounter{lastsheet}{\the\c@sheetsequence}}%
    \stepcounter{sheetsequence}%
  \fi}
\newcommand{\dol@stpage}{%
  \if@filesw
    \addtocounter{page}{-1}%
    \immediate\write\@auxout%
      {\string\setcounter{lastpage}{\the\c@page}}%
    \stepcounter{page}%
  \fi}
\AtBeginDocument{\AtEndDocument{\clearpage\dol@stsheet\dol@stpage}}

\let\pup@oldshipout\shipout
\newcommand*{\pup@shipi}{%
  \ifvoid\@cclv\expandafter\aftergroup\fi\pup@shipii}
\newcommand*\pup@shipii{%
  \ifvoid\@cclv
    \pup@oldshipout\box\@cclv
  \else
    \pup@oldshipout\vbox{\trimmarks\unvbox\@cclv}%
  \fi}
\ifshowtrims
  \renewcommand*{\shipout}{\afterassignment\pup@shipi\setbox\@cclv=}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newtoks\every@verbatim
  \every@verbatim={}
\newtoks\afterevery@verbatim
  \afterevery@verbatim={}

\def\@makeother#1{\catcode`#112\relax}
\begingroup
 \catcode`\ =\active%
 \def\x{\def\@vobeyspaces{\catcode`\ \active\let \@xobeysp}}
 \expandafter\endgroup\x
\def\@xobeysp{\leavevmode\penalty\@M\ }
\newtoks\verbatim@line
\newcount\tab@position
\def\@xobeytab{%
  \loop
    \toks@\expandafter{\the\toks@\@xobeysp}%
    \advance\tab@position-1
  \ifnum\tab@position>0 \repeat
}
\begingroup
  \catcode`\^^I=\active
  \gdef\@vobeytabs{\catcode`\^^I\active\let^^I\@xobeytab}%
\endgroup
\def\verbatim@tabexpand#1{%
  \ifx#1\@nil
    \the\toks@
    \expandafter\par
  \else
    \ifx#1\@xobeytab
      \@xobeytab
    \else
      \toks@\expandafter{\the\toks@#1}%
      \advance\tab@position\m@ne
    \fi
    \ifnum\tab@position=0 \tab@position\tab@size \fi
    \expandafter\verbatim@tabexpand
  \fi
}

\newif\ift@bs
\newcommand{\tabson}[1][4]{%
  \ifnum\@ne > #1\relax
    \tabsoff
  \else
    \t@bstrue
    \def\tab@size{#1\relax}%
    \def\@maybeobeytabs{\@vobeytabs}%
  \fi
}
\newcommand{\tabsoff}{%
  \t@bsfalse
  \def\tab@size{\z@}%
  \def\@maybeobeytabs{}%
}
\tabsoff

\def\tabverbatim@processline{\tab@position\tab@size
  \toks@{}%
  \expandafter\verbatim@tabexpand\the\verbatim@line\@nil}
\def\notabverbatim@processline{\the\verbatim@line\par}

\def\verbatim@startline{\verbatim@line{}}
\def\verbatim@addtoline#1{%
  \verbatim@line\expandafter{\the\verbatim@line#1}}
\def\verbatim@processline{\notabverbatim@processline}
\def\verbatim@finish{\ifcat$\the\verbatim@line$\else
  \verbatim@processline\fi}
\newcommand{\setverbatimfont}[1]{\def\p@pverbfont{#1}}
\setverbatimfont{\normalfont\ttfamily}

\def\verbatim@font{\p@pverbfont
                   \hyphenchar\font\m@ne
                   \let\do\do@noligs
                   \verbatim@nolig@list}

\def\@verbatim{\the\every@verbatim
  \trivlist \item \relax
  \if@minipage\else\vskip\parskip\fi
  \@beginparpenalty \predisplaypenalty
  \leftskip\@totalleftmargin\rightskip\z@
  \parindent\z@\parfillskip\@flushglue\parskip\z@
  \@@par
  \def\par{%
    \if@tempswa
      \leavevmode\null\@@par\penalty\interlinepenalty
    \else
      \@tempswatrue
      \ifhmode\@@par\penalty\interlinepenalty\fi
    \fi}%
  \def\@noitemerr{\@warning{No verbatim text}}%
  \obeylines
  \let\do\@makeother \dospecials
  \verbatim@font
  \everypar \expandafter{\the\everypar \unpenalty}%
  \wrapright\the\afterevery@verbatim}
\def\verbatim{\begingroup
  \ift@bs
    \def\verbatim@processline{\tabverbatim@processline}%
  \fi
  \@verbatim \frenchspacing\@vobeyspaces\@maybeobeytabs\verbatim@start}
\@namedef{verbatim*}{\begingroup
  \ift@bs
    \def\verbatim@processline{\tabverbatim@processline}%
  \fi
  \@verbatim\@maybeobeytabs\verbatim@start}
\def\endverbatim{\endtrivlist\endgroup\@doendpe}
\@namelet{endverbatim*}\endverbatim

\newcommand{\setupcomment}{%
  \let\do\@makeother\dospecials\catcode`\^^M\active
  \let\verbatim@startline\relax
  \let\verbatim@addtoline\@gobble
  \let\verbatim@processline\relax
  \let\verbatim@finish\relax}
\newcommand{\newcomment}[1]{%
  \expandafter\def\csname #1\endcsname{\@bsphack\setupcomment\verbatim@}%
  \expandafter\let\csname end#1\endcsname=\@esphack}
\newcommand{\commentsoff}[1]{%
  \expandafter\def\csname #1\endcsname{}%
  \expandafter\def\csname end#1\endcsname{}}
\newcommand{\commentson}[1]{\newcomment{#1}}

\newcomment{comment}

\@ifundefined{vrb@catcodes}%
  {\def\vrb@catcodes{%
     \catcode`\!12\catcode`\[12\catcode`\]12}}{}
\begingroup
 \vrb@catcodes
 \lccode`\!=`\\ \lccode`\[=`\{ \lccode`\]=`\}
 \catcode`\~=\active \lccode`\~=`\^^M
 \lccode`\C=`\C
 \lowercase{\endgroup
    \def\verbatim@start#1{%
      \verbatim@startline
      \if\noexpand#1\noexpand~%
        \let\next\verbatim@
      \else \def\next{\verbatim@#1}\fi
      \next}%
    \def\verbatim@#1~{\verbatim@@#1!end\@nil}%
    \def\verbatim@@#1!end{%
       \verbatim@addtoline{#1}%
       \futurelet\next\verbatim@@@}%
    \def\verbatim@@@#1\@nil{%
       \ifx\next\@nil
         \verbatim@processline
         \verbatim@startline
         \let\next\verbatim@
       \else
         \def\@tempa##1!end\@nil{##1}%
         \@temptokena{!end}%
         \def\next{\expandafter\verbatim@test\@tempa#1\@nil~}%
       \fi \next}%
    \def\verbatim@test#1{%
           \let\next\verbatim@test
           \if\noexpand#1\noexpand~%
             \expandafter\verbatim@addtoline
               \expandafter{\the\@temptokena}%
             \verbatim@processline
             \verbatim@startline
             \let\next\verbatim@
           \else \if\noexpand#1
             \@temptokena\expandafter{\the\@temptokena#1}%
           \else \if\noexpand#1\noexpand[%
             \let\@tempc\@empty
             \let\next\verbatim@testend
           \else
             \expandafter\verbatim@addtoline
               \expandafter{\the\@temptokena}%
             \def\next{\verbatim@#1}%
           \fi\fi\fi
           \next}%
    \def\verbatim@testend#1{%
         \if\noexpand#1\noexpand~%
           \expandafter\verbatim@addtoline
             \expandafter{\the\@temptokena[}%
           \expandafter\verbatim@addtoline
             \expandafter{\@tempc}%
           \verbatim@processline
           \verbatim@startline
           \let\next\verbatim@
         \else\if\noexpand#1\noexpand]%
           \let\next\verbatim@@testend
         \else\if\noexpand#1\noexpand!%
           \expandafter\verbatim@addtoline
             \expandafter{\the\@temptokena[}%
           \expandafter\verbatim@addtoline
             \expandafter{\@tempc}%
           \def\next{\verbatim@!}%
         \else \expandafter\def\expandafter\@tempc\expandafter
           {\@tempc#1}\fi\fi\fi
         \next}%
    \def\verbatim@@testend{%
       \ifx\@tempc\@currenvir
         \verbatim@finish
         \edef\next{\noexpand\end{\@currenvir}%
                    \noexpand\verbatim@rescan{\@currenvir}}%
       \else
         \expandafter\verbatim@addtoline
           \expandafter{\the\@temptokena[}%
           \expandafter\verbatim@addtoline
             \expandafter{\@tempc]}%
         \let\next\verbatim@
       \fi
       \next}%
    \def\verbatim@rescan#1#2~{\if\noexpand~\noexpand#2~\else
        \@warning{Characters dropped after `\string\end{#1}'}\fi}}
\newread\verbatim@in@stream
\def\verbatim@readfile#1{%
  \verbatim@startline
  \openin\verbatim@in@stream #1\relax
  \ifeof\verbatim@in@stream
    \typeout{No file #1.}%
  \else
    \@addtofilelist{#1}%
    \ProvidesFile{#1}[(verbatim)]%
    \expandafter\endlinechar\expandafter\m@ne
    \expandafter\verbatim@read@file
    \expandafter\endlinechar\the\endlinechar\relax
    \closein\verbatim@in@stream
  \fi
  \verbatim@finish
}
\def\verbatim@read@file{%
  \read\verbatim@in@stream to\next
  \ifeof\verbatim@in@stream
  \else
    \expandafter\verbatim@addtoline\expandafter{\next}%
    \verbatim@processline
    \verbatim@startline
    \expandafter\verbatim@read@file
  \fi
}
\def\verbatiminput{\begingroup
  \ift@bs
    \def\verbatim@processline{\tabverbatim@processline}%
  \fi
  \@ifstar{\verbatim@input{\@maybeobeytabs}}%
          {\verbatim@input{\frenchspacing\@vobeyspaces\@maybeobeytabs}}}
\def\verbatim@input#1#2{%
   \IfFileExists {#2}{\@verbatim #1\relax
    \verbatim@readfile{\@filef@und}\endtrivlist\endgroup\@doendpe}%
   {\typeout {No file #2.}\endgroup}}
\newlength{\verbatimindent}
  \setlength{\verbatimindent}{3em}
\newcommand*{\verbatimbreakchar}{\char`\%}
\newcommand*{\setverbatimbreak}{%
  \vspace*{-\baselineskip}%
  \def\@xobeysp{~\discretionary{\verbatimbreakchar}%
    {\kern\verbatimindent}{}}%
}

\newcommand{\wrappingon}{%
  \def\@xobeysp{~\discretionary{\verbatimbreakchar}%
    {\kern\verbatimindent}{}}%
  \def\wrapright{\raggedright}%
}
\newcommand{\wrappingoff}{%
  \def\@xobeysp{\leavevmode\penalty\@M\ }%
  \def\wrapright{}%
}
\wrappingoff

\newwrite \verbatim@out
\def\verbatimoutput#1{%
  \@bsphack
  \immediate\openout \verbatim@out #1
  \let\do\@makeother\dospecials
  \catcode`\^^M\active %% \catcode`\^^I=12
  \def\verbatim@processline{%
    \immediate\write\verbatim@out
      {\the\verbatim@line}}%
  \verbatim@start}
\def\endverbatimoutput{%
  \immediate\closeout\verbatim@out
  \@esphack}
\def\fboxverbatim{\begingroup%
  \tabsoff %% PW otherwise box fills the width
  \def\verbatim@processline{%
    {\setbox0=\hbox{\the\verbatim@line}%
    \hsize=\wd0 \the\verbatim@line\par}}%
  \@minipagetrue%%%DPC%%%
  \@tempswatrue%%%DPC%%%
  \setbox0=\vbox\bgroup \verbatim
}
\def\endfboxverbatim{%
  \endverbatim
  \unskip\setbox0=\lastbox %%%DPC%%%
  \egroup
  \fbox{\box0}% <<<=== change here for centering,...
\endgroup}
\def\MakeShortVerb#1{%
  \expandafter\ifx\csname cc\string#1\endcsname\relax
    \@shortvrbinfo{Made }{#1}%
    \add@special{#1}%
    \expandafter
    \xdef\csname cc\string#1\endcsname{\the\catcode`#1}%
    \begingroup
      \catcode`\~\active  \lccode`\~`#1%
      \lowercase{%
      \global\expandafter\let
         \csname ac\string#1\endcsname~%
      \gdef~{\verb~}}%
    \endgroup
    \global\catcode`#1\active
  \else
    \@shortvrbinfo\@empty{#1 already}%
  \fi}
\def\DeleteShortVerb#1{%
  \expandafter\ifx\csname cc\string#1\endcsname\relax
  \else
    \@shortvrbinfo{Deleted }{#1 as}%
    \rem@special{#1}%
    \global\catcode`#1\csname cc\string#1\endcsname
    \global \expandafter\let \csname cc\string#1\endcsname \relax
    \ifnum\catcode`#1=\active
      \begingroup
        \catcode`\~\active   \lccode`\~`#1%
        \lowercase{%
          \global\expandafter\let\expandafter~%
          \csname ac\string#1\endcsname}%
      \endgroup \fi \fi}
\def\@shortvrbinfo#1#2{%
  \PackageInfo{shortvrb}{%
     #1\expandafter\@gobble\string#2 a short reference
                                          for \string\verb}}
\def\add@special#1{%
  \rem@special{#1}%
  \expandafter\gdef\expandafter\dospecials\expandafter
    {\dospecials \do #1}%
  \expandafter\gdef\expandafter\@sanitize\expandafter
    {\@sanitize \@makeother #1}}
\def\rem@special#1{%
  \def\do##1{%
    \ifnum`#1=`##1 \else \noexpand\do\noexpand##1\fi}%
  \xdef\dospecials{\dospecials}%
  \begingroup
    \def\@makeother##1{%
      \ifnum`#1=`##1 \else \noexpand\@makeother\noexpand##1\fi}%
    \xdef\@sanitize{\@sanitize}%
  \endgroup}
\newcommand{\linenumberfont}[1]{\def\vlvnumfont{#1}}
%%% \linenumberfont{\small\rmfamily}

\newcommand{\linenumberfrequency}[1]{%
  \ifnum #1< \@ne
    \def\linemodnum{0\relax}
    \bvcountlinesfalse
  \else
    \def\linemodnum{#1\relax}
    \bvcountlinestrue
  \fi
}
%%%%\linenumberfrequency{0}

\newcommand{\getthelinenumber}[1]{%
  \ifnum\@ne=\linemodnum
     \@nameuse{the#1}
  \else
    \ifnum\@ne<\linemodnum
      \@tempcnta=\@nameuse{c@#1}
      \divide\@tempcnta\linemodnum \multiply\@tempcnta\linemodnum
      \ifnum\@tempcnta=\@nameuse{c@#1}\@nameuse{the#1}\fi
    \fi
  \fi
}

\def\boxverbflag{14 }
\newlength{\bvboxsep}      % user can change this
\setlength{\bvboxsep}{1em}

\newif\ifbvperpage % start/end lines on every page of multipage verbatim
\bvperpagetrue

\newcommand{\bvtopofpage}[1]{%
  \long\def\b@vtop{#1}
}
\def\b@vtop{}  % used in \boxverb@split for heading

\newcounter{bvlinectr}
\def\theb@vlinenumber{\getthelinenumber{bvlinectr}}
\newcommand{\resetbvlinenumber}{\setcounter{bvlinectr}{0}}

\newif\ifbvcountlines   % TRUE to print line numbers of verbatim lines
  \bvcountlinesfalse
\def\b@vdocount{\ifbvcountlines\stepcounter{bvlinectr}\fi}
\newlength{\bvnumlength}
%% \settowidth{\bvnumlength}{\vlvnumfont 9999}
\settowidth{\bvnumlength}{\normalfont 999}

\newif\ifbvcountinside  % TRUE if line numbers inside box
  \bvcountinsidetrue
\newcommand{\bvnumbersinside}{\bvcountinsidetrue}
\newcommand{\bvnumbersoutside}{\bvcountinsidefalse}

\def\b@vdoinside{%
  \ifbvcountlines\ifbvcountinside%
    \makebox[\bvnumlength][r]{%
      \vlvnumfont \theb@vlinenumber\space}%
  \fi\fi}

\def\b@vdooutside{%
  \ifbvcountlines\ifbvcountinside\else%
    \llap{\makebox[\bvnumlength][r]{%
      \vlvnumfont \theb@vlinenumber\space}}%
  \fi\fi}

\newcommand{\setupboxverb@line}{%
  \par
  \ifbvperpage
    \output=\expandafter{\expandafter\boxverb@split \the\output}
  \fi
  \def\verbatim@processline{\leavevmode
    \b@vdocount%
    \bvleftsidehook\vbox{\advance\hsize-.8\p@ \@@line
      {\b@vdooutside\strut\kern\bvboxsep%
       \b@vdoinside%
       \ift@bs
         \tabverbatim@processline
       \else
         \the\verbatim@line
       \fi
       \hss}%
     \kern\bvboxsep}\bvrightsidehook\par}%
}

\newcommand{\setupbox@verb}{%
  \leftskip\z@skip \rightskip\z@skip
  \interlinepenalty\boxverbflag
  \parfillskip\z@ plus\p@ minus\p@
  \lineskip-\bvboxsep \baselineskip\z@skip
  \frenchspacing\@vobeyspaces\@maybeobeytabs
  \boxverb@toprule
}

\def\boxedverbatim{\begingroup
  \setupboxverb@line
  \@verbatim
  \setupbox@verb
  \verbatim@start
}
\def\endboxedverbatim{\bvendrulehook\endtrivlist\endgroup\@doendpe}

\@namedef{boxedverbatim*}{\let\frenchspacing\@gobble \boxedverbatim}
\@namelet{endboxedverbatim*}\endboxverbatim

\def\boxverb@toprule{\bvtoprulehook
  \@@line{\bvleftsidehook \bvtopmidhook \bvrightsidehook}}

\newcommand*{\bvendofpage}[1]{%
  \def\boxverb@botpage{#1}}
\bvendofpage{\hrule\kern-.4pt}

\def\boxverb@split{\ifnum\outputpenalty=\boxverbflag
  \ifdim\dp\@cclv=\z@
%%%%    \setbox\@cclv\vbox{\unvbox\@cclv\hrule\kern-.4pt}%
    \setbox\@cclv\vbox{\unvbox\@cclv\boxverb@botpage}%
    \null \kern-.7\topskip \b@vtop \boxverb@toprule
  \fi
\fi}

\def\bvtoprulehook{\hrule \nobreak \vskip-.1\p@}
\def\bvendrulehook{\hrule}
\def\bvleftsidehook{\vrule}
\def\bvrightsidehook{\vrule}
\def\bvtopmidhook{\rule{0\p@}{2\bvboxsep} \hss}

\newcommand{\boxedverbatiminput}{\begingroup
  \@ifstar{\let\frenchspacing\@gobble
           \boxedverbatim@input\relax}%
          {\boxedverbatim@input{\frenchspacing\@vobeyspaces}}}

\def\boxedverbatim@input#1#2{%
  \setupboxverb@line
  \IfFileExists{#2}{\@verbatim #1\relax
  \setupbox@verb
    \verbatim@readfile{\@filef@und}%
      \bvendrulehook\endtrivlist\endgroup\@doendpe}%
  {\typeout {No file #2.}\endgroup}}

\newcommand{\bvbox}{%
  \bvperpagetrue%
  \renewcommand{\bvtoprulehook}{\hrule \nobreak \vskip-.1\p@}%
  \renewcommand{\bvleftsidehook}{\vrule}%
  \renewcommand{\bvrightsidehook}{\vrule}%
  \renewcommand{\bvendrulehook}{\hrule}%
}

\newcommand{\nobvbox}{%
  \bvperpagefalse%
  \renewcommand{\bvtoprulehook}{}%
  \renewcommand{\bvleftsidehook}{}%
  \renewcommand{\bvrightsidehook}{}%
  \renewcommand{\bvendrulehook}{}%
}

\newcommand{\bvtopandtail}{%
  \bvperpagefalse%
  \renewcommand{\bvtoprulehook}{\hrule \nobreak \vskip-.1\p@}%
  \renewcommand{\bvleftsidehook}{}%
  \renewcommand{\bvrightsidehook}{}%
  \renewcommand{\bvendrulehook}{\hrule}%
}

\newcommand{\bvsides}{%
  \bvperpagefalse%
  \renewcommand{\bvtoprulehook}{\vskip 3ex}%
  \renewcommand{\bvleftsidehook}{\vrule}%
  \renewcommand{\bvrightsidehook}{\vrule}%
  \renewcommand{\bvendrulehook}{}%
}

\let\framed\relax \let\endframed\relax
\let\shaded\relax \let\endshaded\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BEGIN FRAMED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PW -- can't have \ProvidesPpackage
%%\ProvidesPackage{framed}[2003/07/21 v 0.8a:
%%    framed or shaded text with page breaks]

%% PW added \ifframeasnormal % TRUE normal paras, FALSE minipage paras
%% PW default is (FALSE to match DA v0.5, or TRUE to match DA v0.6)
\newif\ifframeasnormal
  \frameasnormaltrue

%% PW Define some things AtBeginDocument if they have not already
%%    been defined via someone using the framed package.
\AtBeginDocument{\@ifundefined{framed}{%
\def\endMakeFramed{\par
     \kern\z@ \penalty-100 % put depth into height
 \egroup
 \begingroup \put@frame \endgroup}

\newenvironment{framed}% using default \FrameCommand
  {\MakeFramed {\advance\hsize-\width \FrameRestore}}%
  {\endMakeFramed}

\newenvironment{shaded}{%
  \def\FrameCommand{\colorbox{shadecolor}}%
  \MakeFramed {\FrameRestore}}%
 {\endMakeFramed}

\newenvironment{leftbar}{%
  \def\FrameCommand{\vrule width 3pt \hspace{10pt}}%
  \MakeFramed {\advance\hsize-\width \FrameRestore}}%
 {\endMakeFramed}

}{}} % end of AtBeginDocument

%% \def\MakeFramed#1{\par         %% PW change to \newcommand
\newcommand{\MakeFramed}[1]{\par
 % measure added width and height; call result \width and \height
 \setbox\z@\vbox{\vskip-1in \hbox{\hskip-1in
   \FrameCommand{\hbox{\vrule \@height .7in \@depth.3in \@width 1in}}}%
   \vskip\z@skip}%
 \def\width{\wd\z@}\def\height{\ht\z@}%
 \edef\fb@frw{\the\width}\edef\fb@frh{\the\height}%
 % insert pre-penalties and skips
 \begingroup
 \skip@\lastskip
 \if@nobreak\else
    \penalty9999 % updates \page parameters
    \ifdim\pagefilstretch=\z@ \ifdim\pagefillstretch=\z@
       \edef\@tempa{\the\skip@}%
       \ifx\@tempa\zero@glue \penalty-30
       \else \vskip-\skip@ \penalty-30 \vskip\skip@
    \fi\fi\fi
    \penalty\z@
    % Give a stretchy breakpoint that will always be taken in preference
    % to the \penalty 9999 used to update page parameters. The cube root
    % of 10000/100 indicates a multiplier of 0.21545, but the maximum
    % calculated badness is really 8192, not 10000, so the multiplier
    % is 0.2301.
    \advance\skip@ \z@ plus-.5\baselineskip
    \advance\skip@ \z@ plus-.231\height
    \advance\skip@ \z@ plus-.231\skip@
    \advance\skip@ \z@ plus-.231\topsep
    \vskip-\skip@ \penalty 1800 \vskip\skip@
 \fi
 \addvspace{\topsep}%
 \endgroup
 % clear out pending page break
 \penalty\@M \vskip 2\baselineskip \vskip\height
 \penalty9999 \vskip -2\baselineskip \vskip-\height
 \penalty9999 % updates \pagetotal
 \fb@adjheight
 \setbox\@tempboxa\vbox\bgroup
   #1% Modifications to \hsize (can use \width and \height)
   \textwidth\hsize \columnwidth\hsize
}

\def\put@frame{\relax
 \ifdim\pagegoal=\maxdimen \pagegoal\vsize \fi
 \ifinner \else
    \dimen@\pagegoal \advance\dimen@-\pagetotal % space left on page
  \ifdim\dimen@<2\baselineskip
    \eject \fb@adjheight \put@frame
  \else % there's appreciable room left on the page
    \begingroup % temporarily set \dimen@ to be...
    \advance\dimen@.8\pageshrink  % maximum space available on page
    \advance\dimen@-\fb@frh\relax % space for frame's contents
    \expandafter\endgroup
    % restore \dimen@ to real room left on page
    \ifdim\dimen@>\ht\@tempboxa % whole box does fit
    \else % box must be split
      \setbox\@tempboxa\vbox{% simulate frame and flexiblity of page:
        \vskip \fb@frh \@plus\pagestretch \@minus.8\pageshrink
        \kern137sp\kern-137sp\penalty-30
        \unvbox\@tempboxa}%
      \edef\fb@resto@set{\boxmaxdepth\the\boxmaxdepth
                         \splittopskip\the\splittopskip}%  % v0.8a
      \boxmaxdepth\z@ \splittopskip\z@
      \setbox\tw@\vsplit\@tempboxa to\dimen@
      \setbox\tw@\vbox{\unvbox\tw@}% natural-sized
      % If the split-to size > (\vsize-\topskip),
      % then set box to full size
      \begingroup
        \advance\dimen@\topskip
        \expandafter\endgroup
      \ifdim\dimen@>\pagegoal
        \dimen@ii\pagegoal
        \advance\dimen@ii -\topskip
        \advance\dimen@ii \FrameHeightAdjust\relax
      \else  % suspect this is wrong:
        % If the split-to size > feasible room_on_page,
        % rebox it smaller.
        \advance\dimen@.8\pageshrink
        \ifdim\ht\tw@>\dimen@
          \dimen@ii\dimen@
        \else % use natural size
          \dimen@ii\ht\tw@
        \fi
      \fi
      % Re-box contents to desired size \dimen@ii
      \advance\dimen@ii -\fb@frh
      \setbox\tw@\vbox to\dimen@ii \bgroup
      % remove simulated frame and page flexibility:
      \vskip -\fb@frh \@plus-\pagestretch \@minus-.8\pageshrink
      \unvbox\tw@ \unpenalty\unpenalty
      \ifdim\lastkern=-137sp % whole box went to next page
        \egroup \fb@resto@set \eject
%%%              % (\vskip for frame size was discarded) % v 0.8a
        \fb@adjheight
      \else %
        \egroup \fb@resto@set  % v0.8a
        \ifvoid\@tempboxa % it all fit after all
           \setbox\@tempboxa\box\tw@
        \else % it really did split
          \ifdim\wd\tw@>\z@
            \centerline{\FrameCommand{\box\tw@}}% ? \centerline bad idea
           \else
             \box\tw@
           \fi
           \hrule \@height\z@
           \eject
           \fb@adjheight
           \put@frame
  \fi\fi\fi\fi\fi
  \ifvoid\@tempboxa\else
    \centerline{\FrameCommand{\box\@tempboxa}}%
    \nointerlineskip \null %{\showoutput \showlists}
    \penalty-30 \vskip\topsep
  \fi}

\def\fb@adjheight{%
  \vbox to\FrameHeightAdjust{}% get proper baseline skip from above.
  \penalty\@M \nointerlineskip
  \vskip-\FrameHeightAdjust
  \penalty\@M} % useful for tops of pages

\edef\zero@glue{\the\z@skip}

%% Define configuration commands:
\def\FrameCommand{\fboxrule=\FrameRule \fboxsep=\FrameSep \fbox}
\newdimen\FrameRule \FrameRule= \fboxrule
\newdimen\FrameSep  \FrameSep = 3\fboxsep

%% Height of frame above first baseline when frame starts a page:
%%\def\FrameHeightAdjust{6pt} % PW changed the value
\def\FrameHeightAdjust{0.6em}

%% PW: I have added my \ifframeasnormal to the original \FrameRestore
%%     The commented out lines are commented out by DA in the
%%     framed package

\newcommand{\FrameRestore}{%
  \let\if@nobreak\iffalse
  \let\if@noskipsec\iffalse
  \let\-\@dischyph
  \let\'\@acci\let\`\@accii\let\=\@acciii
  \linewidth\hsize
  \sloppy
\ifframeasnormal\else
  \let\par\@@par
  \parindent\z@ \parskip\z@skip
  \everypar{}%
  \@totalleftmargin\z@
  \leftskip\z@skip \rightskip\z@skip \@rightskip\z@skip
  \parfillskip\@flushglue \lineskip\normallineskip
  \baselineskip\normalbaselineskip
  \let\\\@normalcr
\fi
}

%%\let\fram@d=\MakeFramed  \let\endfram@d=\endMakeFramed

%%%%%%%%%%%% END FRAMED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\newoutputstream}[1]{%
  \@ifundefined{#1outstre@m}%
    {\expandafter\newwrite\csname #1outstre@m\endcsname
     \csname newif\expandafter\endcsname
       \csname ifstre@m#1open\endcsname
     \global\csname stre@m#1openfalse\endcsname
     \expandafter\ifx\csname atstreamopen#1\endcsname\relax
       \global\@namedef{atstreamopen#1}{}%
     \fi
     \expandafter\ifx\csname atstreamclose#1\endcsname\relax
       \global\@namedef{atstreamclose#1}{}%
     \fi
    }%
    {\@pupwarn{Output stream #1\space is already defined}}}

\newcommand{\newinputstream}[1]{%
  \@ifundefined{#1instre@m}%
    {\expandafter\newread\csname #1instre@m\endcsname
     \csname newif\expandafter\endcsname
       \csname ifstre@m#1open\endcsname
     \global\csname stre@m#1openfalse\endcsname
     \expandafter\ifx\csname atstreamopen#1\endcsname\relax
       \global\@namedef{atstreamopen#1}{}%
     \fi
     \expandafter\ifx\csname atstreamclose#1\endcsname\relax
       \global\@namedef{atstreamclose#1}{}%
     \fi
    }%
    {\@pupwarn{Input stream #1\space is already defined}}}

\newcommand{\IfStreamOpen}[3]{%
  \csname ifstre@m#1open\endcsname#2\else#3\fi}
\newcommand{\instre@mandopen}[2]{%
  \@ifundefined{#1instre@m}{%
    \@pupwarn{#1\space is not an input stream}}%
  {\IfStreamOpen{#1}{#2}{%
    \@pupwarn{Input stream #1\space is not open}}}}

\newcommand{\instre@mandclosed}[2]{%
  \@ifundefined{#1instre@m}{%
    \@pupwarn{#1\space is not an input stream}}%
  {\IfStreamOpen{#1}{%
    \@pupwarn{Input stream #1\space is open}}{#2}}}

\newcommand{\outstre@mandopen}[2]{%
  \@ifundefined{#1outstre@m}{%
    \@pupwarn{#1\space is not an output stream}}%
  {\IfStreamOpen{#1}{#2}{%
    \@pupwarn{Output stream #1\space is not open}}}}

\newcommand{\outstre@mandclosed}[2]{%
  \@ifundefined{#1outstre@m}{%
    \@pupwarn{#1\space is not an output stream}}%
  {\IfStreamOpen{#1}{%
    \@pupwarn{Output stream #1\space is open}}{#2}}}

\newcommand{\openoutputfile}[2]{%
  \outstre@mandclosed{#2}{%
    \global\@namedef{#1@filename}{#1}%
    \if@filesw
      \immediate\openout\@nameuse{#2outstre@m}=\@nameuse{#1@filename}%
    \fi
    \global\csname stre@m#2opentrue\endcsname%
    \@nameuse{atstreamopen#2}%
  }%
}

\newcommand{\closeoutputstream}[1]{%
  \outstre@mandopen{#1}{%
    \@nameuse{atstreamclose#1}%
    \immediate\closeout\@nameuse{#1outstre@m}%
    \global\csname stre@m#1openfalse\endcsname}%
}

\newcommand{\openinputfile}[2]{%
  \IfFileExists{#1}{%                   file exists
    \instre@mandclosed{#2}{%
      \@addtofilelist{#1}%
      \global\@namedef{#1@filename}{#1}%
      \immediate\openin\@nameuse{#2instre@m}=\@nameuse{#1@filename}%
      \global\csname stre@m#2opentrue\endcsname%
      \@nameuse{atstreamopen#2}}}%
  {%                                    file not found
    \typeout{No file #1.}
  }%
}

\newcommand{\closeinputstream}[1]{%
  \instre@mandopen{#1}{%
     \@nameuse{atstreamclose#1}%
     \immediate\closein\@nameuse{#1instre@m}%
     \global\csname stre@m#1openfalse\endcsname}%
}

\def\writeverbatim#1{%
  \@bsphack
  \let\do\@makeother\dospecials
  \catcode`\^^M\active
  \def\verbatim@processline{%
    \immediate\write\@nameuse{#1outstre@m}{\the\verbatim@line}}%
  \verbatim@start}
\def\endwriteverbatim{\@esphack}

\newcommand{\addtostream}[2]{%
  \@bsphack
  \outstre@mandopen{#1}{%
    {\let\protect\string
     \immediate\write\@nameuse{#1outstre@m}{#2}%
    }}%
  \@esphack
}

\newif\ifstre@mnoteof
\newcommand{\checkstre@meof}[1]{%
  \stre@mnoteoftrue\ifeof\@nameuse{#1instre@m}\stre@mnoteoffalse\fi}

\def\readstream#1{
  \instre@mandopen{#1}{%
    \loop \checkstre@meof{#1} \ifstre@mnoteof
      \read\@nameuse{#1instre@m} to\temptokstre@m
     \temptokstre@m
    \repeat
    }%
}

\def\readaline#1{
  \instre@mandopen{#1}{%
    \ifeof\@nameuse{#1instre@m}
      \@pupwarn{No more to read from stream #1}
    \else
      \read\@nameuse{#1instre@m} to\temptokstre@m
      \temptokstre@m
    \fi
    }%
}

\def\readverbatim{\begingroup
  \ift@bs
    \def\verbatim@processline{\tabverbatim@processline}%
  \fi
  \@ifstar{\stre@mverb@input{\@maybeobeytabs}}%
     {\stre@mverb@input{\frenchspacing\@vobeyspaces\@maybeobeytabs}}}

\newcommand{\stre@mverb@input}[2]{%
  \IfStreamOpen{#2}%
    {\@verbatim #1\relax
     \def\@verbinstre@m{\@nameuse{#2instre@m}}
     \verb@readstre@m\endtrivlist\endgroup\@doendpe}%
    {\@pupwarn{Stream #2\space is not open}\endgroup}%
}

\newcommand{\verb@readstre@m}{%
  \verbatim@startline
  \expandafter\endlinechar\expandafter\m@ne
  \expandafter\verbatim@read@stre@m
  \expandafter\endlinechar\the\endlinechar\relax
  \verbatim@finish
}

\newcommand{\verbatim@read@stre@m}{%
  \read\@verbinstre@m to\next
  \ifeof\@verbinstre@m
  \else
    \expandafter\verbatim@addtoline\expandafter{\next}%
    \verbatim@processline
    \verbatim@startline
    \expandafter\verbatim@read@stre@m
  \fi
}

\newcommand{\readboxedverbatim}{\begingroup
  \@ifstar{\stre@mbvin\relax}%
          {\stre@mbvin{\frenchspacing\@vobeyspaces}}}

\newcommand{\stre@mbvin}[2]{%
  \IfStreamOpen{#2}%
    {\setupboxverb@line
     \@verbatim #1\relax
     \def\@verbinstre@m{\@nameuse{#2instre@m}}%
     \setupbox@verb
     \verb@readstre@m\bvendrulehook\endtrivlist\endgroup\@doendpe}%
    {\@pupwarn{Stream #2\space is not open}\endgroup}%
}

\newcommand{\provideenvironment}{\@star@or@long\p@pprovenv}
\newcommand{\p@pprovenv}[1]{\@ifundefined{#1}%
  {\new@environment{#1}}%       % create new environment
  {\@pupwarn{Environment `#1' already defined}%
   \p@pgobbleoptsandtwo}}
\newcommand{\p@pgobbleoptsandtwo}{%
  \@ifnextchar [{\p@pgobbleoptandtwo}{\@gobbletwo}}
\def\p@pgobbleoptandtwo[#1]{%
  \@ifnextchar [{\p@pgobbleoptandtwo}{\@gobbletwo}}

\newcommand*{\providecounter}[1]{%
  \@ifundefined{c@#1}%
    {\newcounter{#1}}%
    {\@pupwarn{Counter `#1' already defined}%
      \@ifnextchar[{\p@pgobbleopt}{}}%
}
\def\p@pgobbleopt[#1]{}

\newcommand*{\providelength}[1]{%
  \begingroup
    \escapechar\m@ne\xdef\@gtempa{{\string#1}}%
  \endgroup
  \expandafter\@ifundefined\@gtempa
    {\newlength{#1}}%
    {\@pupwarn{Length #1 already defined}}%
}

\newcommand*{\newloglike}{\@ifstar{\p@pnewlogs}{\p@pnewlog}}
\newcommand*{\p@pnewlogs}[2]{%
  \newcommand*{#1}{\mathop{\operator@font #2}}}
\newcommand*{\p@pnewlog}[2]{%
  \newcommand*{#1}{\mathop{\operator@font #2}\nolimits}}

\newcommand*{\provideloglike}{\@ifstar{\p@pprovlogs}{\p@pprovlog}}
\newcommand*{\p@pprovlogs}[2]{%
  \providecommand*{#1}{\mathop{\operator@font #2}}}
\newcommand*{\p@pprovlog}[2]{%
  \providecommand*{#1}{\mathop{\operator@font #2}\nolimits}}

\providecommand{\@removefromreset}[2]{{%
  \expandafter\let\csname c@#1\endcsname\@removefromreset
  \def\@elt##1{%
    \expandafter\ifx\csname c@##1\endcsname\@removefromreset
    \else
      \noexpand\@elt{##1}%
    \fi}%
  \expandafter\xdef\csname cl@#2\endcsname{%
    \csname cl@#2\endcsname}}}

\newcommand{\@ifbothcntrs}[3]{%
  \@ifundefined{c@#1}{% counter undefined
    \@puperror{#1 is not a counter}{\@eha}}%
  {% else counter is defined
    \@ifundefined{c@#2}{% within undefined
      \@puperror{#2 is not a counter}{\@eha}}%
    {% else both counter and within  are defined
     #3}}}

\newcommand{\counterwithin}{\@ifstar{\@csinstar}{\@csin}}
\newcommand{\@csinstar}[2]{%
  \@ifbothcntrs{#1}{#2}{\@addtoreset{#1}{#2}}}
\newcommand{\@csin}[2]{%
  \@ifbothcntrs{#1}{#2}{\@addtoreset{#1}{#2}%
                        \@namedef{the#1}{\@nameuse{the#2}.\arabic{#1}}}}

\newcommand{\counterwithout}{\@ifstar{\@csoutstar}{\@csout}}
\newcommand{\@csoutstar}[2]{%
  \@ifbothcntrs{#1}{#2}{\@removefromreset{#1}{#2}}}
\newcommand{\@csout}[2]{%
  \@ifbothcntrs{#1}{#2}{\@removefromreset{#1}{#2}%
                        \@namedef{the#1}{\arabic{#1}}}}

\newif\ifoddpage
\newif\ifstrictpagecheck
  \strictpagecheckfalse
\newcounter{cp@cntr}
\newcommand{\cplabel}{^_}
\DeclareRobustCommand{\checkoddpage}{%
  \oddpagefalse%
  \ifstrictpagecheck%
    \stepcounter{cp@cntr}\ppuplabel{\cplabel\thecp@cntr}%
    \@pupcnta=\ppuplabelref{\cplabel\thecp@cntr}\relax
    \ifodd\@pupcnta\oddpagetrue\fi
  \else
    \ifodd\c@page\oddpagetrue\fi
  \fi}

\gdef\theppupc@@page{\the\c@page}

\long\def\ppupprotected@write#1#2#3{%
  \begingroup
  \let\theppupc@@page\relax
  #2%
  \let\protect\@unexpandable@protect
  \edef\reserved@a{\write#1{#3}}%
  \reserved@a
  \endgroup
  \if@nobreak\ifvmode\nobreak\fi\fi}

\newcommand{\ppuplabel}[1]{\@bsphack
  \ppupprotected@write\@auxout{}%
    {\string\newppuplabel{#1}{\theppupc@@page}}%
  \@esphack}
\newcommand{\newppuplabel}[2]{{\global\@namedef{m@#1}{#2}}}
\newcommand{\ppuplabelref}[1]{%
  \expandafter\ifx\csname m@#1\endcsname\relax
    0%
  \else
    \csname m@#1\endcsname
  \fi}

\begingroup
\catcode`\Q=3
\long\gdef\@ifmtarg#1{\@xifmtarg#1QQ\@secondoftwo\@firstoftwo\@nil}
\long\gdef\@xifmtarg#1#2Q#3#4#5\@nil{#4}
\long\gdef\@ifnotmtarg#1{\@xifmtarg#1QQ\@firstofone\@gobble\@nil}
\endgroup

\DeclareRobustCommand{\ch@ngetext}{%
  \setlength{\@colht}{\textheight}\setlength{\@colroom}{\textheight}%
  \setlength{\vsize}{\textheight}\setlength{\columnwidth}{\textwidth}%
  \if@twocolumn%
    \advance\columnwidth-\columnsep \divide\columnwidth\tw@%
    \@firstcolumntrue%
  \fi%
  \setlength{\hsize}{\columnwidth}%
  \setlength{\linewidth}{\hsize}%
}

\DeclareRobustCommand{\changetext}[5]{%
  \@ifmtarg{#1}{}{\addtolength{\textheight}{#1}}%
  \@ifmtarg{#2}{}{\addtolength{\textwidth}{#2}}%
  \@ifmtarg{#3}{}{\addtolength{\evensidemargin}{#3}}%
  \@ifmtarg{#4}{}{\addtolength{\oddsidemargin}{#4}}%
  \@ifmtarg{#5}{}{\addtolength{\columnsep}{#5}}%
  \ch@ngetext%
}

\newenvironment{adjustwidth}[2]{%
  \begin{list}{}{%
    \topsep\z@%
    \listparindent\parindent%
    \parsep\parskip%
    \@ifmtarg{#1}{\setlength{\leftmargin}{\z@}}%
                 {\setlength{\leftmargin}{#1}}%
    \@ifmtarg{#2}{\setlength{\rightmargin}{\z@}}%
                 {\setlength{\rightmargin}{#2}}%
    }
    \item[]}{\end{list}}

\newenvironment{adjustwidth*}[2]{%
  \begin{list}{}{%
    \topsep\z@%
    \listparindent\parindent%
    \parsep\parskip%
    \checkoddpage
    \ifoddpage  % odd numbered page
      \@ifmtarg{#1}{\setlength{\leftmargin}{\z@}}%
                   {\setlength{\leftmargin}{#1}}%
      \@ifmtarg{#2}{\setlength{\rightmargin}{\z@}}%
                   {\setlength{\rightmargin}{#2}}%
    \else       % even numbered page
      \@ifmtarg{#2}{\setlength{\leftmargin}{\z@}}%
                   {\setlength{\leftmargin}{#2}}%
      \@ifmtarg{#1}{\setlength{\rightmargin}{\z@}}%
                   {\setlength{\rightmargin}{#1}}%
    \fi
    }
    \item[]}{\end{list}}

\newcommand{\calccentering}[1]{
  #1 = \paperwidth
  \advance #1 by -\textwidth
  \divide #1 by \tw@
  \advance #1 by -\spinemargin
}

\newcommand{\cleartoevenpage}[1][\@empty]{%
  \clearpage%
  \ifodd\c@page\hbox{}#1\clearpage\fi}

\newcommand{\movetoevenpage}[1][\@empty]{%
  \newpage%
  \ifodd\c@page\hbox{}#1\newpage\fi}

\newcommand{\cleartooddpage}[1][\@empty]{%
  \clearpage%
  \ifodd\c@page\else\hbox{}#1\clearpage\fi}

\newcommand{\movetooddpage}[1][\@empty]{%
  \newpage%
  \ifodd\c@page\else\hbox{}#1\newpage\fi}

\newcommand{\needspace}[1]{\begingroup\setlength{\dimen@}{#1}%
  \vskip\z@\@plus\dimen@\penalty -100\vskip\z@\@plus-\dimen@
  \vskip\dimen@\penalty 9999\vskip-\dimen@\endgroup}

\newcommand{\Needspace}{\@ifstar{\M@sneedsp@}{\M@needsp@}}
\newcommand{\M@sneedsp@}[1]{\par \penalty-100\begingroup
  \setlength{\dimen@}{#1}%
  \dimen@ii\pagegoal \advance\dimen@ii-\pagetotal
  \ifdim \dimen@>\dimen@ii
    \break
  \fi\endgroup}
\newcommand{\M@needsp@}[1]{\par \penalty-100\begingroup
  \setlength{\dimen@}{#1}%
  \dimen@ii\pagegoal \advance\dimen@ii-\pagetotal
  \ifdim \dimen@>\dimen@ii
    \ifdim \dimen@ii>\z@
      \vfil
    \fi
    \break
  \fi\endgroup}

\newcommand{\medspace}{\kern .22222em }
\DeclareRobustCommand{\:}{%
  \relax\ifmmode\mskip\medmuskip\else\medspace\fi}
\DeclareRobustCommand{\!}{%
  \relax\ifmmode\mskip-\thinmuskip\else\negthinspace\fi}

\DeclareRobustCommand*{\slashfracstyle}[1]{%
  {\m@th\ensuremath{\mbox{\fontsize\sf@size\z@\selectfont #1}}}}
\DeclareRobustCommand*{\slashfrac}[2]{\leavevmode
  \raise.5ex\hbox{\slashfracstyle{#1}}\kern-.13em/%
  \kern-.15em\lower.25ex\hbox{\slashfracstyle{#2}}}

\DeclareRobustCommand*{\textsubscript}[1]{%
  \@textsubscript{\selectfont#1}}
\newcommand*{\@textsubscript}[1]{%
  {\m@th\ensuremath{_{\mbox{\fontsize\sf@size\z@#1}}}}}

%%%%%%%%%%%%%%%%%%%% number formatting

\newif\iflowernumtoname
  \lowernumtonamefalse
\newif\ifpriornum
\newif\ifminusnumber
\newif\ifnotnumtonameallcaps
\newif\ifmakeordinal

\newcommand*{\namenumberand}{ and }
\newcommand*{\namenumbercomma}{, }
\newcommand*{\lcminusname}{minus }
\newcommand*{\ucminusname}{Minus }
\let\minusname\lcminusname
\newcommand*{\fnumbersep}{,}
\newcommand*\tensunitsep{-}
\newcommand*{\nthstring}{th}      % nth
\newcommand*{\iststring}{st}      % 1st
\newcommand*{\iindstring}{nd}     % 2nd
\newcommand*{\iiirdstring}{rd}    % 3rd
\newcommand*{\tiethstring}{tieth} % tieth
\newcommand*{\teenstring}{teen}   % teen
\newcommand{\ordscript}[1]{#1}

\chardef\p@pten=10 % shorthand for 10

\newcounter{isp@pctr}  % units
\newcounter{xsp@pctr}  % tens
\newcounter{csp@pctr}  % hundreds
\newcounter{ksp@pctr}  % thousands
\newcounter{xksp@pctr} % ten thousands
\newcounter{cksp@pctr} % hundred thousands
\newcounter{msp@pctr}  % millions
\newcounter{xmsp@pctr} % ten millions
\newcounter{cmsp@pctr} % hundred millions
\newcounter{bsp@pctr}  % billions
\newcounter{workp@pctr}

\newcommand*{\numdigits}[1]{%
  \setcounter{isp@pctr}{0}%
  \setcounter{xsp@pctr}{0}%
  \setcounter{csp@pctr}{0}%
  \setcounter{ksp@pctr}{0}%
  \setcounter{xksp@pctr}{0}%
  \setcounter{cksp@pctr}{0}%
  \setcounter{msp@pctr}{0}%
  \setcounter{xmsp@pctr}{0}%
  \setcounter{cmsp@pctr}{0}%
  \setcounter{bsp@pctr}{0}%
  \setcounter{workp@pctr}{#1}%
  \minusnumberfalse
  \ifnum \c@workp@pctr < \z@  % negative
    \minusnumbertrue
    \c@workp@pctr = -\c@workp@pctr
  \fi
  \ifnum \c@workp@pctr > \m@ne     % units
    \c@isp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@isp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@    % tens
    \c@xsp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@xsp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@   % hundreds
    \c@csp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@csp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@   % thousands
    \c@ksp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@ksp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@   % ten thousands
    \c@xksp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@xksp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@   % hundred thousands
    \c@cksp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@cksp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@   % millions
    \c@msp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@msp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@  % ten millions
    \c@xmsp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@xmsp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@  % hundred millions
    \c@cmsp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@cmsp@pctr by -\c@workp@pctr
    \divide \c@workp@pctr by \p@pten
  \fi
  \ifnum \c@workp@pctr > \z@% billions
    \c@bsp@pctr = \c@workp@pctr
    \divide \c@workp@pctr by \p@pten
    \multiply \c@workp@pctr by \p@pten
    \advance \c@bsp@pctr by -\c@workp@pctr
  \fi
}

\newcommand*{\form@tnumber}[1]{%
  \numdigits{#1}%
  \ifminusnumber-\fi
  \priornumfalse
  \ifnum \c@bsp@pctr > \z@ % billions
    \priornumtrue
    \thebsp@pctr\fnumbersep
  \fi
  \ifpriornum                 % hundred millions
    \thecmsp@pctr
  \else
    \ifnum \c@cmsp@pctr > \z@
      \priornumtrue
      \thecmsp@pctr
    \fi
  \fi
  \ifpriornum                 % ten millions
    \thexmsp@pctr
  \else
    \ifnum \c@xmsp@pctr > \z@
      \priornumtrue
      \thexmsp@pctr
    \fi
  \fi
  \ifpriornum                 % millions
    \themsp@pctr\fnumbersep
  \else
    \ifnum \c@msp@pctr > \z@
      \priornumtrue
      \themsp@pctr\fnumbersep
    \fi
  \fi
  \ifpriornum                % hundred thousands
    \thecksp@pctr
  \else
    \ifnum \c@cksp@pctr > \z@
      \priornumtrue
      \thecksp@pctr
    \fi
  \fi
  \ifpriornum                % ten thousands
    \thexksp@pctr
  \else
    \ifnum \c@xksp@pctr > \z@
      \priornumtrue
      \thexksp@pctr
    \fi
  \fi
  \ifpriornum                % thousands
    \theksp@pctr\fnumbersep
  \else
    \ifnum \c@ksp@pctr > \z@
      \priornumtrue
      \theksp@pctr\fnumbersep
    \fi
  \fi
  \ifpriornum                % hundreds
    \thecsp@pctr
  \else
    \ifnum \c@csp@pctr > \z@
      \priornumtrue
      \thecsp@pctr
    \fi
  \fi
  \ifpriornum                % tens
    \thexsp@pctr
  \else
    \ifnum \c@xsp@pctr > \z@
      \priornumtrue
      \thexsp@pctr
    \fi
  \fi
  \theisp@pctr              % units
}

\newcommand*{\cardinal}[1]{%
  \begingroup
  \let\fnumbersep\relax
  \form@tnumber{#1}%
  \endgroup}
\newcommand*{\fcardinal}[1]{%
  \begingroup
  \form@tnumber{#1}%
  \endgroup}

\newcommand*{\ordinal}[1]{%
  \begingroup
  \let\fnumbersep\relax
  \form@tnumber{#1}%
  \let\ordstring\nthstring
  \ifnum \c@xsp@pctr=\@ne\else
    \ifcase \c@isp@pctr
      \or \let\ordstring\iststring%    1st
      \or \let\ordstring\iindstring%   2nd
      \or \let\ordstring\iiirdstring%  3rd
    \fi
  \fi
  \ordscript{\ordstring}%
  \endgroup
}
\newcommand*{\fordinal}[1]{%
  \begingroup
  \form@tnumber{#1}%
  \let\ordstring\nthstring
  \ifnum \c@xsp@pctr=\@ne\else
    \ifcase \c@isp@pctr
      \or \let\ordstring\iststring%    1st
      \or \let\ordstring\iindstring%   2nd
      \or \let\ordstring\iiirdstring%  3rd
    \fi
  \fi
  \ordscript{\ordstring}%
  \endgroup
}

\newcommand*\nNameo{\iflowernumtoname z\else Z\fi ero}
\newcommand*\nNamec{\iflowernumtoname h\else H\fi undred}
\newcommand*\nNapup{\iflowernumtoname t\else T\fi housand}
\newcommand*\nNapupm{\iflowernumtoname m\else M\fi illion}
\newcommand*\nNapupmm{\iflowernumtoname b\else B\fi illion}

\newcommand*\nNamei{\iflowernumtoname o\else O\fi ne}
\newcommand*\nNameii{\iflowernumtoname t\else T\fi wo}
\newcommand*\nNameiii{\iflowernumtoname t\else T\fi hree}
\newcommand*\nNameiv{\iflowernumtoname f\else F\fi our}
\newcommand*\nNamev{\iflowernumtoname f\else F\fi ive}
\newcommand*\nNamevi{\iflowernumtoname s\else S\fi ix}
\newcommand*\nNamevii{\iflowernumtoname s\else S\fi even}
\newcommand*\nNameviii{\iflowernumtoname e\else E\fi ight}
\newcommand*\nNameix{\iflowernumtoname n\else N\fi ine}
\newcommand*\nNamex{\iflowernumtoname t\else T\fi en}
\newcommand*\nNamexi{\iflowernumtoname e\else E\fi leven}
\newcommand*\nNamexii{\iflowernumtoname t\else T\fi welve}
\newcommand*\nNamexiii{\iflowernumtoname t\else T\fi hir\teenstring}
\newcommand*\nNamexiv{\iflowernumtoname f\else F\fi our\teenstring}
\newcommand*\nNamexv{\iflowernumtoname f\else F\fi if\teenstring}
\newcommand*\nNamexvi{\iflowernumtoname s\else S\fi ix\teenstring}
\newcommand*\nNamexvii{\iflowernumtoname s\else S\fi even\teenstring}
\newcommand*\nNamexviii{\iflowernumtoname e\else E\fi igh\teenstring}
\newcommand*\nNamexix{\iflowernumtoname n\else N\fi ine\teenstring}
\newcommand*\nNamexx{\iflowernumtoname t\else T\fi wenty}
\newcommand*\nNamexxx{\iflowernumtoname t\else T\fi hirty}
\newcommand*\nNamexl{\iflowernumtoname f\else F\fi orty}
\newcommand*\nNamel{\iflowernumtoname f\else F\fi ifty}
\newcommand*\nNamelx{\iflowernumtoname s\else S\fi ixty}
\newcommand*\nNamelxx{\iflowernumtoname s\else S\fi eventy}
\newcommand*\nNamelxxx{\iflowernumtoname e\else E\fi ighty}
\newcommand*\nNamexc{\iflowernumtoname n\else N\fi inety}

\newcommand*{\unitnumbername}[1]{%
  \ifcase #1 \nNameo\or
   \nNamei\or
   \nNameii\or
   \nNameiii\or
   \nNameiv\or
   \nNamev\or
   \nNamevi\or
   \nNamevii\or
   \nNameviii\or
   \nNameix\fi}

\newcommand*{\teennumbername}[1]{%
  \ifcase #1 \nNamex\or
   \nNamexi\or
   \nNamexii\or
   \nNamexiii\or
   \nNamexiv\or
   \nNamexv\or
   \nNamexvi\or
   \nNamexvii\or
   \nNamexviii\or
   \nNamexix\fi}

\newcommand*{\tensnumbername}[2]{%
  \ifnum #1=\@ne
    \teennumbername{#2}\ifnotnumtonameallcaps\lowernumtonametrue\fi
  \else
    \ifcase #1
    \or
    \or \nNamexx
    \or \nNamexxx
    \or \nNamexl
    \or \nNamel
    \or \nNamelx
    \or \nNamelxx
    \or \nNamelxxx
    \or \nNamexc
    \fi
    \ifnotnumtonameallcaps\lowernumtonametrue\fi
    \ifnum #2 > \z@ \tensunitsep\unitnumbername{#2}\fi
  \fi}

\newcommand*\nthNameo{\nNameo\nthstring}
\newcommand*\nthNamei{\iflowernumtoname f\else F\fi irst}
\newcommand*\nthNameii{\iflowernumtoname s\else S\fi econd}
\newcommand*\nthNameiii{\iflowernumtoname t\else T\fi hird}
\newcommand*\nthNameiv{\nNameiv\nthstring}
\newcommand*\nthNamev{\iflowernumtoname f\else F\fi if\nthstring}
\newcommand*\nthNamevi{\nNamevi\nthstring}
\newcommand*\nthNamevii{\nNamevii\nthstring}
\newcommand*\nthNameviii{\iflowernumtoname e\else E\fi igh\nthstring}
\newcommand*\nthNameix{\iflowernumtoname n\else N\fi in\nthstring}
\newcommand*\nthNamexii{\iflowernumtoname t\else T\fi welf\nthstring}

\newcommand*{\unitordinalname}[1]{%
  \ifcase #1 \nthNameo\or
  \nthNamei\or
  \nthNameii\or
  \nthNameiii\or
  \nthNameiv\or
  \nthNamev\or
  \nthNamevi\or
  \nthNamevii\or
  \nthNameviii\or
  \nthNameix\fi}

\newcommand*{\teenordinalname}[1]{%
  \ifcase #1 \nNamex\nthstring\or
  \nNamexi\nthstring\or
  \nthNamexii\or
  \nNamexiii\nthstring\or
  \nNamexiv\nthstring\or
  \nNamexv\nthstring\or
  \nNamexvi\nthstring\or
  \nNamexvii\nthstring\or
  \nNamexviii\nthstring\or
  \nNamexix\nthstring\fi}

\newcommand*{\tensordinalname}[2]{%
  \ifnum #1=\@ne
    \teenordinalname{#2}\ifnotnumtonameallcaps\lowernumtonametrue\fi
  \else
    \ifnum #2> \z@
      \ifcase #1
      \or
      \or \nNamexx
      \or \nNamexxx
      \or \nNamexl
      \or \nNamel
      \or \nNamelx
      \or \nNamelxx
      \or \nNamelxxx
      \or \nNamexc
      \fi
      \ifnotnumtonameallcaps\lowernumtonametrue\fi
      \tensunitsep\unitordinalname{#2}
    \else
      \ifcase #1
      \or
      \or \nthNamexx
      \or \nthNamexxx
      \or \nthNamexl
      \or \nthNamel
      \or \nthNamelx
      \or \nthNamelxx
      \or \nthNamelxxx
      \or \nthNamexc
      \fi
      \ifnotnumtonameallcaps\lowernumtonametrue\fi
    \fi
  \fi}

\newcommand*\nthNamexx{\iflowernumtoname t\else T\fi wen\tiethstring}
\newcommand*\nthNamexxx{\iflowernumtoname t\else T\fi hir\tiethstring}
\newcommand*\nthNamexl{\iflowernumtoname f\else F\fi or\tiethstring}
\newcommand*\nthNamel{\iflowernumtoname f\else F\fi if\tiethstring}
\newcommand*\nthNamelx{\iflowernumtoname s\else S\fi ix\tiethstring}
\newcommand*\nthNamelxx{\iflowernumtoname s\else S\fi even\tiethstring}
\newcommand*\nthNamelxxx{\iflowernumtoname e\else E\fi igh\tiethstring}
\newcommand*\nthNamexc{\iflowernumtoname n\else N\fi ine\tiethstring}

\newcommand*{\n@me@number}[1]{%
\begingroup
    \numdigits{#1}%
    \ifminusnumber\minusname\fi
    \priornumfalse
%% billions
    \ifnum \c@bsp@pctr > \z@
      \unitnumbername{\thebsp@pctr}\space
      \ifnotnumtonameallcaps\lowernumtonametrue\fi\nNapupmm
      \priornumtrue
    \fi
%% hundred millions
    \ifnum \c@cmsp@pctr > \z@
      \ifpriornum\namenumbercomma\fi
      \unitnumbername{\thecmsp@pctr}\space
      \ifnotnumtonameallcaps\lowernumtonametrue\fi\nNamec
      \priornumtrue
    \fi
%% tens/units millions
    \ifnum \c@xmsp@pctr > \z@
      \ifpriornum
        \ifnum\c@cmsp@pctr>\z@\namenumberand\else\namenumbercomma\fi
      \fi
      \tensnumbername{\thexmsp@pctr}{\themsp@pctr}%
      \priornumtrue
    \else
      \ifnum \c@msp@pctr > \z@
        \ifpriornum
          \ifnum\c@cmsp@pctr>\z@\namenumberand\else\namenumbercomma\fi
        \fi
        \unitnumbername{\themsp@pctr}%
        \ifnotnumtonameallcaps\lowernumtonametrue\fi
        \priornumtrue
      \fi
    \fi
    \ifnum \c@cmsp@pctr > \z@
      \ifpriornum\space\fi
      \nNamepm
    \else
      \ifnum \c@xmsp@pctr > \z@
        \ifpriornum\space\fi
        \nNamemm
      \else
        \ifnum \c@msp@pctr > \z@
          \ifpriornum\space\fi
          \nNamemm
        \fi
      \fi
    \fi
%% hundred thousands
    \ifnum \c@cksp@pctr > \z@
      \ifpriornum\namenumbercomma\fi
      \unitnumbername{\thecksp@pctr}\space
        \ifnotnumtonameallcaps\lowernumtonametrue\fi\nNamec
      \priornumtrue
    \fi
%% tens/units thousands
    \ifnum \c@xksp@pctr > \z@
      \ifpriornum
        \ifnum\c@cksp@pctr>\z@\namenumberand\else\namenumbercomma\fi
      \fi
      \tensnumbername{\thexksp@pctr}{\theksp@pctr}%
      \priornumtrue
    \else
      \ifnum \c@ksp@pctr > \z@
        \ifpriornum
          \ifnum\c@cksp@pctr>\z@\namenumberand\else\namenumbercomma\fi
        \fi
        \unitnumbername{\theksp@pctr}%
        \ifnotnumtonameallcaps\lowernumtonametrue\fi
        \priornumtrue
      \fi
    \fi
    \ifnum \c@cksp@pctr > \z@
      \ifpriornum\space\fi
      \nNamem
    \else
      \ifnum \c@xksp@pctr > \z@
        \ifpriornum\space\fi
        \nNamem
      \else
        \ifnum \c@ksp@pctr > \z@
          \ifpriornum\space\fi
          \nNamem
        \fi
      \fi
    \fi
%% hundreds
    \ifnum \c@csp@pctr > \z@
      \ifpriornum\namenumbercomma\fi
      \unitnumbername{\thecsp@pctr}\space
        \ifnotnumtonameallcaps\lowernumtonametrue\fi\nNamec
      \priornumtrue
    \fi
%% tens/units
  \ifmakeordinal
    \ifnum \c@xsp@pctr > \z@
      \ifpriornum\namenumberand\fi
      \tensordinalname{\thexsp@pctr}{\theisp@pctr}%
    \else
      \ifnum \c@isp@pctr > \z@
        \ifpriornum\namenumberand\fi
        \unitordinalname{\theisp@pctr}%
      \else
        \ifpriornum\nthstring\else\unitordinalname{\theisp@pctr}\fi
      \fi
    \fi
  \else  % not ordinal
    \ifnum \c@xsp@pctr > \z@
      \ifpriornum\namenumberand\fi
      \tensnumbername{\thexsp@pctr}{\theisp@pctr}%
    \else
      \ifnum \c@isp@pctr > \z@
        \ifpriornum\namenumberand\fi
        \unitnumbername{\theisp@pctr}%
      \else
        \ifpriornum\else\unitnumbername{\theisp@pctr}\fi
      \fi
    \fi
  \fi % end ifmakeordinal
\endgroup
}

\newcommand*{\numtoname}[1]{%
  \makeordinalfalse
  \notnumtonameallcapstrue%
  \lowernumtonametrue%
  \n@me@number{#1}}

\newcommand*{\numtoName}[1]{%
  \makeordinalfalse
  \notnumtonameallcapstrue%
  \lowernumtonamefalse%
  \n@me@number{#1}}

\newcommand*{\NumToName}[1]{%
  \makeordinalfalse
  \notnumtonameallcapsfalse%
  \lowernumtonamefalse%
  \n@me@number{#1}}

\newcommand*{\ordinaltoname}[1]{%
  \makeordinaltrue
  \notnumtonameallcapstrue%
  \lowernumtonametrue%
  \n@me@number{#1}}

\newcommand*{\ordinaltoName}[1]{%
  \makeordinaltrue
  \notnumtonameallcapstrue%
  \lowernumtonamefalse%
  \n@me@number{#1}}

\newcommand*{\OrdinalToName}[1]{%
  \makeordinaltrue
  \notnumtonameallcapsfalse%
  \lowernumtonamefalse%
  \n@me@number{#1}}

\long\def \@topnewpage [#1]{%
  \@nodocument
  \@next\@currbox\@freelist{}{}%
  \global \setbox\@currbox
    \vbox {%
      \break
      \prevdepth\z@
      \begingroup
      \normalcolor
      \hsize\textwidth
      \@parboxrestore
      \col@number \@ne
      #1%
      \vskip -\dbltextfloatsep
      \endgroup
      \null % ordinary \baselineskip
      \vskip -\topskip
  }%
  \begingroup %% \showbox\@currbox
    \splitmaxdepth\maxdepth \splittopskip\topskip
    \setbox\@tempboxa \vsplit\@currbox to \z@
  \endgroup %% \showbox\@currbox
  \ifdim \ht\@currbox>\textheight
    \ht\@currbox \textheight
  \fi
  \global \count\@currbox \tw@
  \@tempdima -\ht\@currbox
  \advance \@tempdima -\dbltextfloatsep
  \global \advance \@colht \@tempdima
  \ifx \@dbltoplist \@empty
  \else
    \@latexerr{Float(s) lost}\@ehb
    \let \@dbltoplist \@empty
  \fi
  \@cons \@dbltoplist \@currbox
  \global \@dbltopnum \m@ne
  \ifdim \@colht<2.5\baselineskip
    \@latex@warning@no@line {Optional argument of \noexpand\twocolumn
        too tall on page \thepage}%
    \@emptycol
    \if@firstcolumn
    \else
      \@emptycol
    \fi
  \else
    \global \vsize \@colht
    \global \@colroom \@colht
    \@floatplacement
  \fi
}

\newcommand*{\abstractname}{Abstract}
\newcommand*{\contentsname}{Contents}
\newcommand*{\listfigurename}{List of Figures}
\newcommand*{\listtablename}{List of Tables}
\newcommand*{\partname}{Part}
\newcommand*{\chaptername}{Chapter}
\newcommand*{\appendixname}{Appendix}
\newcommand*{\appendixtocname}{Appendices}
\newcommand*{\appendixpagename}{Appendices}
\newcommand*{\bibname}{Bibliography}
\newcommand*{\indexname}{Index}
\newcommand*{\glossaryname}{Glossary}
\newcommand*{\figurename}{Figure}
\newcommand*{\tablename}{Table}
\newcommand*{\figurerefname}{Figure}
\newcommand*{\tablerefname}{Table}
\newcommand*{\pagename}{page}
\newcommand*{\pagerefname}{page}
\newcommand*{\partrefname}{Part~}
\newcommand*{\chapterrefname}{Chapter~}
\newcommand*{\sectionrefname}{\S}
\newcommand{\today}{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{headings}
\pagenumbering{arabic}

\setcounter{part}{0}
\setcounter{chapter}{0}
\setcounter{tocdepth}{1}
\setcounter{secnumdepth}{4}
\maxsecnumdepth{subsubsection}

\linenumberfrequency{0}
\linenumberfont{\small\rmfamily}
\settowidth{\bvnumlength}{\vlvnumfont 9999}

\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi

\newfloat[chapter]{figure}{lof}{\figurename}
  \kill@lastcounter{lofdepth}
\renewcommand{\thefigure}{\thechapter.\@arabic\c@figure}

\newlistof{listoffigures}{lof}{\listfigurename}
  \kill@lastcounter{lofdepth}
\newlistentry[chapter]{figure}{lof}{0}
  \cftsetindents{figure}{0em}{2.3em}
%%  \kill@lastcounter{lofdepth}

\newfloat[chapter]{table}{lot}{\tablename}
  \kill@lastcounter{lotdepth}
\renewcommand{\thetable}{\thechapter.\@arabic\c@table}

\newlistof{listoftables}{lot}{\listtablename}
  \kill@lastcounter{lotdepth}
\newlistentry[chapter]{table}{lot}{0}
  \cftsetindents{table}{0em}{2.3em}
%%  \kill@lastcounter{lotdepth}

\AtBeginDocument{%
  \@ifundefined{c@lofdepth}%
     {\newcounter{lofdepth}\setcounter{lofdepth}{1}}{}
  \@ifundefined{c@lotdepth}%
     {\newcounter{lotdepth}\setcounter{lotdepth}{1}}{}
}

\ifartopt
  \chapterstyle{article}
  \counterwithout{figure}{chapter}
  \counterwithout{table}{chapter}
  \counterwithout{footnote}{chapter}
  \counterwithout{equation}{chapter}
  \renewcommand{\chaptername}{}
  \renewcommand{\maketitlehookb}{%
    \vskip -1.5\topsep\vskip -1.5\partopsep}
  \renewcommand{\maketitlehookc}{%
    \vskip -1.5\topsep\vskip -1.5\partopsep}
\fi

\newcommand{\msdoublespacing}{}
\newcommand{\mssinglespacing}{}
\ifmsdoc
  \renewcommand{\msdoublespacing}{%
    \renewcommand{\baselinestretch}{1.6}\large\normalsize}
  \renewcommand{\mssinglespacing}{%
    \renewcommand{\baselinestretch}{1.0}\large\normalsize}
  \renewcommand{\familydefault}{cmtt}
  \renewcommand{\rmdefault}{cmtt}
  \renewcommand{\sfdefault}{cmtt}
  \renewcommand{\bfdefault}{m}
  \renewcommand{\itdefault}{n}
  \renewcommand{\sldefault}{n}
  \renewcommand{\scdefault}{n}
  \renewcommand{\baselinestretch}{1.6}
  \@twocolumnfalse
  \onecolumn
  \sloppy
  \@twosidefalse
  \raggedbottom
  \pagestyle{plain}
\fi

\EmulatedPackage{abstract}
\EmulatedPackage{appendix}
\EmulatedPackage{array}
\EmulatedPackage{booktabs}
\EmulatedPackage{ccaption}
\EmulatedPackage{chngcntr}
\EmulatedPackage{chngpage}
\EmulatedPackage{crop}
\EmulatedPackage{dcolumn}
\EmulatedPackage{delarray}
\EmulatedPackage{enumerate}
\EmulatedPackage{epigraph}
\EmulatedPackage{framed}
\EmulatedPackage{ifmtarg}
\EmulatedPackage{ifpdf}
\EmulatedPackage{index}
\EmulatedPackage{makeidx}
\EmulatedPackage{moreverb}
\EmulatedPackage{needspace}
\EmulatedPackage{newfile}
\EmulatedPackage{nextpage}
\EmulatedPackage{patchcmd}
\EmulatedPackage{shortvrb}
\EmulatedPackage{showidx}
\EmulatedPackage{tabularx}
\EmulatedPackage{titleref}
\EmulatedPackage{titling}
\EmulatedPackage{tocbibind}
\EmulatedPackage{tocloft}
\EmulatedPackage{verbatim}
\EmulatedPackage{verse}

\newdimen\normalparindent
\normalparindent=\parindent
\def\@addpunct#1{%
  \relax\ifhmode
    \ifnum\spacefactor>\@m \else#1\fi
  \fi}

\newcommand{\theoremstyle}[1]{%
  \@ifundefined{th@#1}{%
    \PackageWarning{amsthm}{Unknown theoremstyle `#1'}%
    \thm@style{plain}%
  }{%
    \thm@style{#1}%
  }%
}
\newtoks\thm@style
\thm@style{plain}
\newtoks\thm@bodyfont  \thm@bodyfont{\itshape}
\newtoks\thm@headfont  \thm@headfont{\bfseries}
\newtoks\thm@notefont  \thm@notefont{}
\newtoks\thm@headpunct \thm@headpunct{.}
\newskip\thm@preskip \newskip\thm@postskip
\def\thm@space@setup{%
  \thm@preskip=.5\baselineskip\@plus.2\baselineskip
                             \@minus.2\baselineskip
  \thm@postskip=\thm@preskip
}
\renewcommand{\newtheorem}{\@ifstar{\@xnthm *}{\@xnthm \relax}}
\def\@xnthm#1#2{%
  \let\@tempa\relax
  \@xp\@ifdefinable\csname #2\endcsname{%
    \global\@xp\let\csname end#2\endcsname\@endtheorem
    \ifx *#1% unnumbered, need to get one more mandatory arg
      \edef\@tempa##1{%
        \gdef\@xp\@nx\csname#2\endcsname{%
          \@nx\@thm{\@xp\@nx\csname th@\the\thm@style\endcsname}%
            {}{##1}}}%
    \else % numbered theorem, need to check for optional arg
      \def\@tempa{\@oparg{\@ynthm{#2}}[]}%
    \fi
  }%
  \@tempa
}
\def\@ynthm#1[#2]#3{%
  \ifx\relax#2\relax
    \def\@tempa{\@oparg{\@xthm{#1}{#3}}[]}%
  \else
    \@ifundefined{c@#2}{%
      \def\@tempa{\@nocounterr{#2}}%
    }{%
      \@xp\xdef\csname the#1\endcsname{\@xp\@nx\csname the#2\endcsname}%
      \toks@{#3}%
      \@xp\xdef\csname#1\endcsname{%
        \@nx\@thm{%
          \let\@nx\thm@swap
            \if S\thm@swap\@nx\@firstoftwo\else\@nx\@gobble\fi
          \@xp\@nx\csname th@\the\thm@style\endcsname}%
            {#2}{\the\toks@}}%
      \let\@tempa\relax
    }%
  \fi
  \@tempa
}
\def\@xthm#1#2[#3]{%
  \ifx\relax#3\relax
    \newcounter{#1}%
  \else
    \newcounter{#1}[#3]%
    \@xp\xdef\csname the#1\endcsname{\@xp\@nx\csname the#3\endcsname
      \@thmcountersep\@thmcounter{#1}}%
  \fi
  \toks@{#2}%
  \@xp\xdef\csname#1\endcsname{%
    \@nx\@thm{%
      \let\@nx\thm@swap
        \if S\thm@swap\@nx\@firstoftwo\else\@nx\@gobble\fi
      \@xp\@nx\csname th@\the\thm@style\endcsname}%
      {#1}{\the\toks@}}%
}
\def\@thm#1#2#3{%
  \ifhmode\unskip\unskip\par\fi
  \normalfont
  \trivlist
  \let\thmheadnl\relax
  \let\thm@swap\@gobble
  \let\thm@indent\indent % indent
  \thm@headfont{\scshape}% heading font small caps
  \thm@notefont{\fontseries\mddefault\upshape}%
  \thm@headpunct{.}% add period after heading
  \thm@headsep 5\p@ plus\p@ minus\p@\relax
  \thm@space@setup
  #1% style overrides
  \@topsep \thm@preskip               % used by thm head
  \@topsepadd \thm@postskip           % used by \@endparenv
  \def\@tempa{#2}\ifx\@empty\@tempa
    \def\@tempa{\@oparg{\@begintheorem{#3}{}}[]}%
  \else
    \refstepcounter{#2}%
    \def\@tempa{\@oparg{\@begintheorem{#3}{\csname the#2\endcsname}}[]}%
  \fi
  \@tempa
}
\def\@restorelabelsep{\relax}
\let\@ythm\relax
\let\thmname\@iden \let\thmnote\@iden \let\thmnumber\@iden
\providecommand\@upn{\textup}
\def\thmhead@plain#1#2#3{%
  \thmname{#1}\thmnumber{\@ifnotempty{#1}{ }\@upn{#2}}%
  \thmnote{ {\the\thm@notefont(#3)}}}
\let\thmhead\thmhead@plain
\def\swappedhead#1#2#3{%
  \thmnumber{\@upn{\@secnumfont#2\@ifnotempty{#1}{.~}}}%
  \thmname{#1}%
  \thmnote{ {\the\thm@notefont(#3)}}}
\let\swappedhead@plain=\swappedhead
\let\thmheadnl\relax
\let\thm@indent\noindent
\let\thm@swap\@gobble
\def\@begintheorem#1#2[#3]{%
  \deferred@thm@head{\the\thm@headfont \thm@indent
    \@ifempty{#1}{\let\thmname\@gobble}{\let\thmname\@iden}%
    \@ifempty{#2}{\let\thmnumber\@gobble}{\let\thmnumber\@iden}%
    \@ifempty{#3}{\let\thmnote\@gobble}{\let\thmnote\@iden}%
    \thm@swap\swappedhead\thmhead{#1}{#2}{#3}%
    \the\thm@headpunct
    \thmheadnl % possibly a newline.
    \hskip\thm@headsep
  }%
  \ignorespaces}
\newskip\thm@headsep
\thm@headsep=5pt plus1pt minus1pt\relax
\let\adjust@parskip@nobreak=\@nbitem
\newtoks\dth@everypar
\dth@everypar={%
  \@minipagefalse \global\@newlistfalse
  \@noparitemfalse
  \if@inlabel
    \global\@inlabelfalse
    \begingroup \setbox\z@\lastbox
     \ifvoid\z@ \kern-\itemindent \fi
    \endgroup
    \unhbox\@labels
  \fi
  \if@nobreak \@nobreakfalse \clubpenalty\@M
  \else \clubpenalty\@clubpenalty \everypar{}%
  \fi
}%
\def\deferred@thm@head#1{%
  \if@inlabel \indent \par \fi % eject a section head if one is pending
  \if@nobreak
    \adjust@parskip@nobreak
  \else
    \addpenalty\@beginparpenalty
    \addvspace\@topsep
    \addvspace{-\parskip}%
  \fi
  \global\@inlabeltrue
  \everypar\dth@everypar
  \sbox\@labels{\normalfont#1}%
  \ignorespaces
}
\def\nonslanted{\relax
  \@xp\let\@xp\@tempa\csname\f@shape shape\endcsname
  \ifx\@tempa\itshape\upshape
  \else\ifx\@tempa\slshape\upshape\fi\fi}
\def\swapnumbers{\edef\thm@swap{\if S\thm@swap N\else S\fi}}
\def\thm@swap{N}%
\let\@opargbegintheorem\relax
\def\th@plain{%
%%  \let\thm@indent\noindent % no indent
%%  \thm@headfont{\bfseries}% heading font is bold
%%  \thm@notefont{}% same as heading font
%%  \thm@headpunct{.}% add period after heading
%%  \let\thm@swap\@gobble
%%  \thm@preskip\topsep
%%  \thm@postskip\theorempreskipamount
  \itshape % body font
}
\def\th@definition{%
  \normalfont % body font
}
\def\th@remark{%
  \normalfont % body font
}
\def\@endtheorem{\endtrivlist\@endpefalse }
\newcommand{\newtheoremstyle}[9]{%
  \@ifempty{#5}{\dimen@\z@skip}{\dimen@#5\relax}%
  \ifdim\dimen@=\z@
    \toks@{#4\let\thm@indent\noindent}%
  \else
    \toks@{#4\def\thm@indent{\noindent\hbox to#5{}}}%
  \fi
  \def\@tempa{#8}\ifx\space\@tempa
    \toks@\@xp{\the\toks@ \thm@headsep\fontdimen\tw@\font\relax}%
  \else
    \def\@tempb{\newline}%
    \ifx\@tempb\@tempa
      \toks@\@xp{\the\toks@ \thm@headsep\z@skip
        \def\thmheadnl{\newline}}%
    \else
      \toks@\@xp{\the\toks@ \thm@headsep#8\relax}%
    \fi
  \fi
  \begingroup
  \thm@space@setup
  \@defaultunits\@tempskipa#2\thm@preskip\relax\@nnil
  \@defaultunits\@tempskipb#3\thm@postskip\relax\@nnil
  \xdef\@gtempa{\thm@preskip\the\@tempskipa
    \thm@postskip\the\@tempskipb\relax}%
  \endgroup
  \@temptokena\@xp{\@gtempa
    \thm@headfont{#6}\thm@headpunct{#7}%
  }%
  \@ifempty{#9}{%
    \let\thmhead\thmhead@plain
  }{%
    \@namedef{thmhead@#1}##1##2##3{#9}%
    \@temptokena\@xp{\the\@temptokena
      \@xp\let\@xp\thmhead\csname thmhead@#1\endcsname}%
  }%
  \@xp\xdef\csname th@#1\endcsname{\the\toks@ \the\@temptokena}%
}
\DeclareRobustCommand{\qed}{%
  \ifmmode \mathqed
  \else
    \leavevmode\unskip\penalty9999 \hbox{}\nobreak\hfill
    \quad\hbox{\qedsymbol}%
  \fi
}
\let\QED@stack\@empty
\let\qed@elt\relax
\newcommand{\pushQED}[1]{%
  \toks@{\qed@elt{#1}}\@temptokena\expandafter{\QED@stack}%
  \xdef\QED@stack{\the\toks@\the\@temptokena}%
}
\newcommand{\popQED}{%
  \begingroup\let\qed@elt\popQED@elt \QED@stack\relax\relax\endgroup
}
\def\popQED@elt#1#2\relax{#1\gdef\QED@stack{#2}}
\newcommand{\qedhere}{%
  \begingroup \let\mathqed\math@qedhere
    \let\qed@elt\setQED@elt \QED@stack\relax\relax \endgroup
}
\newif\ifmeasuring@
\newif\iffirstchoice@ \firstchoice@true
\def\setQED@elt#1#2\relax{%
  \ifmeasuring@
  \else \iffirstchoice@ \gdef\QED@stack{\qed@elt{}#2}\fi
  \fi
  #1%
}
\def\qed@warning{%
  \PackageWarning{amsthm}{The \@nx\qedhere command may not work
    correctly here}%
}
\newcommand{\mathqed}{\quad\hbox{\qedsymbol}}
\def\linebox@qed{\hfil\hbox{\qedsymbol}\hfilneg}
\@ifpackageloaded{amsmath}{%
  \def\math@qedhere{%
    \@ifundefined{\@currenvir @qed}{%
      \qed@warning\quad\hbox{\qedsymbol}%
    }{%
      \@xp\aftergroup\csname\@currenvir @qed\endcsname
    }%
  }
  \def\displaymath@qed{%
    \relax
    \ifmmode
      \ifinner \aftergroup\linebox@qed
      \else
        \eqno
        \let\eqno\relax \let\leqno\relax \let\veqno\relax
        \hbox{\qedsymbol}%
      \fi
    \else
       \aftergroup\linebox@qed
    \fi
  }
  \@xp\let\csname equation*@qed\endcsname\displaymath@qed
  \def\equation@qed{%
    \iftagsleft@
      \hbox{\phantom{\quad\qedsymbol}}%
      \gdef\alt@tag{%
        \rlap{\hbox to\displaywidth{\hfil\qedsymbol}}%
        \global\let\alt@tag\@empty
      }%
    \else
      \gdef\alt@tag{%
        \global\let\alt@tag\@empty
        \vtop{\ialign{\hfil####\cr
                \tagform@\theequation\cr
                \qedsymbol\cr}}%
        \setbox\z@
      }%
    \fi
  }
  \def\qed@tag{%
    \global\tag@true \nonumber
    &\omit\setboxz@h {\strut@ \qedsymbol}\tagsleft@false
    \place@tag@gather
    \kern-\tabskip
    \ifst@rred \else \global\@eqnswtrue \fi \global\advance\row@\@ne \cr
  }
  \def\split@qed{%
    \def\endsplit{\crcr\egroup \egroup \ctagsplit@false \rendsplit@
      \aftergroup\align@qed
    }%
  }
  \def\align@qed{%
    \ifmeasuring@ \tag*{\qedsymbol}%
    \else \let\math@cr@@@\qed@tag
    \fi
  }
  \@xp\let\csname align*@qed\endcsname\align@qed
  \@xp\let\csname gather*@qed\endcsname\align@qed
%% Needs some patching up for amsmath 1.2
}{% end of amsmath branch, start plain LaTeX branch
  \def\math@qedhere{%
    \@ifundefined{\@currenvir @qed}{%
      \qed@warning \aftergroup\displaymath@qed
    }{%
      \@xp\aftergroup\csname\@currenvir @qed\endcsname
    }%
  }
  \def\displaymath@qed{%
    \relax
    \ifmmode
      \ifinner \aftergroup\aftergroup\aftergroup\linebox@qed
      \else
        \eqno \def\@badmath{$$}%
        \let\eqno\relax \let\leqno\relax \let\veqno\relax
        \hbox{\qedsymbol}%
      \fi
    \else
       \aftergroup\linebox@qed
    \fi
  }
  \@ifundefined{ver@leqno.clo}{%
    \def\equation@qed{\displaymath@qed \quad}%
  }{%
    \def\equation@qed{\displaymath@qed}%
  }
  \def\@tempa#1$#2#3\@nil{%
    \def\[{#1$#2\def\@currenvir{displaymath}#3}%
  }%
  \expandafter\@tempa\[\@nil
}
\@ifpackageloaded{amstex}{%
  \def\@tempa{TT}%
}{%
  \@ifpackageloaded{amsmath}{%
    \def\@tempb#1 v#2.#3\@nil{#2}%
    \ifnum\@xp\@xp\@xp\@tempb\csname ver@amsmath.sty\endcsname v0.0\@nil
       <\tw@
      \def\@tempa{TT}%
    \else
      \def\@tempa{TF}%
    \fi
  }{%
    \def\@tempa{TF}
  }%
}
\if\@tempa
  \renewcommand{\math@qedhere}{\quad\hbox{\qedsymbol}}%
\fi
\newcommand{\openbox}{\leavevmode
  \hbox to.77778em{%
  \hfil\vrule
  \vbox to.675em{\hrule width.6em\vfil\hrule}%
  \vrule\hfil}}
\DeclareRobustCommand{\textsquare}{%
  \begingroup \usefont{U}{msa}{m}{n}\thr@@\endgroup
}
\providecommand{\qedsymbol}{\textsquare}
\newenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \itemindent\normalparindent
  \item[\hskip\labelsep
        \scshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}
\providecommand{\proofname}{Proof}
\providecommand{\theoremname}{\scshape Theorem}
\providecommand{\definitionname}{\scshape Definition}
\providecommand{\lemmaname}{\scshape Lemma}
\providecommand{\conjecturename}{\scshape Conjecture}
\providecommand{\corollaryname}{\scshape Corollary}

\newtheorem{theorem}{{\theoremname}}[chapter]
\newtheorem{definition}[theorem]{{\definitionname}}
\newtheorem{lemma}[theorem]{{\lemmaname}}
\newtheorem{conjecture}[theorem]{{\conjecturename}}
\newtheorem{corollary}[theorem]{{\corollaryname}}

%%%%% Example environment
\newcounter{example}[section]
\renewcommand{\theexample}{\thesection.\arabic{example}}
\newenvironment{example}[1][]{\vspace{6pt plus3pt minus2pt}\par%
\refstepcounter{example}%
\noindent\textbf{Example~\theexample}\hspace*{1em}\itshape\ignorespaces}{\par\vspace{6pt plus3pt minus2pt}}

%%%%% Remark environment
\newenvironment{remark}[1][Remark.]{\vspace{6pt plus3pt minus2pt}\par%
\noindent\textit{#1}\hspace*{1em}\ignorespaces}{\par\vspace{6pt plus3pt minus2pt}}

\newenvironment{proposition}{\begin{list}
{}%%%%no label
{%%%%%no counter
\setlength{\topsep}{6pt plus3pt minus2pt}%
\setlength{\partopsep}{0pt}%
\setlength{\parsep}{0pt}%
\setlength{\itemsep}{0pt}%
\setlength{\leftmargin}{1em}%
\setlength{\rightmargin}{1em}%
\setlength{\listparindent}{0pt}%
\setlength{\labelwidth}{0pt}%
\setlength{\itemindent}{0pt}%
\setlength{\labelsep}{0pt}}\item[]}%%%%%
{\end{list}}

\setlength{\textwidth}{\opttextwidth}
\endinput