PROJ=docs
TEX=pdflatex
TEXFLAGS=-halt-on-error -interaction=nonstopmode

all: $(PROJ).pdf
.PHONY: all

%.pdf: src/%.tex
	$(TEX) $(TEXFLAGS) $^

clean:
	rm -f $(PROJ).pdf $(PROJ).log $(PROJ).aux
.PHONY: clean

