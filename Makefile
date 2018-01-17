PROJ=docs
TEX=pdflatex
TEXFLAGS=-halt-on-error -interaction=nonstopmode

all: $(PROJ).pdf
.PHONY: all

%.pdf: src/%.tex
	TEXINPUTS=src:$(TEXINPUTS) $(TEX) $(TEXFLAGS) $^

clean:
	rm -f $(PROJ).pdf *.log *.aux
.PHONY: clean

