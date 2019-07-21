% awesome-cookbook class
%
% This class has been downloaded from:
% https://github.com/Nooby4Ever/awesome-cookbook
%
%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------
\ProvidesClass{awesome-cookbook}[2016/08/30 v1.0 Awesome Cookbook]
\NeedsTeXFormat{LaTeX2e}


%-------------------------------------------------------------------------------
%                Class options (book)
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{book}
}
\ProcessOptions\relax
\LoadClass{book}


%-------------------------------------------------------------------------------
%                3rd party packages
%-------------------------------------------------------------------------------
% Support for feature-rich AAT and OpenType fonts
% Note: must be loaded BEFORE polyglossia package
\RequirePackage[quiet]{fontspec}
% Bable alternative for XeLaTeX and LuaLaTeX (although bable works too...)
\RequirePackage{polyglossia}
% Extends array and tabular environment column formats
\RequirePackage{array}
% Pro­vides user con­trol over the lay­out of the,
% three ba­sic list en­vi­ron­ments: enu­mer­ate, item­ize and de­scrip­tion
\RequirePackage{enumitem}
% Needed to handle text alignment (provides en­vi­ron­ments Cen­ter, 
% FlushLeft, and FlushRight + commands \Cen­ter­ing, \RaggedLeft, and \RaggedRight)
\RequirePackage{ragged2e}
% Needed to configure page layout
\RequirePackage{geometry}
% Needed to manage colors
\RequirePackage{xcolor}
% A toolbox of programming tools
\RequirePackage{etoolbox}
% Needed to change line spacing in specific environment
\RequirePackage{setspace}
\defaultfontfeatures{Ligatures=TeX} % To support LaTeX quoting style
% Needed to manage math fonts
\RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}
% Needed to use icons from font-awesome
% (https://github.com/posquit0/latex-fontawesome)
\RequirePackage{fontawesome}
% Needed to deal a paragraphs
\RequirePackage{parskip}
% Needed to deal hyperlink
\RequirePackage{hyperref}
% Custom graphics
\RequirePackage{tikz}
% Customize titles; newparttoc is required to customize the \part in the TOC
\RequirePackage[explicit,newparttoc,pagestyles]{titlesec}
% Customize TOC
\RequirePackage{titletoc}
% Beutiful kerning (text)
% (Not available in LuaLatex: kerning=true,spacing=true)
\RequirePackage[activate={true,nocompatibility},final,factor=1100,stretch=10,shrink=10]{microtype}
\SetProtrusion{encoding={*},family={*},series={*},size={6,7}}
              {1={ ,750},2={ ,500},3={ ,500},4={ ,500},5={ ,500},
               6={ ,500},7={ ,600},8={ ,500},9={ ,500},0={ ,500}}
% Include images
\RequirePackage{graphicx}
% Float for page layout
\RequirePackage{float}
% Wrap figures/tables in text
\RequirePackage{wrapfig}
% For commands with key values
\RequirePackage{pgfkeys}
% Enables writing utf8 in the document/recipes
%\RequirePackage[utf8]{luainputenc}
% Allows tables to span over multiple pages
\RequirePackage{longtable}
% Extra customization for tables and improvements
\RequirePackage{booktabs}
% Multi column environments
\RequirePackage{multicol}
% Provides subtable
\RequirePackage{subcaption}
% Used to make the longtable split in columns
\RequirePackage{adjustbox}
% Calc
\RequirePackage{calc}

%-------------------------------------------------------------------------------
%                Configuration for colors
%-------------------------------------------------------------------------------
% Awesome-colors
\definecolor{awesome-darkgray}{HTML}{343434}
\definecolor{awesome-gray}{HTML}{5D5D5D}
\definecolor{awesome-text}{HTML}{333333}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}
\definecolor{awesome-purple}{HTML}{a9a4f9}
\definecolor{awesome-cyan}{HTML}{6CE0F1}
\definecolor{awesome-lime}{HTML}{C2E15F}

% Default colors
\colorlet{awesome}{awesome-red}		% Highlights
\colorlet{base}{awesome-darkgray}		% Base color for the graphics
\colorlet{second}{awesome-gray}		% Secondary color
\colorlet{text}{awesome-text}			% Text color


