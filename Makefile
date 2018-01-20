PROJ=docs
TEX=pdflatex
TEXFLAGS=-halt-on-error -interaction=nonstopmode -shell-escape

all: $(PROJ).pdf
.PHONY: all

$(PROJ).pdf: src/*.tex
	# First run generates TOC.
	TEXINPUTS=src:${TEXINPUTS} $(TEX) $(TEXFLAGS) $(PROJ).tex
	# Second run uses it.
	TEXINPUTS=src:${TEXINPUTS} $(TEX) $(TEXFLAGS) $(PROJ).tex

clean:
	rm -f $(PROJ).pdf *.log *.aux *.toc
.PHONY: clean

