# LatexAssessmentTemplates-SSHL

LaTeX Assessment Templates for generating quizzes, tests and exams for Mathematics courses taught at SSHL within the IB Diploma, GY2011 and MYP programmes.  This template is available on [overleaf](https://www.overleaf.com/latex/templates/assessment-templates-for-sshl/zrxzjxbzbxdc#.WPbh-FOGOjk)

![Assessment Screenshot](https://github.com/markolsonse/LatexAssessmentTemplates-SSHL/raw/master/LatexAssessment.png)

## Background

This is a collection of 5 different templates that I use in my teaching across 3 different programs that are based on the amazing latex class, exam.cls.

- 0-GY11-QuizTemplate.tex
- 0-Gy11-TestTemplate.tex
- 0-IB-TestTemplate.tex
- 0-MYP-QuizTemplate.tex
- 0-MYP-TestTemplate.tex

### markolsonassessment.sty

The `*.tex` templates themselves are content templates.  It is the exam class that is providing much of the functionality and structure of the document.  However, I have made some changes to the layout provided by the `exam.cls`, which are managed by by the `markolsonassessment.sty` that provides a pragmatic way of keeping global structrual changes current across all assessment documents - especially if one wants to retro-fix something.  I am not trying to be narcissistic by prepending my name to the style file, but I am trying to be explicity that it is a file that I do not intend to become a common package.  However, you are more than welcome to use/adopt/develop/rename this file at your leisure to develop your own assessments.

### markolsoncolorsthlm.sty

Rather than define colors for each document, I have created a color style file that I can use across all projects - with the exception of Beamer.  Since colors are used within the  `markolsonassessment.sty` to format the different templates, I would suggest editing this file to make color changes.  Otherwise, you disregard this package and modify the colors within  `markolsonassessment.sty` itself.  Once again, my name is prepended here for a reason.

### markolsonmath.sty

I have started using a lot of my own custom Math commands to clean up my code and these are kept in this style file.  This was a nightmare to manage when I included custom commands in each document.  And when a change was made that needed to be retro-modified - not an pleasant experience.  So all my Math commands can be modified globally through this file.

### markolsontikz.sty

I really wish I was more fluent in using TikZ as it produces such beautiful diagrams.  There are some common elements taht I use frequently - such as diagram layouts, which I keep here.  So if I want to include any TikZ in my work, I just include this package.  *It should be noted that this file loads all of tikz-euclid by default*, which can cause some compilation warnings (at least when tested on overleaf).

## Notes to Self

- The package `sagetex.sty` is loaded automatically by `markolsonassessment.sty`.  I use sagetex to include SageMath in almost all my assessments, so it is included here.  If you do not have SageMath installed and the necessary package file, then you shoud remove the inlcude package call from `markolsonassessment.sty`.  
- For the templates available on Overleaf, I have removed the `sagetex.sty` and all tikz-euclide from the style files.  This is a self-reminder to manually make these changes to the Overleaf template after updating.
- I will fix both of the above in a future update.

