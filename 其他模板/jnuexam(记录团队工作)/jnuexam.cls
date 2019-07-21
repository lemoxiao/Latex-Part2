% -*- coding: utf-8 -*-
% ----------------------------------------------------------------------------
% Author:  Jianrui Lyu <tolvjr@163.com>
% Website: https://lvjr.bitbucket.io/jnuexam.html
% License: The LaTeX Project Public License 1.3
% ----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jnuexam}[2018/11/21 v0.5 An exam class for Jinan University]

\newif\ifsidebyside \sidebysidefalse % 是否 A3 纸张
\newif\ifreverse    \reversefalse    % 是否逆序出题
\newif\ifanswer     \answertrue      % 是否显示答案
\newif\ifsourcehan  \sourcehanfalse  % 切换思源字体
\newif\ifcollection \collectionfalse % 用于试卷题库

\DeclareOption{a3paper}{\sidebysidetrue}
\DeclareOption{reverse}{\reversetrue}
\DeclareOption{noanswer}{\answerfalse}
\DeclareOption{sourcehan}{\sourcehantrue}
\DeclareOption{collection}{\collectiontrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}} %其它选项

\ProcessOptions %不可省略

% 四号    小四号    五号      小五号
% 14bp    12bp      10.5bp    9bp
\LoadClass[cs4size,UTF8,noindent]{ctexart}

\ifsidebyside
  \RequirePackage[a3paper,landscape,twocolumn,columnsep=40mm,left=50mm,right=30mm,top=25mm,bottom=25mm]{geometry}
\else
  \RequirePackage[a4paper,left=30mm,right=30mm,top=25mm,bottom=25mm]{geometry}
\fi

\RequirePackage{tabu}
\RequirePackage{amssymb}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{comment}
\RequirePackage{environ}
\RequirePackage{etoolbox}
\RequirePackage{calc}

\setlength{\parindent}{0em}
\setlength{\lineskiplimit}{3pt}
\setlength{\lineskip}{3pt}

%% ---------------------------------------------------------------------------
%% 密封线命令 \mifengxian
%% 草稿纸命令 \caogaozhi
%% 这两个命令仅在 A3 纸张中用到，且需要编译两次才能得到正确结果
%% ---------------------------------------------------------------------------

\newcommand{\mifengxian}{%
\def\1{\\[50mm]}\def\2{\\[15mm]}%
\begin{tikzpicture}[remember picture,overlay,very thick,font=\large]
  \path (current page.south west) +(2cm,1cm)  coordinate (a1);
  \path (current page.north west) +(2cm,-1cm) coordinate (a2);
  \path (current page.south west) +(3cm,1cm)  coordinate (b1);
  \path (current page.north west) +(3cm,-1cm) coordinate (b2);
  \draw[dashed] (a1) -- node[left=1mm,text width=1em]{装\1订\1线}
     node[right=1mm,text width=1em]{学\2生\2答\2卷\2不\2要\2超\2过\2此\2线} (a2);
  \draw (b1) -- (b2);
\end{tikzpicture}}

\newcommand{\caogaozhi}{%
\begin{tikzpicture}[remember picture,overlay,font=\sffamily\fontsize{180pt}{180pt}\selectfont]
  \node[text=lightgray!40] at (current page.center) {草\quad 稿\quad 纸};
\end{tikzpicture}}

\ifsidebyside
  \RequirePackage{tikz}
  \RequirePackage{everypage}
  \AddEverypageHook{\mifengxian}
  % 在 twocolumn 文档中，\newpage 可能是到下一栏，\clearpage 才能保证到下一页
  \preto{\@enddocumenthook}{\clearpage\pagestyle{empty}\caogaozhi\clearpage\caogaozhi\addtocounter{page}{-2}}
  % 在旧版本 ctex 宏包中不能用 \AtEndDocument 添加含中文的内容，即不能用 \appto 而要用 \preto
  %\AtEndDocument{\clearpage\pagestyle{empty}\caogaozhi\clearpage\caogaozhi\addtocounter{page}{-2}}
  \RequirePackage{pdfpages}
  % 新版本 pdfpages 将 \includepdf 放在文档开头时会有命令未定义的错误
  % 见 https://tex.stackexchange.com/questions/352007/ieeetran-and-pdfpages
  % 另外从 LaTeX release 2018 开始 \@ifundefined 不再将未定义命令定义为 \relax
  % 见 https://www.latex-project.org/news/latex2e-news/ltnews28.pdf
  \@ifundefined{@setmarks}{\let\@setmarks\relax}{}
