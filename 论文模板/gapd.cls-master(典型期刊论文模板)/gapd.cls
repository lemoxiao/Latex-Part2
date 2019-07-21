\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gapd}[2016/12/15 Basic formatting for Game \& Puzzle Design Journal (gapd)]

% Original styling by Cameron Browne, 2014/09/11
% Converted to LaTeX class by Joe Kopena, 2016/12/15

\LoadClass[twocolumn,twoside]{article}

\pdfminorversion=4

\RequirePackage{calc}

\RequirePackage{lastpage}

\RequirePackage{xstring}
\RequirePackage{xparse}

\RequirePackage{multicol, caption} % for double column
\RequirePackage[english]{babel} % for random text
\RequirePackage{graphicx} % for figures
\RequirePackage{color} % for colour boxes
\RequirePackage[usenames,dvipsnames]{xcolor} % for colour boxes
\RequirePackage{fancyhdr} % for page headers
\RequirePackage[
     paperwidth=16.83cm, paperheight=26.03cm,
     textwidth=276pt, textheight=524pt,
     margin={14mm,16mm},
     headsep = 14pt,
     footskip=20pt
]{geometry}   % for margins
\RequirePackage{lettrine} % for large opening letter
\RequirePackage{etoolbox} % to remove redundant "References" heading
\RequirePackage[square,sort,comma,numbers]{natbib} % for bibliography formatting
\RequirePackage{etoolbox}
\RequirePackage{titlesec} % for section heading formatting
\RequirePackage{microtype} % improves word spacing
\RequirePackage{setspace}
\RequirePackage{caption}
\RequirePackage{framed} % for coloured text box formatting
\RequirePackage{mdframed} % for coloured text box formatting
\RequirePackage{import} % for compiling master file
\RequirePackage{titletoc} % for table of contents http://ctan.org/pkg/titletoc
\RequirePackage{wrapfig} % for wrapping text around figure, e.g. on Credits page
\PassOptionsToPackage{hyphens}{url}
\RequirePackage{hyperref}
\RequirePackage{url}
\RequirePackage{mathpazo} % set math font
\RequirePackage{palatino}

%===============================================================================
% Formatting

\titleformat{\section} {\bf\large} {\thesection}{3mm}{} % section headings
\titleformat{\subsection} {\bf\large} {\thesubsection}{3mm}{} % subsection headings

\titleformat{\subsubsection} {\bf\normalsize} {\thesubsubsection}{3mm}{} % subsubsection headings

\setlength\columnsep{5mm} % increase column separation

\patchcmd{\thebibliography}{\section*{\refname}}{}{}{} % remove redundant "References" heading

\renewcommand{\bibsection}{} % remove redundant "References" heading (natbib)

\setlength{\bibsep}{0.0pt plus 0.3ex} % set bibliography spacing

\captionsetup{margin=10pt, font=footnotesize, labelsep=period, labelfont=bf}

\titlecontents*
    {chapter}% <section-type>
    [0pt]% <left>
    {}% <above-code>
    {\bfseries\chaptername\ \thecontentslabel\quad}% <numbered-entry-format>
    {}% <numberless-entry-format>
    {\bfseries\hfill\contentspage}% <filler-page-format>
  
\DisableLigatures[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]{encoding = *, family = * }

\urlstyle{rm} % print URLs in default Times New Roman font

%===============================================================================
% Styles

\definecolor{BackgroundBlue}{rgb}{0.0, 0.5, 1.0}
\definecolor{BlueNoteBackground}{rgb}{0.8, 0.9, 1.0}
\definecolor{TitleShadeColour}{rgb}{0.8, 0.9, 1.0}
\definecolor{shadecolor}{rgb}{0.8, 0.9, 1.0}

\newmdenv[leftline=false,rightline=false,backgroundcolor=TitleShadeColour]{topbotMDF}

%===============================================================================
% Title

\renewcommand{\maketitle}{%
\twocolumn[{
\@DrawTitle\\
\@AuthorList
\@DrawAbstract}

\bigskip
]
}

\newcommand{\@DrawTitle}
{
   \noindent
   \colorbox{TitleShadeColour}
   {\begin{minipage}{13.65cm}
          \vspace{3mm}
          \noindent
          \textbf{\Large\ \ \@Title}
          \vspace{1mm}
      \end{minipage}
   }
   \vspace{5mm}
}

