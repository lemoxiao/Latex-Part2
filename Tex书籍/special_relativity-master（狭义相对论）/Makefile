RUN_ERUBY = perl -Iscripts scripts/run_eruby.pl

TEX_INTERPRETER = pdflatex
#TEX_INTERPRETER = lualatex
DO_PDFLATEX_RAW = $(TEX_INTERPRETER) -shell-escape -interaction=nonstopmode sr >err
# -shell-escape is so that write18 will be allowed
SHOW_ERRORS = \
        print "========error========\n"; \
        open(F,"err"); \
        while ($$line = <F>) { \
          if ($$line=~m/^\! / || $$line=~m/^l.\d+ /) { \
            print $$line \
          } \
        } \
        close F; \
        exit(1)
DO_PDFLATEX = echo "$(DO_PDFLATEX_RAW)" ; perl -e 'if (system("$(DO_PDFLATEX_RAW)")) {$(SHOW_ERRORS)}'
HANDHELD_TEMP = handheld_temp
BOOK = sr
GENERIC_OPTIONS_FOR_CALIBRE =  --authors "Benjamin Crowell" --language en --title "Special Relativity" --toc-filter="[0-9]\.[0-9]" --title="Special Relativity"
PROBLEMS_CSV = problems.csv

default:
	@make preflight
	@scripts/before_each.rb
	BK=$(BOOK) $(RUN_ERUBY)
	$(DO_PDFLATEX)
	@scripts/translate_to_html.rb --util="learn_commands:$(BOOK).cmd"
	@process_geom_file.pl <geom.pos >temp.pos
	@mv temp.pos geom.pos
	makeindex sr.idx >/dev/null

book:
	@make preflight
	make clean
	make && make
	@scripts/translate_to_html.rb --util="learn_commands:$(BOOK).cmd"
	@scripts/check_for_colliding_figures.rb
	@scripts/harvest_aux_files.rb
	make

web:
	@make preflight
	scripts/translate_to_html.rb --write_config_and_exit
	WOPT='$(WOPT) --html5' $(RUN_ERUBY)  w     #... html 5 with mathml
	WOPT='$(WOPT) --mathjax' $(RUN_ERUBY) w    #... html 4 with mathjax
	# To set options, do, e.g., "WOPT='--no_write' make web". Options are documented in translate_to_html.rb.


clean:
	# Cleaning...
	@rm -f sr.pdf sr_lulu.pdf
	@rm -f temp.tex
	@rm -f ch*/ch*temp.tex 
	@rm -f bk*lulu.pdf simple1.pdf simple2.pdf # lulu files
	@rm -f ch*.pos geom.pos report.pos marg.pos makefilepreamble
	@rm -f figfeedback*
	@rm -f ch*/ch*temp_new ch*/*.postm4 ch*/*.wiki
	@rm -f code_listing_* code_listings/* code_listings.zip
	@rm -Rf code_listings
	@rm -f temp.* temp_mathml.*
	@# Sometimes we get into a state where LaTeX is unhappy, and erasing these cures it:
	@rm -f *aux *idx *ilg *ind *log *toc
	@rm -f ch*/*aux
	@# Shouldn't exist in subdirectories:
	@rm -f */*.log
	@# Emacs backup files:
	@rm -f *~
	@rm -f */*~
	@rm -f */*/*~
	@rm -f */ch*.temp
	@# Misc:
	@rm -Rf ch*/figs/.xvpics
	@rm -f a.a
	@rm -f */a.a
	@rm -f */*/a.a
	@rm -f junk
	@rm -f err
	@rm -f temp_mathml.html temp_mathml.tex temp.html
	@# ... done.

very_clean:
	make clean
	rm -f brief-toc.tex brief-toc-new.tex

preflight:
	@@chmod +x scripts/custom/*
	@perl -e 'if (-e "scripts/custom/enable") {foreach $$f(<scripts/custom/*.pl>) {$$c="$$f $(BOOK) $(PROBLEMS_CSV)"; system($$c)}}'
	@perl -e 'foreach $$f("scripts/run_eruby.pl","scripts/equation_to_image.pl","scripts/latex_table_to_html.pl","scripts/harvest_aux_files.rb","scripts/check_for_colliding_figures.rb","scripts/translate_to_html.rb","mv_silent") {die "file $$f is not executable; fix this with chmod +x $$f" unless -e $$f && -x $$f}'

post:
	cp sr.pdf ~/Lightandmatter/sr

prepress:
	PREPRESS=1 make book
	make preflight_figs
	scripts/pdf_extract_pages.rb sr.pdf 3-end sr_lulu.pdf
	# Filtering through gs used to be necessary to convince Lulu not to complain about missing fonts.
	# Now that should no longer be necessary, because recent versions of pdftex embed all fonts, and fullembed.map prevents subsetting.
	# See meki:computer:apps:ghostscript, scripts/create_fullembed_file, and http://tex.stackexchange.com/questions/24002/turning-off-font-subsetting-in-pdftex
	@rm -f temp.pdf

preflight_figs:
	@echo "checking all figures in all books for transparency, embedded fonts, bad structure..."
	scripts/preflight_figs.pl
	@echo "...done"

all_figures:
	# The following requires Inkscape 0.47 or later.
	perl -e 'foreach my $$f(<ch*/figs/*.svg>) {system("scripts/render_one_figure.pl $$f")}'
	scripts/svg_to_bitmap.pl cover/cover-for-pdf.svg cover/cover-for-pdf.png

handheld:
	# see meki/zzz_misc/publishing for notes on how far I've progressed with this
	scripts/translate_to_html.rb --write_config_and_exit --modern --override_config_with="config/handheld.config"
	make preflight
	@rm -Rf $(HANDHELD_TEMP)
	mkdir $(HANDHELD_TEMP)
	pwd
	WOPT='$(WOPT) --modern --override_config_with="config/handheld.config"' $(RUN_ERUBY) w $(FIRST_CHAPTER) $(DIRECTORIES) #... xhtml
	cp standalone.css $(HANDHELD_TEMP)
	make epub
	make mobi
	@echo "To post the books, do 'make post_handheld'."

post_handheld:
	cp $(BOOK).epub $(HOME)/Lightandmatter
	cp $(BOOK).mobi $(HOME)/Lightandmatter

epub:
	# Before doing this, do a "make handheld".
	ebook-convert $(HANDHELD_TEMP)/index.html $(BOOK).epub $(GENERIC_OPTIONS_FOR_CALIBRE) --no-default-epub-cover

mobi:
	# Before doing this, do a "make handheld".
	ebook-convert $(HANDHELD_TEMP)/index.html $(BOOK).mobi $(GENERIC_OPTIONS_FOR_CALIBRE) --rescale-images

epubcheck:
	java -jar /usr/bin/epubcheck/epubcheck.jar $(BOOK).epub 2>err

problems:
	# For some reason, this always fails the first time -- do it twice!?
	cat ch*_problems.csv | sort >temp.csv
	scripts/sort_problems.pl <temp.csv >problems.csv
	rm temp.csv
	ssed -R -e "s/(\w*),(\d+),([a-z0-9]+),(.*),\d/m4_define(__hw_\1_\2_\4,\3)m4_dnl/g;s/\-/_/g" problems.csv >problems.m4
