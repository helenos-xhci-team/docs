PROJ=docs
TEX=pdflatex
TEXFLAGS=-halt-on-error -interaction=nonstopmode

all: $(PROJ).pdf
.PHONY: all

%.pdf: src/%.tex
	TEXINPUTS=src:$(TEXINPUTS) $(TEX) $(TEXFLAGS) $^

src/docs.tex: src/01_intro.tex

clean:
	rm -f $(PROJ).pdf *.log *.aux
.PHONY: clean

