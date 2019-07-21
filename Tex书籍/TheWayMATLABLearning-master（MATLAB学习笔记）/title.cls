%----------------------------------------------------------------------------------------
%	TITLE PAGE
%----------------------------------------------------------------------------------------
% http://www.latextemplates.com/cat/title-pages
\newcommand*{\titleCover}{\begingroup % Create the command for including the title page in the document
\hbox{ % Horizontal box
\hspace*{0.05\textwidth} % Whitespace to the left of the title page
\rule{1pt}{\textheight} % Vertical line
\hspace*{0.05\textwidth} % Whitespace between the vertical line and title page text
\parbox[b]{0.75\textwidth}{ % Paragraph box which restricts text to less than the width of the page

{\noindent\Huge\bfseries MATLAB \\[0.5\baselineskip] 学习笔记 v0.1.3}\\[2\baselineskip] % Title
{\large \textit{MATLAB学习之路：功能与效率}}\\[4\baselineskip] % Tagline or further description
{\Large \textsc{陈磊}} % Author name

\vspace{0.5\textheight} % Whitespace between the title block and the publisher
{\noindent \today\\
\textit{email chenlei.here@gmail.com\\
blog {\href{http://herechen.github.io}{http://herechen.github.io}}\\
source {\href{https://github.com/HereChen/TheWayMATLABLearning}{https://github.com/HereChen/TheWayMATLABLearning}} }}\\
[0.0\baselineskip] % Publisher and logo
}}
\endgroup}

\newcommand\BookTitle{MATLAB学习笔记}
% \title{MATLAB学习笔记}
% \author{陈磊\\chenlei.here@gmail.com}
% \date{\today}