\fi

%% ---------------------------------------------------------------------------
%% 试卷表头命令 \makehead
%% ---------------------------------------------------------------------------

\newcommand{\niandu}{2016-2017}
\newcommand{\xueqi}{2}
\newcommand{\kecheng}{数学课程}
\newcommand{\zhuanye}{}  % 专业学分
\newcommand{\jiaoshi}{吕荐瑞}
\newcommand{\shijian}{}  % 考试日期
\newcommand{\bixiu}{1}   % 1 为必修，0 为选修
\newcommand{\bijuan}{1}  % 1 为闭卷，0 为开卷
\newcommand{\shijuan}{A} % A 或 B 或 C 卷
\newcommand{\neizhao}{1} % 1 打勾，0 不勾
\newcommand{\waizhao}{1} % 1 打勾，0 不勾

\newcommand{\underspace}[1]{\kern0pt\underline{\hspace{#1}}\kern0pt\relax}
\newcommand{\underbox}[2]{\kern0pt\underline{\makebox[#1]{#2}}\kern0pt\relax}
\newcommand{\underparbox}[2]{\kern0pt\underline{\parbox[b]{#1}{#2}}\kern0pt\relax}

\newcommand{\ischeck}[1]{\ifnum#1>0\,$\checkmark$\,\else\quad\fi}
\newcommand{\isquad}[1]{\ifnum#1=0\,$\checkmark$\,\else\quad\fi}

\newcommand\my@temp@a{A}
\newcommand\my@temp@c{C}
\newcommand\my@empty{}

\newcommand{\head@table@a}{%
  \begin{tabular}{l}
    \underbox{11em}{\niandu}学年度第\underbox{5.5em}{\xueqi}学期 \\
    课程名称：\underbox{17.5em}{\kecheng\ifx\zhuanye\my@empty\else\kern0pt(\zhuanye)\fi} \\
    授课教师：\underparbox{17.5em}{\centering\rule{0pt}{3ex}\jiaoshi} \\
    考试时间：\underbox{17.5em}{\shijian} \\
  \end{tabular}
}

\newcommand{\head@table@b}{%
  \renewcommand{\arraystretch}{1}%
  \begin{tabular}{l}
    \textbf{课程类别} \\ 必修~[\ischeck{\bixiu}]\quad 选修~[\isquad{\bixiu}] \\
    \hline
    \textbf{考试方式} \\ 开卷~[\isquad{\bijuan}]\quad 闭卷~[\ischeck{\bijuan}] \\
    \hline
    \textbf{试卷类别}~(\,A, B, C\,)\\\relax [\,\shijuan\,]\hfill 共~\pageref{LastPage}~页
  \end{tabular}
}

\newcommand{\head@table@c}{%
  \begin{tabular}{l}
    \underspace{10em}学院\underspace{8em}专业\underspace{7.5em}班\kern0pt(\kern0pt{}级\kern0pt) \\[1em]
    姓名\underspace{8em}学号\underspace{10em}\hfill
    \bfseries 内招~[\ischeck{\neizhao}] 外招~[\ischeck{\waizhao}] %\\[0.8em]
  \end{tabular}
}

\newcommand{\makehead}{
  \thispagestyle{plain}
  \centerline{\LARGE\bfseries 暨\quad 南\quad 大\quad 学\quad 考\quad 试\quad 试\quad 卷}
  \vspace{2em}%
  \ifreverse
    \ifx\shijuan\my@temp@a\renewcommand{\shijuan}{B}\fi
    \ifx\shijuan\my@temp@c\renewcommand{\shijuan}{D}\fi
  \fi
  \noindent
  \begin{tabu}{|@{}X@{}|}
    \hline\renewcommand{\arraystretch}{1.5}%
    \begin{tabu}{@{}>{\bfseries}l@{}|@{}X@{}|@{}l@{}}
      \begin{tabular}{l}教\\ 师\\ 填\\ 写\end{tabular} & \head@table@a & \head@table@b
    \end{tabu}\\
    \hline\renewcommand{\arraystretch}{0.9}%
    \begin{tabu}{@{}>{\bfseries}l@{}|@{}X@{}}
      \begin{tabular}{l}考\\ 生\\ 填\\ 写\end{tabular} & \head@table@c
    \end{tabu}\\
    \hline
  \end{tabu}
  \vspace{1em}
  \noindent\begin{tabu}{|*{8}{X[c]|}}
    \hline
    \bfseries{题 号} & 一 & 二 & 三 & 四 & 五 & 六 & 总 分\\
    \hline
    \bfseries{得 分} &  &  &  &  &  &  & \\
    \hline
  \end{tabu}
}

%% ---------------------------------------------------------------------------
%% 页眉页脚设定
%% ---------------------------------------------------------------------------

\newcommand{\my@columnbox}[1]{\makebox[\columnwidth]{#1}}
\newcommand{\my@headleft}{暨南大学\kern-0.3em《\kecheng》\kern-0.3em 试卷\,\shijuan}
\newcommand{\my@headright}{姓名\hspace{6em}学号\hspace{6em}}
\newcommand{\my@headtext}{\my@headleft\hfill \my@headright}
\newcommand{\my@foottext}{第~\thepage~页\quad 共~\pageref{LastPage}~页}

\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}%
  \fancyhf{}
  \ifsidebyside
    \rhead{\small\underline{\my@columnbox{\my@headtext\strut}}}
    \lfoot{\small\my@columnbox{\my@foottext}}
    \rfoot{\small\my@columnbox{\stepcounter{page}\my@foottext}}
  \else
    \cfoot{\small\my@foottext}
  \fi
}
\fancyhf{}
\pagestyle{fancy}
\ifsidebyside
  \renewcommand{\headrulewidth}{0pt}%
  \lhead{\small\underline{\my@columnbox{\my@headtext}\strut}}
  \rhead{\small\underline{\my@columnbox{\my@headtext}\strut}}
  \lfoot{\small\my@columnbox{\my@foottext}}
  \rfoot{\small\my@columnbox{\stepcounter{page}\my@foottext}}
\else
  \lhead{\small\my@headleft}
  \rhead{\small\my@headright}
  \cfoot{\small\my@foottext}
\fi

%% ---------------------------------------------------------------------------
%% 题型命令 \makepart
%% 附录命令 \makedata
%% 题目环境 problem
%% 解答环境 solution
%% 逆序选项 reverse
%% ---------------------------------------------------------------------------

\xdef\allproblems{}
\xdef\lastproblem{}
\newcounter{problem}
\newcounter{choice} % 后面选择题的 abcd 环境要用到
\newcounter{step}   % 后面解答题的 \step 命令要用到

\newcommand{\printproblems}{\ifreverse\lastproblem\allproblems\fi\xdef\allproblems{}\xdef\lastproblem{}}

\newcommand{\makepart}[2]{%
    \printproblems
    \setcounter{problem}{0}%
    \stepcounter{section}%
    \vspace{1em}%
    \noindent\begin{tabu}{|X[c]|X[c]|X[6]}
      \cline{1-2}
      得分 & 评阅人 & \textbf{\Chinese{section}、#1}\\
      \cline{1-2}
      &  & (#2) \\
      \cline{1-2}
    \end{tabu}
    \vspace{1em}
}

\newcommand{\makedata}[1]{%
  \printproblems\my@stop@reverse
  \centerline{\textbf{附录}\quad #1}\smallskip
}

\preto{\@enddocumenthook}{\printproblems\my@stop@reverse}

\newcommand\ignorepars{\@ifnextchar\par{\expandafter\ignorepars\@gobble}{}}

\newenvironment{problemreal}{%
  \stepcounter{problem}\setcounter{choice}{0}\setcounter{step}{0}%
  \textsf{\color{blue}\arabic{problem}}.\;\,\ignorespaces
}{\par}
\newenvironment{solutionreal}{%
  \setcounter{step}{0}%
  \textsf{\color{blue}解答}\quad\ignorepars
}{\par}

\let \oldnewpage   = \newpage
\let \oldvfill     = \vfill
\let \oldsmallskip = \smallskip
\let \oldmedskip   = \medskip
\let \oldbigskip   = \bigskip

\ifreverse
  \NewEnviron{problem}{%
    \xdef\allproblems{%
      \unexpanded\expandafter{\lastproblem}%
      \unexpanded\expandafter{\allproblems}%
    }%
    \xdef\lastproblem{%
      \unexpanded{\begin{problemreal}}%
      \unexpanded\expandafter{\BODY}%
      \unexpanded{\end{problemreal}}%
    }%
  }
  \NewEnviron{solution}{%
    \xdef\lastproblem{%
      \unexpanded\expandafter{\lastproblem}%
      \unexpanded{\begin{solutionreal}}%
      \unexpanded\expandafter{\BODY}%
      \unexpanded{\end{solutionreal}}%
    }%
  }
  \renewcommand{\newpage}{\xdef\lastproblem{\noexpand\oldnewpage\unexpanded\expandafter{\lastproblem}}}
  \renewcommand{\vfill}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldvfill}}}
  \renewcommand{\smallskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldsmallskip}}}
  \renewcommand{\medskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldmedskip}}}
  \renewcommand{\bigskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldbigskip}}}
  \let \newpagea = \relax
  \let \newpageb = \newpage
\else
  \newenvironment{problem}{\problemreal}{\endproblemreal}
  \newenvironment{solution}{\solutionreal}{\endsolutionreal}
  \let \newpagea = \newpage
  \let \newpageb = \relax
\fi

\newcommand{\my@stop@reverse}{%
  \ifreverse
    \renewenvironment{problem}{\problemreal}{\endproblemreal}%
    \renewenvironment{solution}{\solutionreal}{\endsolutionreal}%
    \let \newpage   = \oldnewpage
    \let \vfill     = \oldvfill
    \let \smallskip = \oldsmallskip
    \let \medskip   = \oldmedskip
    \let \bigskip   = \oldbigskip
  \fi
}

\def\CommentCutFile{\jobname.cut}

\AtBeginDocument{%
  \ifanswer\else
    \excludecomment{solution}
  \fi
}

%% ---------------------------------------------------------------------------
%% 答题栏命令 \answertable
%% ---------------------------------------------------------------------------

\gdef\answer@lines@temp{}%
\newcommand{\answer@lines@add}[1]{%
  \xdef\answer@lines@temp{\answer@lines@temp#1}%
}

\newrobustcmd{\answer@number@hided}[1]{小题} % 在 PDFLaTeX 中需要保护中文
\newrobustcmd{\answer@cell@strut}[1]{\parbox[c][#1][c]{2em}{\hbox{答案}}}

\newcounter{answer@col}
\newcounter{answer@row}
\newcounter{answer@total}

\newcommand{\answer@lines}[3]{%
  % #1 答题栏各栏指定高度
  % #2 答题栏总共答案个数
  % #3 答题栏每行答案个数
  \setcounter{answer@row}{(#2-1)/#3+1}% 除法向下取整，改为向上取整
  \begingroup
  \let\hline=\relax  \let\\=\relax % 禁止展开
  \gdef\answer@lines@temp{}%
  \setcounter{answer@total}{1}%
  \whileboolexpr{
      test{\ifnumgreater{\value{answer@row}}{0}}
  }{%
      \addtocounter{answer@row}{-1}%
      \answer@lines@add{\answer@number@hided}%
      \setcounter{answer@col}{1}%
      \unlessboolexpr{%
          test{\ifnumgreater{\value{answer@col}}{#3}}%
      }{%
          \answer@lines@add{&}%
          \ifnumgreater{\value{answer@total}}{#2}{}{%
            \answer@lines@add{\arabic{answer@total}}%
          }%
          \stepcounter{answer@col}%
          \stepcounter{answer@total}%
      }%
      \answer@lines@add{\\ \hline \answer@cell@strut{#1}}%
      \setcounter{answer@col}{1}%
      \unlessboolexpr{
          test{\ifnumgreater{\value{answer@col}}{#3}}
      }{%
          \answer@lines@add{&}%
          \stepcounter{answer@col}%
      }%
      \answer@lines@add{\\ \hline}%
  }%
  \endgroup
  \answer@lines@temp
}

\newcommand{\answertable}[3][1em]{%
  答题须知：本题答案必须写在如下表格中，否则不给分．\par
  \begin{tabu}{|c|*{#3}{X[c]|}}
    \hline
    \answer@lines{#1}{#2}{#3}
  \end{tabu}%
  \par\vspace{0.8em}%
}

%% ---------------------------------------------------------------------------
%% 答案切换命令 \answer
%% 填空命令 \fillin 和 \fillout
%% 选择命令 \pickin 和 \pickout
%% 四个选项排版环境 abcd，根据四个选项的长度自动排成一行、两行或四行
%% ---------------------------------------------------------------------------

\newcommand{\answer}[1]{\ifanswer#1\else\phantom{#1}\fi}

\newcommand{\ulinefill}[1]{\xleaders\hbox{\underline{\vphantom{#1}\kern1pt}}\hfill\kern0pt}
\newcommand{\fillout}[1]{\allowbreak\hbox{}\nobreak\ulinefill{#1}\underline{\color{blue}\answer{#1}}\ulinefill{#1}}
\newcommand{\fillin}[1]{\underline{\hspace{1em}\color{blue}\answer{#1}\hspace{1em}}}

\newcommand{\cdotfill}{\leavevmode\xleaders\hbox to 0.5em{\hss$\cdot$\hss}\hfill\kern0pt\relax}
\newcommand{\pickout}[1]{\unskip\nobreak\cdotfill(\makebox[1.5em]{\color{blue}\answer{#1}})}
\newcommand{\pickin}[1]{\unskip\nobreak\hspace{0.3em}(\makebox[1.5em]{\color{blue}\answer{#1}})\hspace{0.3em}\ignorespaces}

\newlength{\my@item@len}
\newcommand\my@item@temp{%
  \unskip\cr\stepcounter{choice}(\Alph{choice})\ %
}
\newcommand\my@item@box{%
  \hfill\egroup\hfill\hbox to \my@item@len\bgroup
  \stepcounter{choice}(\Alph{choice})\ \ignorespaces
}
\newcommand\my@item@par{%
  \par\stepcounter{choice}(\Alph{choice})\ \ignorespaces
}
\NewEnviron{abcd}{
  \unskip
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{0pt}%
  \setcounter{choice}{0}%
  \let\item=\my@item@temp
  \settowidth{\my@item@len}{\vbox{\halign{##\hfil\cr\BODY\crcr}}}%
  \setcounter{choice}{0}%
  \ifdim\my@item@len>0.486\linewidth
    \setlength{\my@item@len}{\linewidth}%
    \let\item=\my@item@par
    \BODY\par
  \else
    \ifdim\my@item@len>.243\linewidth
      \setlength{\my@item@len}{0.5\linewidth}%
    \else
      \setlength{\my@item@len}{0.25\linewidth}%
    \fi
    \let\item=\my@item@box
    \par\bgroup\BODY\hfill\egroup\par
  \fi
}

%\newcommand{\my@item}{\ifnum\value{choice}=0\par\fi\stepcounter{choice}}
%\newcommand{\fullitem}[1]{\my@item\parbox{\linewidth}{(\Alph{choice})\ #1\rule[-0.5em]{0pt}{0.5em}}\hfill\ignorespaces}
%\newcommand{\halfitem}[2][0.5]{\my@item\makebox[#1\linewidth][l]{(\Alph{choice})\ #2}\hfill\ignorespaces}
%\newcommand{\quaritem}[2][0.25]{\my@item\makebox[#1\linewidth][l]{(\Alph{choice})\ #2}\hfill\ignorespaces}

%% ---------------------------------------------------------------------------
%% 解答题步骤命令 \step
%% ---------------------------------------------------------------------------

\newcommand{\step}{%
  \stepcounter{step}%
  \makebox[2em][l]{\ttfamily(\arabic{step})}%
}

%% ---------------------------------------------------------------------------
%% 评分命令 \score
%% ---------------------------------------------------------------------------

\PassOptionsToPackage{tbtags}{amsmath}
\RequirePackage{amsmath}

\newcommand{\myscore}[1]{\textcolor{blue}{#1\kern0.2em 分}}

\newcommand{\scoretext}[1]{\cdotfill\myscore{#1}\par\noindent\ignorespaces}
\newcommand{\scoreeqno}[1]{\eqno{\cdots\cdots\text{\myscore{#1}}}}
\newcommand{\scoretag}[1]{\tag*{$\cdots\cdots$\myscore{#1}}}

\newrobustcmd{\score}[1]{%
  \ifbool{mmode}{%
    \ifdefstrequal{\tag}{\dft@tag}{\scoreeqno{#1}}{\scoretag{#1}}%
  }{%
    \scoretext{#1}%
  }%
}

%% ---------------------------------------------------------------------------
%% 载入个人定制文件 jnuexam.cfg
%% 中文字体切换选项 sourcehan
%% ---------------------------------------------------------------------------

\InputIfFileExists{jnuexam.cfg}{}{}

\newcommand{\my@set@sourcehan}{
  \setCJKmainfont[BoldFont=Source Han Sans SC]{Source Han Serif SC}
  \setCJKsansfont{Source Han Sans SC}
  % 用中文字体名时 LuaTeX 找不到该字体，XeTeX 正常
  %\setCJKmainfont[BoldFont=思源黑体]{思源宋体}
  %\setCJKsansfont{思源黑体}
}

\ifbool{sourcehan}{
  \RequirePackage{iftex}
  % https://sourceforge.net/p/xetex/code/ci/master/tree/source/texk/web2c/xetexdir/NEWS
  \ifbool{XeTeX}{ % TeXLive 2015
    \ifdimless{\the\XeTeXversion\XeTeXrevision pt}{0.99992pt}{}{\my@set@sourcehan}
  }{}
  \ifbool{LuaTeX}{\my@set@sourcehan}{}
}{}

%% ---------------------------------------------------------------------------
%% 试卷题库选项 collection
%% ---------------------------------------------------------------------------

\ifcollection
  \RequirePackage{hyperref}
  \hypersetup{
    pdfstartview={FitH},
    bookmarksnumbered=true,
    unicode=true,
    hidelinks=true
    %colorlinks=true,
    %linkcolor=black
  }
  \appto{\endproblem}{\medskip}
  \appto{\endsolution}{\medskip}
  \preto{\problem}{\ifnum\value{problem}=9 \setcounter{problem}{-1}\fi}
  \pagestyle{plain}
\fi

%% ---------------------------------------------------------------------------
%% 载入常用宏包，定义常用命令
%% ---------------------------------------------------------------------------

\AtBeginDocument{
  \setlength{\abovedisplayskip}{4pt minus 2pt}
  \setlength{\belowdisplayskip}{4pt minus 2pt}
  \setlength{\abovedisplayshortskip}{2pt}
  \setlength{\belowdisplayshortskip}{2pt}
}

\setlength\arraycolsep{4pt}

\RequirePackage{CJKfntef}
\RequirePackage{multirow}
\RequirePackage{diagbox}

\RequirePackage{relsize}
\newcommand{\Int}{\mathop{\mathlarger{\int}}}

\newcommand{\e}{\mathrm{e}}
\newcommand{\limit}{\lim\limits}
\newcommand{\R}{\mathbb{R}}

\DeclareMathOperator{\Corr}{\rho}
\DeclareMathOperator{\Cov}{Cov}
\DeclareMathOperator{\grad}{grad}
\DeclareMathOperator{\Prj}{Prj}
\DeclareMathOperator{\Var}{Var}

\newcommand{\diff}{\mathop{}\!\mathrm{d}}
\newcommand{\dx}{\diff x}
\newcommand{\dy}{\diff y}
\def\dz{\diff z} % 不确定命令是否已经定义
\newcommand{\du}{\diff u}
\newcommand{\dv}{\diff v}
\newcommand{\dr}{\diff r}
\newcommand{\ds}{\diff s}
\newcommand{\dt}{\diff t}
\newcommand{\dS}{\diff S}
% 有些宏包比如 hyperref 会修改 \d 的定义，所以放在 document 开始处
% 利用 etoolbox 将 \d 定义为健壮命令，以避免在 align 等环境中错误地展开
\AtBeginDocument{%
  \let\oldd=\d
  \renewrobustcmd{\d}{\ifbool{mmode}{\diff}{\oldd}}%
}

\newcommand{\va}{\vec{a\vphantom{b}}}
\newcommand{\vb}{\vec{b}}
\newcommand{\vc}{\vec{c\vphantom{b}}}
\newcommand{\vd}{\vec{d}}
\newcommand{\ve}{\vec{e}}
\newcommand{\vi}{\vec{i}}
\newcommand{\vj}{\vec{j}}
\newcommand{\vk}{\vec{k}}
\newcommand{\vn}{\vec{n}}
\newcommand{\vs}{\vec{s}}
\newcommand{\vv}{\vec{v}}

\let\ov=\overrightarrow

\let\le=\leqslant
\let\ge=\geqslant

\let\lb=\{
\let\rb=\}

\def\T{\mathrm{T}\kern-.5pt}

\newrobustcmd{\wfrac}[3][2pt]{%
  {\begingroup\hspace{#1}#2\hspace{#1}\endgroup\over\hspace{#1}#3\hspace{#1}}%
}

