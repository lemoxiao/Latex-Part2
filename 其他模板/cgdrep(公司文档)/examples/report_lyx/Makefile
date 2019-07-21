all: main_cn.pdf main_en.pdf

%.pdf: %.lyx
	lyx -batch -E pdf4 $@ $<

.PHONY: clean
clean:
	rm -rf main_cn.pdf main_en.pdf
