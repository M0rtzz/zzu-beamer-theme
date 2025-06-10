XELATEX = xelatex --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error
BIBTEX = bibtex
RM = rm -rf

MAIN = slide.tex
PREAMBLE = preamble.tex
SRC_FILES = $(wildcard src/*.tex)
STY = ZZU.sty xelatexemoji.sty xelatexemoji-flags.sty
PDF = slide.pdf

BIB_EXISTS = $(wildcard *.bib)

all: $(PDF)

$(PDF): $(MAIN) $(PREAMBLE) $(SRC_FILES) $(STY)
	$(RM) $@
	$(XELATEX) $(MAIN)
ifneq ($(BIB_EXISTS),)
	$(BIBTEX) $(basename $(MAIN)).aux
	$(XELATEX) $(MAIN)
	$(XELATEX) $(MAIN)
endif

clean:
	$(RM) *.aux *.bbl *.blg *.log *.nav *.snm *.synctex.gz '*.synctex(busy)' *.toc *.vrb

distclean: clean
	$(RM) $(PDF)

rebuild: distclean all

.PHONY: all clean rebuild distclean