%-------------------------------------------------------------------------------
%                Configuration for user defined settings/preferences
%
% (we use the \newrobustcmd and \newrobustcmd* instead of \newcommand,
% from the etoolbox package to be sure we do not overwrite by accident)
%-------------------------------------------------------------------------------
% Define cookbookname
\newrobustcmd*{\cookbookName}[1][The awesome]{\def\@cookbookname{#1}}
\cookbookName

% Icon size
\newlength{\iconsize}
\newrobustcmd*{\setIconSize}[1][1cm]{\setlength{\iconsize}{#1}}
\setIconSize

% The default recipe header style for all recipes if no one 
% is specified in the \recipe command.
\newrobustcmd*{\setDefaultRecipeStyle}[1][srtyle1]{\edef\@headerstyle{#1}}
\setDefaultRecipeStyle

% The default behaviour for recipes to always start on a left page or not
% (should only be true/false but only the value "true" is actually checked)
\newrobustcmd*{\setDefaultRecipeStartLeft}[1][false]{\edef\@startleft{#1}}
\setDefaultRecipeStartLeft

% Category style
\newrobustcmd*{\setCategoryStyle}[1][style1]{\def\@categorystyle{#1}}
\setCategoryStyle

% Font directory
\newrobustcmd*{\setFontDir}[1][fonts/]{\def\@fontdir{#1}}
\setFontDir

% Font directory
\newrobustcmd*{\setImageDir}[1][./images/]{\graphicspath{{#1}}}
\setImageDir

% Recipes directory
\newrobustcmd*{\setRecipesDir}[1][./recipes/]{\def\@recipesdir{#1}}
\setRecipesDir

% The licence for the cookbook
\newrobustcmd{\setLicense}[1]{\def\@license{#1}}
\setLicense{This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License (the ``License''). You may not use this file except in compliance with the License. To view a copy of this license, visit \url{http://creativecommons.org/licenses/by-sa/4.0/} or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.} % CC-BY 4.0 International

% Header names (for translations)
\newrobustcmd*{\nCookbook}[1][cookbook]{\def\@cookbook{#1}}
\newrobustcmd*{\nPreface}[1][Preface]{\def\@preface{#1}}
\newrobustcmd*{\nPreparation}[1][Preparation]{\def\@preparation{#1}}
\newrobustcmd*{\nIngredients}[1][Ingredients]{\def\@ingredients{#1}}
\newrobustcmd*{\nAlternatives}[1][Alternatives]{\def\@alternatives{#1}}
\newrobustcmd*{\nNotes}[1][Notes]{\def\@notes{#1}}
\newrobustcmd*{\nEnergy}[1][Energy list]{\def\@energy{#1}}
\newrobustcmd*{\nEnergyList}[3]{\def\@energylist{#1}\def\@energyunit{#2}\def\@energyunitt{#3}}
\newrobustcmd*{\nIcons}[5]{\def\@time{#1}\def\@servings{#2}\def\@energytext{#3}\def\@currency{#4}\def\@source{#5}}
\nCookbook \nPreface \nPreparation \nIngredients \nAlternatives \nNotes \nEnergy
\nEnergyList{Nutrient}{kcal}{kj}
\nIcons{min}{servings}{kj}{€}{source}


%-------------------------------------------------------------------------------
%                Configuration internal helper commands
%-------------------------------------------------------------------------------
% Helper command for multi column long tables
\newsavebox\ltmcbox
\newsavebox\xxbox
\newenvironment{multicolslongtable}[1]{
  \setbox\ltmcbox\vbox\bgroup
  \col@number\@ne
  \begin{longtable}{#1}
}{
  \end{longtable}
  \unskip
  \unpenalty
  \unpenalty\egroup
  \unvbox\ltmcbox
}

% Helper command to enlarge and crop images
\newlength{\oH}
\newlength{\oW}
\newlength{\rH}
\newlength{\rW}
\newlength{\cH}
\newlength{\cW}
\newcommand\ClipImage[3]{% width, height, image
\settototalheight{\oH}{\includegraphics{#3}}%
\settowidth{\oW}{\includegraphics{#3}}%
\setlength{\rH}{\oH * \ratio{#1}{\oW}}%
\setlength{\rW}{\oW * \ratio{#2}{\oH}}%
\ifnumcomp{\rH}{<}{#2}{%
    \setlength{\cW}{(\rW-#1)*\ratio{\oH}{#2}}%
    \adjincludegraphics[height=#2,clip,trim=0 0 \cW{} 0]{#3}%
}{%
    \setlength{\cH}{(\rH-#2)*\ratio{\oW}{#1}}%
    \adjincludegraphics[width=#1,clip,trim=0 \cH{} 0 0]{#3}%
}%
}

% The following command is needed, if more ingredients than preparation (steps) are inserted. In this case the \texttt{wrapfigure} package behaves in a strange way. The result is that the hint is also floating around the ingredients, although the "box" is already closed. This command repairs this effect.
% It is taken from http://mizine.de/latex/wrapfigure-austricksen/.
% Note: at the moment not used, depends what behaviour you want. To enable uncomment \wrapfill in the 
% preparations environment.
\newrobustcmd*{\wrapfill}[0]
{% Bug fix for wrapfigure package
    \par
    \ifx\parshape\WF@fudgeparshape
    \nobreak
    \vskip-\baselineskip
    \vskip\c@WF@wrappedlines\baselineskip
    \allowbreak
    \WFclear
    \fi
}


%-------------------------------------------------------------------------------
%                Configuration for fonts
%
% (not every one is used)
%-------------------------------------------------------------------------------
% Set font for header (default is Roboto)
\newfontfamily\headerfont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldItalic,
]{Roboto}

\newfontfamily\headerfontlight[
  Path=\@fontdir,
  UprightFont=*-Thin,
  ItalicFont=*-ThinItalic,
  BoldFont=*-Medium,
  BoldItalicFont=*-MediumItalic,
]{Roboto}

% Set font for footer (default is Source Sans Pro)
\newfontfamily\footerfont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  ItalicFont=*-It,
  BoldFont=*-Bold
]{SourceSansPro}

% Set font for body (default is Source Sans Pro)
\newfontfamily\bodyfont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  ItalicFont=*-It,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldIt
]{SourceSansPro}

\newfontfamily\bodyfontlight[
  Path=\@fontdir,
  UprightFont=*-Light,
  ItalicFont=*-LightIt,
  BoldFont=*-Semibold,
  BoldItalicFont=*-SemiboldIt
]{SourceSansPro}

% Set main font
\setmainfont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  ItalicFont=*-It,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldIt
]{SourceSansPro}


%-------------------------------------------------------------------------------
%                Configuration for pagestyle
%-------------------------------------------------------------------------------
% Configure page margins with geometry
\geometry{left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.5cm, footskip=1cm}

% Header and footer style for recipe sections
\newpagestyle{normal}{
	\sethead[][][] 												% even header
    {}{}{} 														% odd header
    \setfoot[\bfseries\thepage][][\scshape\parttitle] 			% even footer
    {\scshape\parttitle}{}{\bfseries\thepage} 					% odd footer
    \settitlemarks{part}
}

% Header and footer style for the appendices
\newpagestyle{appendix}{
	\sethead[][][] 												% even header
    {}{}{} 														% odd header
    \setfoot[\bfseries\thepage][][\scshape\chaptertitle] 		% even footer
    {\scshape\chaptertitle}{}{\bfseries\thepage} 				% odd footer
    \settitlemarks{chapter}
}


%-------------------------------------------------------------------------------
%                Configuration for hyper
%-------------------------------------------------------------------------------
% hyperref setup
\hypersetup{
	unicode=true,
    colorlinks=true,
    linkcolor=base,
    citecolor=base,
    filecolor=base,
    urlcolor=awesome,
    % PDF info setup
    pdfauthor={\@author},
    pdftitle={\@cookbookname~\@cookbook},
    pdfsubject={\@cookbook},
    pdfproducer={\LaTeXe}
}


%-------------------------------------------------------------------------------
%                Customize the TOC
%-------------------------------------------------------------------------------
% Use to draw horizontal line with specific thickness
\newrobustcmd*{\vhrulefill}[1]{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

% Removes the default margin
\contentsmargin{0cm}

% TOC depth (up until sections)
\setcounter{tocdepth}{1}

% Part (=category) styling
\titlecontents{part}[1.25cm] 							% left (indentation)
{\addvspace{12pt}\large\sffamily\bfseries}				% above-code
{\color{second}\contentslabel[\Large\thecontentslabel]{1.25cm}\color{text}}												% numbered-entry-format
{\color{text}}											% numberless-entry-format
{\color{awesome}\hspace{0.25cm}\vhrulefill{2pt}}		% filler-page-format
														% [] % below-code

% Chapter styling
\titlecontents{chapter}[1.25cm]
{\addvspace{3pt}\sffamily\bfseries}
{\color{second}\contentslabel[\Large\thecontentslabel]{1.25cm}\color{text}}
{\color{text}}  
{\color{text}\hfill\thecontentspage}

% Section (=recipe) styling
\titlecontents{section}
[1.25cm]
{\sffamily}
{}
{}
{\hspace{0.25cm}\titlerule*[0.25pc]{.}~\thecontentspage}


%-------------------------------------------------------------------------------
%               Configure the titles
%
% part 		= category
% chapter 	= text (preface, ect...)
% section	= recipe
%-------------------------------------------------------------------------------
% CATEGORY =====================================================================
% Category (=part)
\newrobustcmd*{\category}[1]{\part{#1}}

% Format for the part title, depending on the opted style
% style1 .......................................................................
\ifdefstring{\@categorystyle}{style1}{%
\titleformat{\part}
  {}							% format
  {}							% label
  {0pt}							% sep
  {%
  \thispagestyle{empty}
  \begin{flushright}
  {\color{base}\fontsize{50}{60}\selectfont \@cookbookname\space \\ \textbf{\@cookbook}}%
  \end{flushright}%
  \begin{tikzpicture}[remember picture,overlay]
	\coordinate [below=15.5cm] (midpoint) at (current page.north);
	\coordinate [left=6.5cm] (partNum) at (midpoint);
	%
	\node[anchor=base,
	fill=base,
	minimum width=\paperwidth,
	minimum height=3cm] at (midpoint) {};
	\node [text=white,font=\fontsize{45}{0}\selectfont, right=-2cm] at (midpoint) {#1};
	\draw[draw=awesome, line width=6pt] (midpoint)++(-\paperwidth/2, -1.5cm) -- ++(\paperwidth, 0);
	\node[text=second,font=\fontsize{280}{0}\selectfont] at (partNum) {\Roman{part}};
 \end{tikzpicture}%
  }							% before-code
  [] 						% after-code
  }{}
% style2 .......................................................................
\ifdefstring{\@categorystyle}{style2}{%
\titleformat{\part}
  {}							% format
  {}							% label
  {0pt}							% sep
  {%
  \thispagestyle{empty}
  \begin{flushright}
  {\color{base}\fontsize{50}{60}\selectfont \@cookbookname\space \\ \textbf{\@cookbook}}%
  \end{flushright}%
  \begin{tikzpicture}[remember picture,overlay]
	\coordinate [below=15.5cm] (midpoint) at (current page.north);
	\coordinate [left=6.5cm] (partNum) at (midpoint);
	%
	\node[anchor=base,
	fill=base,
	minimum width=\paperwidth,
	minimum height=3cm] at (midpoint) {};
	\node [text=white,font=\fontsize{45}{0}\selectfont, right=-2cm] at (midpoint) {#1};
	\draw[draw=awesome, line width=6pt] (midpoint)++(-\paperwidth/2, -1.5cm) -- ++(\paperwidth, 0);
	\node[text=second,font=\fontsize{280}{0}\selectfont] at (partNum) {\arabic{part}};
 \end{tikzpicture}%
  }							% before-code
  [] 						% after-code
  }{}

% RECIPE =======================================================================
% Format for the part title
% (because we have multiple sytles we default to an empty
% title and add a tikz header depending on the chosen
% style)
\titleformat{\section}{}{}{0pt}{}[]

% All options available in the \recipe command
\pgfkeys{
 /recipe/.is family, /recipe,
 % Here are the options that a user can pass
 default/.style = 
  {style = \@headerstyle, startleft = \@startleft},
 style/.estore in = \thestyle,
 startleft/.estore in = \dostartleft,
}

% Different header styles for a recipe
% Available: style1, style2, style3, style4
\newrobustcmd*{\recipe}[2][]{%
\pgfkeys{/recipe, default, #1}%
\expandafter\ifstrequal\expandafter{\dostartleft}{true}{\cleardoublepage}{\clearpage}
\section{#2}%
%
% style1 .......................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{style1}{%
  \noindent\makebox[\textwidth]{%
  \begin{tikzpicture}[remember picture]
	\coordinate [below=1.5cm] (midpoint) at (current page.north);
	%
	\node[anchor=base,
	fill=base,
	minimum width=\paperwidth,
	minimum height=3cm] at (midpoint) {};
	\node [text=white,font=\fontsize{45}{0}\selectfont, align=left, text width=\textwidth] at (midpoint) {#2};
	\draw[draw=awesome, line width=6pt] (midpoint)++(-\paperwidth/2, -1.5cm) -- ++(\paperwidth, 0);
 \end{tikzpicture}%
 }%
 }{}
% style2 .......................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{style2}{%
  \begin{tikzpicture}[remember picture,overlay]
	\coordinate [below=1.5cm] (midpoint) at (current page.north);
	%
	\node[anchor=base,
	fill=base,
	minimum width=\paperwidth,
	minimum height=3cm] at (midpoint) {};
	\node [text=white,font=\fontsize{45}{0}\selectfont, align=left, text width=\textwidth] at (midpoint) {#2};
	\draw[draw=awesome, line width=6pt] (midpoint)++(-\paperwidth/2, -1.5cm) -- ++(\paperwidth, 0);
 \end{tikzpicture}%
 \vspace{0.2cm}
 }{}
% style3 .......................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{style3}{%
 {\fontsize{45}{0}\selectfont #2\color{awesome}.}\\
 \hrule
 }{}
% style4 .......................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{style4}{%
 {\fontsize{45}{0}\selectfont #2}\\[1em]
 \begin{tikzpicture}
	\coordinate [below=6.5cm] (midpoint) at (current page.north);
	%
	\draw[draw=awesome, line width=4pt] (midpoint)++(-\paperwidth/2, 0) -- ++(\textwidth, 0);
 \end{tikzpicture}
 \vspace{0.2cm}
 }{}
}


%-------------------------------------------------------------------------------
%                Commands for the preface
%-------------------------------------------------------------------------------
% Preface
\newenvironment{preface}
{\chapter*{\@preface}}
{\\ 

...and that is the story about our \@cookbookname\space\@cookbook!
}


%-------------------------------------------------------------------------------
%                Commands for the recipe
%-------------------------------------------------------------------------------
% Info =========================================================================
% All options available in the \info command
\pgfkeys{
 /info/.is family, /info,
 % Here are the options that a user can pass
 default/.style = 
 {servings = 0, time = 0, timeunit = min, energy = 0, energyunit = kJ, cost = 0, 
 currency = €, source = none, urlsource = none, servingstext = servings, sourcetext = source},
 servings/.estore in = \theservings,
 servingstext/.estore in = \theservingstext,
 time/.estore in = \thetime,
 timeunit/.estore in = \thetimeunit,
 energy/.estore in = \theenergy,
 energyunit/.estore in = \theenergyunit,
 cost/.estore in = \thecost,
 currency/.estore in = \thecurrency,
 source/.estore in = \thesource,
 urlsource/.estore in = \theurlsource,
 sourcetext/.estore in = \thesourcetext
}

% Information with icons, all are optional
\newrobustcmd*{\info}[1][]{%
\pgfkeys{/info, default, #1}%
\begin{minipage}[t]{\textwidth}%
% Time .........................................................................
\ifdefstring{\thetime}{0}{}{%
\begin{tikzpicture}
\node (icon) at (0,0) {\includegraphics[width=\iconsize]{./resources/icons/time.png}};
\node[align=left, right=\iconsize/2 + 0.15cm] (icon) {\thetime\space \\ \textbf{\thetimeunit}};
\end{tikzpicture}%
}
% Servings .....................................................................
\ifdefstring{\theservings}{0}{}{%
\begin{tikzpicture}
\node (icon) at (0,0) {\includegraphics[width=\iconsize]{./resources/icons/servings.png}};
\node[align=left, right=\iconsize/2 + 0.15cm] (icon) {\theservings\space \\ \textbf{\theservingstext}};
\end{tikzpicture}%
}
% Energy .......................................................................
\ifdefstring{\theenergy}{0}{}{%
\begin{tikzpicture}
\node (icon) at (0,0) {\includegraphics[width=\iconsize]{./resources/icons/energy.png}};
\node[align=left, right=\iconsize/2 + 0.15cm] (icon) {\theenergy\space \\ \textbf{\theenergyunit}};
\end{tikzpicture}%
}
% Cost .......................................................................
\ifdefstring{\thecost}{0}{}{%
\begin{tikzpicture}
\node[align=left] (icon) at (0,0) {\fontsize{\iconsize}{\iconsize+0.1cm}\selectfont \textbf{\thecurrency}};
\node[align=left, right=\iconsize/2 - 0.15cm] (icon) {\thecost};
\end{tikzpicture}%
}
% Source .......................................................................
\ifdefstring{\thesource}{none}{}{%
\hfill
\begin{tikzpicture}
\node (icon) at (0,0) {\includegraphics[width=\iconsize]{./resources/icons/source.png}};
\node[align=left, right=\iconsize/2 + 0.15cm] (icon) {\thesource\space \\ \textbf{\thesourcetext}};
\end{tikzpicture}%
}
% URLSource ....................................................................
\ifdefstring{\theurlsource}{none}{}{%
\hfill
\begin{tikzpicture}
\node (icon) at (0,0) {\includegraphics[width=\iconsize]{./resources/icons/source.png}};
\node[align=left, right=\iconsize/2 + 0.15cm] (icon) {\href{\theurlsource}{link} \\ \textbf{source}};
\end{tikzpicture}%
}
\end{minipage}%
}

% Ingredients ==================================================================
% Because the code would become to messy to include styles i have opted for 
% different environments instead.
%
% The horizontal (1c olumn on the right) variant
\newenvironment*{ingredients}{%
% single ingredient
\newrobustcmd*{\ingredient}[3]{%
\textcolor{second}{##1} & \textcolor{second}{##2} & \textcolor{second}{##3}\\}
%
\wraptable{r}{0.3\textwidth}
\vspace{-1em}% same height of ingredients and preparation title
\textbf{\@ingredients}
\\[0.5em]% same height of ingredients and preparation text
\begin{tabular}{r@{ } l p{0.2\textwidth}}
}{%
\end{tabular}
\vspace{-1em}% correct last \\ in the \ingredient command
\endwraptable
}

% The vertical variant (3 columns, automatic)
\newenvironment*{ingredientsh}{%
% single ingredient
\newrobustcmd*{\ingredient}[3]{%
\textcolor{second}{##1} & \textcolor{second}{##2} & \textcolor{second}{##3}\\}
% 
\textbf{\@ingredients}
\\[0.5em]
\begin{minipage}{\textwidth}
\headerfont
\begin{multicols}{3}
\begin{multicolslongtable}{r@{ }l p{0.20\textwidth}}
}{%
\end{multicolslongtable}%
\end{multicols}%
\end{minipage}
}

% The vertical variant (manual variant)
\newenvironment*{ingredientsc}[0]{%
\textbf{\@ingredients}
\\[0.5em]
\begin{table}[!h]
\centering
\vspace{-2em}% removes unwanted whitespace
}{%
\end{table}%
}

%This should only be used inside ingredientsc but to keep the code readable
% i did not include in \newenvironment*{ingredientsc}.
\newenvironment*{column}[1][]{%
% single ingredient
\newrobustcmd*{\ingredient}[3]{\textcolor{second}{##1} & \textcolor{second}{##2} & \textcolor{second}{##3}\\}
%
\begin{subtable}[t]{.3\textwidth}%
\centering
\begin{flushleft}#1\end{flushleft}
\begin{tabular}{r@{ } l p{0.65\textwidth}}%
}{%
\end{tabular}%
\vspace{-1em}% correct last \\ in the \ingredient command
\end{subtable}%
}


% Preparation ==================================================================
\newenvironment*{preparation}{%
% single preparation step
\newrobustcmd*{\step}[1]{\item ##1}
%
\textbf{\@preparation}
\begin{enumerate}[label=\color{awesome}\Large\bfseries\arabic*.]		
}{%
\end{enumerate}
%\wrapfill
\vspace{3mm}
}

% Refere to a step in the preparation (same label style)
\newrobustcmd*{\refstep}[1]{{\color{awesome}\Large\bfseries #1.}}

% Alternatives ===================================================================
\newenvironment*{alternatives}{%
%
% single alternative
\newrobustcmd*{\alternative}[1]{\item ##1}
%
\textbf{\@alternatives}
\begin{enumerate}[label=\color{second}\Large\bfseries\Roman*.]		
}{%
\end{enumerate}
\vspace{3mm}
}

% Refere to a step in the preparation (same label style)
% (this will convert number to romannumerals)
\newrobustcmd*{\refaltstep}[1]{{\color{second}\Large\bfseries\expandafter\@slowromancap\romannumeral #1@.}}

% Notes ========================================================================
\newenvironment*{notes}{%
% column line style
\newcolumntype{?}{!{\color{base}\vrule width 1.5pt}}
%
% single Note
\newrobustcmd*{\note}[1]{%
\item \vspace{-1mm}\begin{tabular}[t]{?p{\dimexpr \linewidth-2\tabcolsep}}##1\\ \end{tabular}}
%
\textbf{\@notes}
\begin{enumerate}[label=\color{awesome}\Huge\bullet]		
}{%
\end{enumerate}
\vspace{3mm}
}

% Figures ======================================================================
% All options available in the \recipefigure command
\pgfkeys{
 /recipefigure/.is family, /recipefigure,
 % Here are the options that a user can pass
 default/.style = 
 {style = background, height = 0.25, width = 3cm, fig2= "", fig3 = "", fig4 = ""},
 style/.estore in = \thestyle,
 height/.estore in = \theheight,
 width/.estore in = \thewidth,
 fig2/.estore in = \thefig,
 fig3/.estore in = \thefigg,
 fig4/.estore in = \thefiggg,
}

% Shows figures for the recipe
\newrobustcmd*{\recipefigure}[2][]{%
\pgfkeys{/recipefigure, default, #1}%
% background ...................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{background}{%
\begin{tikzpicture}[remember picture, overlay]
\node[opacity=0.5] at (current page.center) {\includegraphics{#2}};
\end{tikzpicture}%
}{}
% fullpage .....................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{fullpage}{%
\newpage
\thispagestyle{empty}
\begin{tikzpicture}[remember picture, overlay]
\node at (current page.center) {\includegraphics{#2}};
\end{tikzpicture}
\clearpage
}{}
% widefigure ...................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{wide}{%
\begin{figure}[h]
\centering
\makebox[\textwidth]{\includegraphics[height=\theheight\textheight]{#2}}
\end{figure}
}{}
% crop .........................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{crop}{%
\begin{figure}[h]
\centering
\makebox[\textwidth]{\ClipImage{\thewidth}{\theheight}{#2}}
\end{figure}
}{}
% fullpage4 .....................................................................
\expandafter\ifstrequal\expandafter{\thestyle}{fullpage4}{%
\newpage
\thispagestyle{empty}
\newgeometry{left=0cm,inner=0cm,margin=0cm,bottom=0cm,top=0cm,bottom=0cm,footskip=0cm}
\begin{figure}[h]
\begin{subfigure}[!ht]{\pagewidth}
\ClipImage{\pagewidth}{0.35\pageheight}{#2}
\end{subfigure}

\begin{subfigure}[l]{0.5\textwidth}
\centering
\ClipImage{0.49\pagewidth}{0.45\pageheight}{\thefig}
\end{subfigure}
\begin{subfigure}[r]{0.5\textwidth}
\centering
\ClipImage{0.49\pagewidth}{0.45\pageheight}{\thefigg}
\end{subfigure}

\vspace{-0.2165\pageheight}
\begin{subfigure}[!hb]{\pagewidth}
\ClipImage{\pagewidth}{0.35\pageheight}{\thefiggg}
\end{subfigure}
\end{figure}
\clearpage
\restoregeometry
}{}
}


%-------------------------------------------------------------------------------
%                Commands for the appendices
%-------------------------------------------------------------------------------
% Energy list
\newenvironment{energylist}{%
% single ingredient
\newrobustcmd*{\nutrient}[3]{\textcolor{second}{##1} & \textcolor{second}{##2} & \textcolor{second}{##3}\tabularnewline}
% 
\chapter{\@energy}
\hspace{3mm}\begin{tabular}{ p{0.3\textwidth} r r}\textbf{\@energylist} & \textbf{\@energyunit} & \textbf{\@energyunitt}\\\end{tabular}\hspace{1.35cm}\begin{tabular}{ p{0.3\textwidth} r r}\textbf{\@energylist} & \textbf{\@energyunit} & \textbf{\@energyunitt}\\\end{tabular}\\
\begin{minipage}{\textwidth}
\begin{multicols}{2}
\begin{multicolslongtable}{p{0.3\textwidth} r r}
}{%
\end{multicolslongtable}%
\end{multicols}%
\end{minipage}
}


%-------------------------------------------------------------------------------
%                Generate the first pages
% 				 (cover, titlepage, info page and [preface])
%-------------------------------------------------------------------------------
% The cover for the book
\newrobustcmd*{\makeCover}{%
\begin{titlepage}
% Header
\begin{tikzpicture}[remember picture,overlay]
\coordinate [below=2.5cm] (midpoint) at (current page.north);
\node [anchor=base,
fill=base,
text=white,
minimum width=\paperwidth,
minimum height=1cm] at (midpoint) {\Large{\@cookbookname\space \textbf{\@cookbook}}};
\end{tikzpicture}%
%
% Text and rectangle
\begin{tikzpicture}[remember picture,overlay]
\def\rectHeight{\paperheight/2.75}
\def\rectWidth{\paperwidth/1.75}
% Rectangle
\draw[draw=base, text=white,line width=6pt] 
(current page.center)++(-\rectWidth/2,-\rectHeight/2) rectangle ++(\rectWidth,\rectHeight);
% Line
\draw[draw=awesome, line width=6pt] 
(current page.center)++(-\rectWidth/2,-\rectHeight/2)++(0.5cm,0.5cm) -- ++(\rectWidth-1cm, 0);
% Text
\node[text=base, align=center, font=\fontsize{90}{114}\selectfont] at (current page.center) { \textbf{Family} \\ {\color{second}Recipes}};
\end{tikzpicture}%
%
% Footer
\begin{tikzpicture}[remember picture,overlay]
\coordinate [above=2.5cm] (midpoint) at (current page.south);
\node [anchor=base,
fill=base,
minimum width=\paperwidth,
minimum height=1cm] at (midpoint) {};
\end{tikzpicture}%
\end{titlepage}
\newpage\null\thispagestyle{empty}\newpage%	New empty page (no footer)
}

% WRAPPER COMMANDS =============================================================
% The title page and book info page
\newrobustcmd*{\maketitlepages}[0]{%
\vspace*{7cm}
\begin{flushright}
{\color{base}\fontsize{50}{60}\selectfont \@cookbookname\space \\ \textbf{\@cookbook}}
\end{flushright}
\newpage
~\vfill
\noindent Copyright \copyright\ \the\year\space \@author\\

\noindent Made with the \href{https://github.com/Nooby4Ever/awesome-cookbook}{awesome-cookbook} \LaTeXe template.\\
\noindent Icons designed by Freepik and distributed by Flaticon.\\ % required to mention this due to their licence

\noindent \@license\space\\

\noindent \textit{Last updated on \today}
\clearpage
}

% Generate the begin pages of the cookbook (cover, title, TOC)
\newrobustcmd*{\beginCookbook}[0]{%
\pagestyle{empty}
\makeCover

\maketitlepages

\frontmatter % turns off chapter numbering and uses roman numerals for page numbers
\tableofcontents
}

% Marks the start of the recipes (sets page style)
\newrobustcmd*{\beginRecipes}[0]{%
\mainmatter % turns on chapter numbering, resets page numbering and uses arabic numerals for page numbers
\pagestyle{normal}
}

% Marks the start of the appendices (sets page style)
\newrobustcmd*{\beginAppendices}[0]{%
\appendix % resets chapter numbering, uses letters for chapter numbers and doesn't fiddle with page numbering
\pagestyle{appendix}
}


%-------------------------------------------------------------------------------
%                Commands for auto generate
%-------------------------------------------------------------------------------
% Runs the autogenerate Lua script which well setup the stucture and include all
% (sorted) recipes. See the Readme.md for more information.
\directlua{require("autogenerate.lua")}
\newrobustcmd*{\autoGenerate}[0]{\directlua{generateTex("\@recipesdir")}}