.PHONY=clean

# := variables are simply expanded, which means only once
# http://ftp.gnu.org/old-gnu/Manuals/make-3.79.1/html_chapter/make_6.html 
TMP_DIR:="$(shell mktemp -d)"
STYLE_SOURCES:=letterAlinz.sty letterStyleAlinz.lco
TEX_ROOT:="$(shell kpsewhich -var-value=TEXMFHOME)"
TEX_DIR:=$(TEX_ROOT)/tex/latex/kn-letter

all: $(addsuffix .pdf, $(basename $(wildcard *.tex)))

%.pdf: %.tex
	xelatex -output-directory=$(TMP_DIR) $(basename $@).tex
	xelatex -output-directory=$(TMP_DIR) $(basename $@).tex
	mv "$(TMP_DIR)/$@" .
	rm -r $(TMP_DIR)

install:
	mkdir -p $(TEX_DIR)
	cp $(STYLE_SOURCES) $(TEX_DIR)
	texhash $(TEX_ROOT)

clean:
	rm -f $(addsuffix .pdf, $(basename $(wildcard *.tex)))
	rm -f $(addsuffix .png, $(basename $(wildcard *.tex)))

preview: message.pdf
	montage -mode Concatenate -tile 1x -density 90 $< $(basename $@).png

%.png: %.pdf
	convert -density 300 $(basename $@).pdf $@
