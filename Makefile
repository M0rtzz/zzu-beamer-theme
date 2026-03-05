XELATEX = xelatex --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error
BIBTEX = bibtex
RM = rm -rf

MAIN = slide.tex
PREAMBLE = preamble.tex
SRC_FILES = $(shell find src -name '*.tex' -print | sed 's/ /\\ /g')
STY = ZZU.sty xelatexemoji.sty xelatexemoji-flags.sty
PDF = slide.pdf

BIB_FILE = refs.bib
BIB_EXISTS = $(wildcard $(BIB_FILE))
BIB_NOT_EMPTY = $(shell [ -s $(REFS_BIB) ] && echo true || echo false)

all: $(PDF)

$(PDF): $(MAIN) $(PREAMBLE) $(SRC_FILES) $(STY)
	$(if $(wildcard $@), $(RM) $@,)
	$(XELATEX) $(MAIN)
ifneq ($(BIB_EXISTS),)
ifeq ($(BIB_NOT_EMPTY),true)
	$(BIBTEX) $(basename $(MAIN)).aux
	$(XELATEX) $(MAIN)
	$(XELATEX) $(MAIN)
endif
endif

clean:
	$(RM) *.aux *.bbl *.blg *.log *.nav *.snm svg-inkscape/ *.synctex.gz '*.synctex(busy)' *.toc *.vrb

distclean: clean
	$(RM) $(PDF)

rebuild: distclean all

.PHONY: all clean rebuild distclean
