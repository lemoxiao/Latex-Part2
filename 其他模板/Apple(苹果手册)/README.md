Overview
====================================
This LaTeX template will let you create beautiful PDF documents inspired by Apple documentations. 
- [ ] Title page
- [x] Table of contents
- [x] Chapter, section, and subsection headings
- [x] Objective-C code listing with syntax highlighting
- [x] Swift code listing with syntax highlighting

How To Get Started
====================================

1. Install [MacTex](https://www.github.com)
  1. Check if there are any updates for TeXShop and TeX Live Utility applications
  2. Launch TeX Live Utility and update all packages
2. Integrate the template with TeXShop
  1. Navigate to ~/Library/TeXShop/Engines
  2. Open XeLaTeX.engine file
  3. Add two additional parameters -shell-escape -interaction=nonstopmode
3. Install [Pygments](http://pygments.org)
  1. sudo easy_install Pygments

In case of commandline compilation, use xelatex
```
xelatex  -file-line-error -synctex=1 -shell-escape -interaction=nonstopmode "File.tex"
```

Screenshots
====================================

![Table Of Contents](https://raw.github.com/wnagrodzki/AppleDocumentationStyleLatexTemplate/master/Screen%20Shots/TOC.png)
 
![Sections, subsections](https://raw.github.com/wnagrodzki/AppleDocumentationStyleLatexTemplate/master/Screen%20Shots/Sections.png)
 
![Objective-C listing](https://raw.github.com/wnagrodzki/AppleDocumentationStyleLatexTemplate/master/Screen%20Shots/CodelistingObjC.png)

![Swift listing](https://raw.githubusercontent.com/wnagrodzki/AppleDocumentationStyleLatexTemplate/master/Screen%20Shots/CodelistingSwift.png)
