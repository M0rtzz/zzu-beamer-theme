LUALATEX = lualatex --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error
BIBTEX = bibtex
RM = rm -rf

MAIN = slide.tex
PREAMBLE = preamble.tex
SRC_FILES = $(shell find src -name '*.tex' -print | sed 's/ /\\ /g')
STY = ZZU.sty emoji-ext.sty
PDF = slide.pdf

BIB_FILE = refs.bib
BIB_EXISTS = $(wildcard $(BIB_FILE))
BIB_NOT_EMPTY = $(shell [ -s $(BIB_FILE) ] && echo true || echo false)

all: $(PDF)

$(PDF): $(MAIN) $(PREAMBLE) $(SRC_FILES) $(STY)
	$(if $(wildcard $@), $(RM) $@,)
	$(LUALATEX) $(MAIN)
ifneq ($(BIB_EXISTS),)
ifeq ($(BIB_NOT_EMPTY),true)
	$(BIBTEX) $(basename $(MAIN)).aux
	$(LUALATEX) $(MAIN)
	$(LUALATEX) $(MAIN)
endif
endif

clean:
	$(RM) *.aux *.bbl *.blg *.log _minted/ *.nav *.out *.snm svg-inkscape/ *.synctex.gz '*.synctex(busy)' *.toc *.vrb

distclean: clean
	$(RM) $(PDF)

rebuild: distclean all

.PHONY: all clean rebuild distclean
