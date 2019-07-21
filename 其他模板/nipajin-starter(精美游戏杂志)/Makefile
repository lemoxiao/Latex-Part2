VERSION="v1.1"
PDF_NAME="NIPAJIN-Autorenpaket"
TEX_NAME="nipajin"

default: ebook
	
all: ebook

setup: 
	mkdir -p out

ebook: setup
	xelatex -output-driver="xdvipdfmx -V 5 -z 9" -output-directory out ${TEX_NAME}
	pdfopt out/${TEX_NAME}.pdf out/${PDF_NAME}-${VERSION}.pdf

clean:
	rm -rf out/*