\newcommand{\@AuthorList}{}
\newcommand{\@DrawAuthor}[2]
{
\bigskip\noindent\ \ \ \ \textbf {\large#1,} {\large \ #2}
}

\newcommand{\@DrawAbstract}
{
\bigskip
  \hfill\begin{minipage}{\linewidth-6em}
    \setstretch{0.9}
        {\it\small\@Abstract}
  \end{minipage}\hfill\hbox to 0pt{}
\bigskip
}

%===============================================================================
% Call-Outs

\newcommand{\Note}[2]
{
   \bigskip\noindent 
   \colorbox{#1} 
   {\parbox
      {.96\columnwidth} 
      {\small #2}
   }
   \vspace{2mm}  
}

%===============================================================================
% Headers

\pagestyle{fancy}

\fancyhf{}

\renewcommand{\headrulewidth}{0pt} % remove line

\fancyhead[RO,LE]{\thepage}

\fancyhead[CE]{{\small\textit{Game \& Puzzle Design}}}
\fancyhead[RE]{{\small Vol.~\@Volume, No.~\@Number,~\@Year}}
\fancyhead[CO]{{\small\@ShortTitle}}

\newcommand{\ShortAuthors}[1]{\renewcommand{\@ShortAuthorList}{#1}}
\newcommand{\@ShortAuthorList}{\@ShortFix{\@ShortAuthors}}

\fancyhead[LO]{{\small\@ShortAuthorList}}

\newcommand{\@ShortFix}[1]{%
\StrCount{#1}{ and }[\@ands]
\setcounter{@ands}{\@ands}
\ifnum\the@ands>1%
\StrBefore{#1}{ and }~\textit{et al.}
\else
#1
\fi
}

\newcommand{\BibAuthors}[1]{\renewcommand{\@BibAuthorList}{#1}}
\newcommand{\@BibAuthorList}{\@BibFix{\@BibAuthors}}

\fancypagestyle{firststyle}
{
\fancyhead[L]{}
\fancyhead[C]{{\small\textit{\@Type}}}
\fancyfoot[L]{\footnotesize \@BibAuthorList, `\@ShortTitle,' {\it Game \& Puzzle Design}, vol.~\@Volume, no.~\@Number, \@Year, pp.~\@Pages. $\copyright$ \@Year}
}
\thispagestyle{firststyle}


\newcounter{@ands}

\newcommand{\@BibFix}[1]{%
\StrCount{#1}{ and }[\@ands]
\setcounter{@ands}{\@ands}
\addtocounter{@ands}{-1}
\ifnum\the@ands>0%
\StrSubstitute[\the@ands]{#1}{ and }{, }[\@bibtmp]
\StrSubstitute{\@bibtmp}{ and }{, and }
\else
#1
\fi
}

%===============================================================================
% Collation Supports

\newcommand{\ResetCounts}
{
   % Reset section, figure, table, footnote, etc. to 0 for next article
   \setcounter{section}{0}
   \setcounter{figure}{0}
   \setcounter{table}{0}
   \setcounter{footnote}{0}
   \renewcommand*{\theHsection}{chY.\the\value{section}}
}

%===============================================================================
% Text Manipulations

%\newcommand{\shortcut}[1]{%
%  \@tempswafalse
%  \@for\next:=#1\do
%    {\if@tempswa+\else\@tempswatrue\fi\textbf{\next}}%
%}


\ExplSyntaxOn
\NewDocumentCommand{ \@IterateSpaceList }{ mm }{
    \seq_set_split:Nnn \l_tmpa_seq { ~ } { #2 }
    \seq_map_inline:Nn \l_tmpa_seq {
        #1{##1}
    }
}
\ExplSyntaxOff

\newcommand{\@FirstInitials}{}

\newcommand{\@firstinitialpre}{}
\newcommand{\@ExtractInitial}[1]{%
\StrLeft{#1}{1}[\@initial]%
\xappto{\@initials}{\@firstinitialpre \@initial.}%
\renewcommand{\@firstinitialpre}{~}%
}

\newcommand{\@initials}{}

\newcommand{\@AuthorBreak}[1]{%
\renewcommand{\@initials}{}%
\@IterateSpaceList{\@ExtractInitial}{#1}%
\StrCount{\@initials}{~}[\@spaces]%
\StrBefore[\@spaces]{\@initials}{~}[\@FirstInitials]%
%
\StrCount{#1}{ }[\@spaces]%
\StrBehind[\@spaces]{#1}{ }[\@LastName]%
}

%===============================================================================
% Metadata

\newcommand{\@Type}{Document Type}
\newcommand{\@Title}{Title}

\newcommand{\Type}[1]{%
\renewcommand{\@Type}{#1}%
}

\newcommand{\Title}[1]{%
\renewcommand{\@Title}{#1}%
}

\newcommand{\@BibAnd}{}
\newcommand{\@AddBibAuthor}[1]{
\@AuthorBreak{#1}
\xappto{\@BibAuthors}{\@BibAnd\@LastName,~\@FirstInitials}
\renewcommand{\@BibAnd}{ and }
}

\newcommand{\@ShortAnd}{}
\newcommand{\@AddShortAuthor}[1]{
\@AuthorBreak{#1}
\xappto{\@ShortAuthors}{\@BibAnd\@FirstInitials~\@LastName}
\renewcommand{\@ShortAnd}{ and }
}

\newcommand{\Author}[2]{%
\xappto{\@AuthorList}{\expandonce{\@DrawAuthor{#1}{#2}\\}}
\@AddShortAuthor{#1}
\@AddBibAuthor{#1}
}

\newcommand{\@Abstract}{Abstract}
\newcommand{\Abstract}[1]{%
\renewcommand{\@Abstract}{#1}%
}

\newcommand{\@ShortTitle}{\@Title}

\newcommand{\@ShortAuthors}{}
\newcommand{\@BibAuthors}{}

\newcommand{\@Volume}{?}
\newcommand{\@Number}{?}
\newcommand{\@Year}{\the\year}

\newcommand{\Issue}[3]{%
\renewcommand{\@Volume}{#1}%
\renewcommand{\@Number}{#2}%
\renewcommand{\@Year}{#3}%
}

\newcommand{\@Pages}{\thepage--\pageref*{LastPage}}
\newcommand{\Pages}[2]{\renewcommand{\@Pages}{#1--#2}}

\AtBeginDocument{\fontsize{9pt}{12pt}\selectfont}

\endinput
