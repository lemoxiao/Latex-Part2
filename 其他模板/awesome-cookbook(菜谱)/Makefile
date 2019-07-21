.PHONY: examples

examples: $(foreach x,cookbook MWE_auto MWE_manual,examples/$x.pdf)

%.pdf: %.tex
	lualatex	-synctex=1	-interaction=nonstopmode	--shell-escape	-output-directory=$(dir $@) $<
