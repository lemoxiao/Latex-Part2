
\providecommand\ANSWERS{F}
\providecommand\SUPP{F}

\LoadClass[12pt]{article}
\RequirePackage{color,geometry,fancyhdr,graphicx,lastpage,keyval}
\geometry{a4paper,top=4cm,bottom=3cm,left=3cm,right=3cm}

\pagestyle{fancy}
\fancyhead{}{}
\fancyfoot{}{}
\lhead{Course ID: \COURSEID}
\rhead{Page~\thepage~of~\pageref{LastPage}}
\makeatletter
\cfoot{\NEXTPAGETEXT}
\if \ANSWERS T \relax
  \newcommand\ANS[1]{\par{\itshape\ignorespaces #1\unskip\par}}
  \newcommand\NEXTPAGETEXT{}
\else
  \newcommand\NEXTPAGETEXT{%
    \ifdefined\r@LastPage
      \ifnum \c@page = \expandafter\@secondoftwo\r@LastPage \relax
        END OF EXAMINATION%
      \else
        PLEASE SEE NEXT PAGE%
      \fi
    \else
      PLEASE RE-RUN \LaTeX!%
    \fi
  }  
  \newcommand\ANS[1]{}
\fi
\newcommand\TOTALMARKS{%
  \bigskip\noindent
  \addtocounter{totalmarks}{\value{marks}}%
  \stepcounter{Nparts}%
  \textbf{Total marks: \arabic{marks}.}%
  \newcounter{markedpart:\theNparts}
  \setcounter{markedpart:\theNparts}{\numexpr\value{marks}-1\relax}
  \refstepcounter{markedpart:\theNparts}
  \label{markedpart:\theNparts}
  \setcounter{marks}{0}
}

\def\COUNTMARKS{
  \addtocounter{totalmarks}{-1}
  \refstepcounter{totalmarks}
  \label{marks:total}
  
  \addtocounter{Nparts}{-1}
  \refstepcounter{Nparts}
  \label{parts:total}
}


\newcounter{totalmarks}
\newcounter{Nparts}

\newcounter{marks}
\newcommand\MARKS[1]{\addtocounter{marks}{#1}\hfill\penalty100\hspace*{\fill}\textsc{\fontsize{9}{9}\selectfont [marks:~\oldstylenums{#1}]}\ignorespaces}

\newenvironment{coverpage}{
  \begin{titlepage}
  \setlength\parindent{0pt}
  
  \centerline{%
    \IfFileExists{uni-logo.pdf}{\includegraphics{uni-logo}}{%
      \color{red} \textbf{LOGO MISSING}. Download the university logo and call it \texttt{uni-logo.pdf}.%
    }
  }
  
  \bigskip
  
  \begin{center}
  \large
  \bfseries
  \centerline{\if \SUPP T\relax
    Supplementary
  \fi
  Examination for the Degree of \DEGREETYPE{} of Engineering}
  \bigskip
  \SEMESTER, \YEAR
  \end{center}
  
  \bigskip
  
  \centerline{\fbox{\parbox{\linewidth}{\large\bfseries
  MECH ENG \SUBJECTCODE\ \COURSENAME\\
  COURSE ID: \COURSEID
  }}}
  
  \bigskip
  
  \if\ANSWERS T
  \centerline{\Huge\bfseries\color{red} SOLUTIONS}
  \bigskip
  \fi
  
  \begin{flushleft}
  \begin{tabular}{@{}ll}
  Official Reading Time: & 10 mins\\
  Writing Time: & \EXAMTIME\ mins\\
  Total Duration: & \the\numexpr \EXAMTIME+10\relax\ mins
  \end{tabular}
  \end{flushleft}
  
  \bigskip
  
  
\makeatletter

\let\@tempa\@empty

\ifcsname r@parts:total\endcsname

\@tempcnta=1\relax
\loop
  \edef\@tempb{
    \the\@tempcnta & 
    Answer All Questions & 
    \unexpanded{\the\numexpr}
    \EXAMTIME*\expandafter\expandafter\expandafter\@firstoftwo\csname r@markedpart:\the\@tempcnta\endcsname    
    /\expandafter\expandafter\expandafter\@firstoftwo\csname r@marks:total\endcsname
    \relax\
    mins & 
    \noexpand\ref{markedpart:\the\@tempcnta} marks \noexpand
    \\}
  \expandafter\g@addto@macro\expandafter\@tempa\expandafter{\@tempb}

  \advance\@tempcnta by 1\relax
\ifnum\@tempcnta <
  \expandafter\expandafter\expandafter
    \@secondoftwo\csname r@parts:total\endcsname
\repeat

\fi

\begin{center}
\begin{tabular}{@{}llll}
\bfseries Parts & \bfseries Questions & \bfseries Approx.\ time & \bfseries Marks \\
\@tempa
\cline{4-4}
& & & \ref{marks:total} total
\end{tabular}
\end{center}

\bigskip
}{
  \vfill
  \centerline{DO NOT COMMENCE WRITING UNTIL INSTRUCTED TO DO SO}
  \end{titlepage}
  \stepcounter{page}
}

\newcommand\examsetup{\setkeys{mechexam}}

\define@key{mechexam}{teaching-period}{\def\SEMESTER{#1}}
\define@key{mechexam}{year}{\def\YEAR{#1}}
\define@key{mechexam}{course-name}{\def\COURSENAME{#1}}
\define@key{mechexam}{course-code}{\def\SUBJECTCODE{#1}}
\define@key{mechexam}{course-id}{\def\COURSEID{#1}}
\define@key{mechexam}{degree-type}{\def\DEGREETYPE{#1}}
\define@key{mechexam}{exam-time}{\def\EXAMTIME{#1}}

\def\COURSENAME{[Course name]}
\def\SUBJECTCODE{[Course code]}
\def\COURSEID{[Course ID]}
\def\DEGREETYPE{Bachelor}
\def\EXAMTIME{180}
\def\YEAR{\the\year}


