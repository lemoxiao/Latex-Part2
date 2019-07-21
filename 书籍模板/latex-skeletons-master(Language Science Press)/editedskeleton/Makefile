# specify your main target here:
all: book pod cover

# specify thh main file and all the files that you are including
SOURCE= $(wildcard *.tex) $(wildcard chapters/*.tex)\
localbibliography.bib\
LSP/langsci.cls
	 
main.pdf: main.tex $(SOURCE)
	xelatex -no-pdf main 
	./bibtexvolume
	xelatex  -no-pdf main
	sed -i s/.*\\emph.*// main.adx #remove titles which biblatex puts into the name index
	makeindex -o main.and main.adx
	makeindex -o main.lnd main.ldx
	makeindex -o main.snd main.sdx
	xelatex -no-pdf main 
	xelatex main 

#create only the book
book: main.pdf 

#create a png of the cover
cover: main.pdf
	convert main.pdf\[0\] -quality 100 -background white -alpha remove -bordercolor black -border 2  cover.png
	display cover.png
 
#prepare for print on demand services	
pod: bod createspace
 

#prepare for submission to BOD
bod: main.pdf  
	sed "s/output=short/output=coverbod/" main.tex >bodcover.tex 
	xelatex bodcover.tex 
	xelatex bodcover.tex
	mv bodcover.pdf bod
	./filluppages 4 main.pdf bod/bodcontent.pdf 

# prepare for submission to createspace
createspace:  main.pdf
	sed "s/output=short/output=covercreatespace/" main.tex >createspacecover.tex 
	xelatex createspacecover.tex
	xelatex createspacecover.tex
	mv createspacecover.pdf createspace
	./filluppages 1 main.pdf createspace/createspacecontent.pdf 

#housekeeping	
clean:
	rm -f *.bak *~ *.backup *.tmp \
	*.adx *.and *.idx *.ind *.ldx *.lnd *.sdx *.snd *.rdx *.rnd *.wdx *.wnd \
	*.log *.blg *.ilg \
	*.aux *.toc *.cut *.out *.tpm *.bbl *-blx.bib *_tmp.bib \
	*.glg *.glo *.gls *.wrd *.wdv *.xdv \
	*.run.xml

realclean: clean
	rm -f *.dvi *.ps *.pdf 
