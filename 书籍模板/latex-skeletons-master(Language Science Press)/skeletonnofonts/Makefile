# specify your main target here:
all: book 

# specify thh main file and all the files that you are including
SOURCE= $(wildcard *.tex) $(wildcard chapters/*.tex)\
localbibliography.bib\
LSP/langsci.cls
	 
main.pdf: $(SOURCE)
	xelatex -no-pdf main 
	bibtex -min-crossrefs=200 main
	xelatex  -no-pdf main
	sed -i s/.*\\emph.*// main.adx #remove titles which biblatex puts into the name index
	makeindex -o main.and main.adx
	makeindex -o main.lnd main.ldx
	makeindex -o main.snd main.sdx
	xelatex -no-pdf main 
	xelatex main 

#create only the book
book: main.pdf 


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

FORCE:
