CMD_SEP = "========================================"
CMD_DONE = "Done."
CLEAN_CMD = rm -f *.aux       ; \
            rm -f *.bbl       ; \
            rm -f *.blg       ; \
            rm -f *-blx.bib   ; \
            rm -f *.log       ; \
            rm -f *.out       ; \
            rm -f *.run.xml   ; \
            rm -f *.toc       ; \
            rm -f *.lof       ; \
            rm -f *.lot       ; \
            rm -f *.lol       ; \
            rm -f comment.cut ; \

all: full

quick:
	@echo "QUICK BUILD"
	@echo
	@echo $(CMD_SEP)
	@echo "Building bibliography..."
	bibtex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo
	@echo $(CMD_SEP)
	@echo "Building report..."
	pdflatex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo

full:
	@echo "FULL BUILD"
	@echo
	@echo $(CMD_SEP)
	@echo "Building report (1st time)..."
	pdflatex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo
	@echo $(CMD_SEP)
	@echo "Building bibliography..."
	bibtex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo
	@echo $(CMD_SEP)
	@echo "Rebuilding report (2nd time)..."
	pdflatex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo
	@echo $(CMD_SEP)
	@echo "Rebuilding report (3rd time)..."
	pdflatex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo
	@echo $(CMD_SEP)
	@echo "Rebuilding report (4th time)..."
	pdflatex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo
	@echo $(CMD_SEP)
	@echo "Rebuilding report (last time)..."
	pdflatex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo

clean:
	@echo $(CMD_SEP)
	@echo "Cleaning '.' folder..."
	@-$(CLEAN_CMD)
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)

new: clean
	@echo "NEW BUILD"
	@echo
	@echo $(CMD_SEP)
	@echo "Building report..."
	pdflatex report
	@echo $(CMD_DONE)
	@echo $(CMD_SEP)
	@echo