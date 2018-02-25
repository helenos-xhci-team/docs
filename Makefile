PROJ=docs
TEX=pdflatex
TEXFLAGS=-halt-on-error -interaction=nonstopmode -shell-escape

ASPELL=aspell
ASPELL_FLAGS=--lang=en --mode=tex --personal=${PWD}/xhci.dict

SVGS=$(patsubst %.svg,%.pdf,$(wildcard img/*.svg))
PDFS=$(wildcard img/*.pdf) # We include also built svgs here, but who cares
IMAGES=$(SVGS) $(PDFS)

all: $(PROJ).pdf
.PHONY: all

$(SVGS): %.pdf: %.svg
	convert $< $@

$(PROJ).aux: src/*.tex ${IMAGES}
	# First run generates TOC.
	TEXINPUTS=src:${TEXINPUTS} $(TEX) $(TEXFLAGS) -draft $(PROJ).tex

$(PROJ).bbl: src/*.bib $(PROJ).aux
	# Update bibliography
	biber $(PROJ)

$(PROJ).pdf: $(PROJ).aux $(PROJ).bbl
	mv $< $<.tmp
	# Second run uses it.
	TEXINPUTS=src:${TEXINPUTS} $(TEX) $(TEXFLAGS) $(PROJ).tex
	# If the aux file hasn't changed, mask modification time to break cycle
	cmp -s $< $<.tmp && mv $<.tmp $<
	rm -f $<.tmp

spellcheck:
	find src/ -name "*.tex" -exec ${ASPELL} ${ASPELL_FLAGS} check "{}" \;

clean:
	rm -f $(PROJ).pdf *.lo[lgf] *.aux *.toc
	rm -f ${SVGS}
	rm -rf _minted-docs
.PHONY: clean

