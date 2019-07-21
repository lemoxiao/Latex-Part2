% \iffalse meta-comment
%
% 
%   icmmcm.cls -- A LaTeX class to produce reports for the ICM and MCM
%                 contests
%
%
% Copyright (C) 2003-2016  Claire M. Connelly and the Department
%                          of Mathematics, Harvey Mudd College.
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, either version 1.3 of this license
% or (at your option) any later version.

% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.

% This work has the LPPL maintenance status `maintained'.

% The Current Maintainer of this work is Claire M. Connelly.
%
% \fi
%%
%% icmmcm class file
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{icmmcm}[2016/01/22 ICM/MCM Contest Submission Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax %% <-- fix if we decide to declare some options!
\LoadClass[11pt]{article}

%% Get some useful information about errors.
\setcounter{errorcontextlines}{25}

\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{mathpazo}
\RequirePackage{lastpage}
\RequirePackage{xspace}
\RequirePackage{verbatim}
\RequirePackage{booktabs}
\RequirePackage{ifthen}

%%% Define a command to take the letter of the question answered.
\newcommand{\@question}[1]{}
\newcommand{\question}[1]{\gdef\@question{#1}}
\global\let\@question\relax

%%% Define a command to take the contest.
\newcommand{\@contest}[1]{}
\newcommand{\contest}[1]{\gdef\@contest{#1}}
\global\let\@contest\relax



%%% Define a command for the ``team control number'', which is the
%%% only allowable identifier on the paper.
%%% We also redefine \@author here, to ensure that the only author
%%% information included in the document is the team number specified
%%% by the contest runners.
\newcommand{\@team}[1]{}
\newcommand{\team}[1]{\gdef\@team{#1}}



%%% Redefine the \maketitle command to include our extra information.

\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1em%
    {\Large \@contest\ Contest Question \@question}
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        Team \# \@team
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}



%%% Use the fancyhdr package to create nice headers
\RequirePackage{fancyhdr}
\pagestyle{fancy}

%%% Define the header as per the contest regulations.
\fancyhead{}
\fancyhead[LO,RE]{Team \# \@team}
\fancyhead[RO,LE]{Page~\thepage\ of \pageref{LastPage}}
\fancyfoot{}

%%% Redefine the plain pagestyle so that it includes the ``page x of
%%% y'' information, as well.

\fancypagestyle{plain}{%
  \fancyhf{} % clear all header and footer fields
  \fancyfoot[c]{Page~\thepage\ of \pageref{LastPage}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}


%%% Define a ``summary'' environment that will appear on a separate
%%% page.

\newenvironment{summary}{%
  \vspace{2.5in}
      \null\vfil
      \@beginparpenalty\@lowpenalty
  \thispagestyle{empty}
      \begin{center}%
        \bfseries Summary
        \@endparpenalty\@M
      \end{center}
}{\newpage%
\setcounter{page}{1}}%



\AtEndDocument{%
\typeout{}
\typeout{Remember, do not put the names of any team members,}
\typeout{your advisor, or your institution in the document!}
\typeout{}
}

