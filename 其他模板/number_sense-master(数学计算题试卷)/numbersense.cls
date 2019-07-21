\ProvidesClass{numbersense}

\LoadClass[11pt]{article}


\IfFileExists{embedall.sty}{\RequirePackage[source]{embedall}}{}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage[utf8]{inputenc}
\RequirePackage[]{multicol}
\RequirePackage{tgtermes}
\RequirePackage[T1]{fontenc}
\IfFileExists{microtype.sty}{\RequirePackage{microtype}}{}
\RequirePackage{paralist}
\RequirePackage{setspace}
\RequirePackage{etoolbox}
\RequirePackage{docmute}
\RequirePackage[absolute]{textpos}
\setlength{\TPHorizModule}{1in}%
\setlength{\TPVertModule}{1in}%

\RequirePackage{mathtools}
\DeclarePairedDelimiter\abs{\lvert}{\rvert}
\DeclarePairedDelimiter\norm{\lVert}{\rVert}

\RequirePackage[top=0.6in,bottom=0.8in,left=0.75in,right=0.75in]{geometry}

\RequirePackage{currfile-abspath}
\getmainfile% get real main file (can be different than jobname in some cases)
\filename@parse{\themainfile}
\gdef\answerkeyfile{\filename@base}

\setlength\parindent{0cm}
\setlength\columnsep{25pt}

\pagestyle{empty}

\newcommand{\bigdot}{~\textbullet~~}
\newcommand{\ans}{\hrulefill}

\renewcommand{\title}[1]{\gdef\NumSense@Title{#1}}
\newcommand{\subtitle}[1]{\gdef\NumSense@Subtitle{#1}}
\newcommand{\instructions}[1]{\gdef\NumSense@Instructions{#1}}
\newcommand{\columns}[1]{\gdef\NumSense@Columns{#1}}
\newcommand{\keycolumns}[1]{\gdef\NumSense@KeyColumns{#1}}
\newtoggle{makeanswerkey}\togglefalse{makeanswerkey}
\newcommand{\answerkey}[0]{\toggletrue{makeanswerkey}}
\newcommand{\problemspacing}[1]{\gdef\NumSense@ProblemSpacing{#1}}


\title{Number Sense Test}
\subtitle{}
\columns{2}
\keycolumns{4}

\problemspacing{1.2}

\newenvironment{questions}[0]{%
  \begin{multicols}{\NumSense@Columns}
    \begin{enumerate}[(1)]
 \setstretch{\NumSense@ProblemSpacing}
}{%
\end{enumerate}
\end{multicols}
}


\def\q{\@ifnextchar[{\@qwith}{\@qwithout}}
\def\question{\@ifnextchar[{\@qwith}{\@qwithout}}
\def\@qwith[#1]#2\par{\item #2\par}
\def\@qwithout#1\par{\item #1}

\def\aq{\@ifnextchar[{\@aqwith}{\@aqwithout}}
\def\aquestion{\@ifnextchar[{\@aqwith}{\@aqwithout}}
\def\@aqwith[#1]#2\par{\stepcounter{enumi}%
  \item[\hspace{-5.6pt}*(\arabic{enumi})]#2}
\def\@aqwithout#1\par{\stepcounter{enumi}%
  \item[\hspace{-5.6pt}*(\arabic{enumi})]#1}


\instructions{%
  \begin{textblock}{3.75}(4,0.95)
    \begin{flushright} \footnotesize
      \setstretch{1.5}
      Final \rule{1.3cm}{0.5pt} \rule{1.3cm}{0.5pt} \\
      2nd \rule{1.3cm}{0.5pt} \rule{1.3cm}{0.5pt} \\
      1st  \rule{1.3cm}{0.5pt} \rule{1.3cm}{0.5pt}\\
      \setstretch{1}
      Score~~~~~~~~Initials~~~~~~\\
    \end{flushright}
  \end{textblock}

  \vspace{1mm}

  \begin{flushleft}\bfseries
    Contestant's Number \rule{2cm}{0.5pt}
  \end{flushleft}

  \begin{multicols}{3}\bfseries
    Read directions carefully\\ before beginnning test.
    \columnbreak
    \begin{center}
      DO NOT UNFOLD THIS SHEET\\ UNTIL TOLD TO BEGIN
    \end{center}
    \columnbreak
    \rule{0pt}{1pt}
  \end{multicols}

\textbf{Directions:}
Do not turn this page until the person conducting this test gives the signal to
begin. This is a ten-minute test. There are 80 problems.  Solve accurately and
quickly as many as you can in the order in which they appear. ALL PROBLEMS ARE
TO BE SOLVED MENTALLY.\, Make no calculations with paper and pencil.  Write only the answer in the space provided at the end of each problem.  Problems marked
with a (*) require approximate integral answers; any answer to a starred problem
that is within five percent of the exact answer will be scored correct; all other
problems require exact answers.
\vspace{3mm}

\textbf{The person conducting this contest should explain these directions to
  the contestants.}

\begin{center}
  \textbf{STOP -- WAIT FOR SIGNAL!}
\end{center}
\vspace{1mm}
}


\AtBeginDocument{%
  \begin{center}\large\bfseries
  \NumSense@Title\\
  \if \NumSense@Subtitle
    \relax \relax
  \else
    \mbox{\NumSense@Subtitle}\\
  \fi
\end{center}
{\small \NumSense@Instructions}
}

\AtEndDocument{
  \iftoggle{makeanswerkey}{%
    % make answer key
    \newpage

    \def\q{\@ifnextchar[{\@qwith}{\@qwithout}}
    \def\question{\@ifnextchar[{\@qwith}{\@qwithout}}
    \def\@qwith[#1]#2\par{\item #1\par}
    \def\@qwithout#1\par{\item \rule{0pt}{1pt}}

    \def\aq{\@ifnextchar[{\@aqwith}{\@aqwithout}}
    \def\aquestion{\@ifnextchar[{\@aqwith}{\@aqwithout}}
    \def\@aqwith[#1]#2\par{\stepcounter{enumi}%
    \item[\hspace{-5.6pt}*(\arabic{enumi})]#1}
    \def\@aqwithout#1\par{\stepcounter{enumi}%
    \item[\hspace{-5.6pt}*(\arabic{enumi})]}


    {\large \NumSense@Title\\
        \if \NumSense@Subtitle
            \relax \relax
        \else
          \mbox{\NumSense@Subtitle}\\
        \fi
      Answer Key}
    \raggedcolumns
    \columns{\NumSense@KeyColumns}
     \input \answerkeyfile
  }{%
    % don't make answer key
    \relax
  }
}
