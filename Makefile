PROJ=docs
TEX=pdflatex
TEXFLAGS=-halt-on-error -interaction=nonstopmode -shell-escape

SVGS=$(patsubst %.svg,%.pdf,$(wildcard img/*.svg))
IMAGES=${SVGS}

all: $(PROJ).pdf
.PHONY: all

%.pdf: %.svg
	convert $< $@

$(PROJ).pdf: src/*.tex ${IMAGES}
	# First run generates TOC.
	TEXINPUTS=src:${TEXINPUTS} $(TEX) $(TEXFLAGS) $(PROJ).tex
	# Second run uses it.
	TEXINPUTS=src:${TEXINPUTS} $(TEX) $(TEXFLAGS) $(PROJ).tex

clean:
	rm -f $(PROJ).pdf *.log *.aux *.toc img/*.pdf
.PHONY: clean

