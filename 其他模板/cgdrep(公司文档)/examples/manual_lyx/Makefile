all: install.pdf

install.pdf: install.lyx
	lyx -batch -E pdf4 $@ $<

.PHONY: display clean
display: install.pdf
	evince install.pdf
clean:
	rm -rf *.pdf
