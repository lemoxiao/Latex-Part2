PDFLATEX_FLAGS  = -halt-on-error

all: main.pdf

main.pdf: *.tex *.bib
	latexmk -xelatex -latexoption="$(PDFLATEX_FLAGS)" -use-make main.tex && latexmk -c

.PHONY: display clean
display: main.pdf
	evince main.pdf
clean:
	latexmk -CA

