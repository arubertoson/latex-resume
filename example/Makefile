
CC = latexmk

CACHE_DIR = compile
OUTPUT_DIR = output

OUTPUT_NAME = example_$@_`date +%m-%Y`

### Compilation Flags
PDFLATEXFLAGS = -interaction=batchmode -halt-on-error -shell-escape -xelatex
LATEXCACHE = -output-directory=$(OUTPUT_DIR) -aux-directory=$(CACHE_DIR)

.PHONY: resume letter clean

default: resume letter clean

resume: resume.tex
	$(CC) $(PDFLATEXFLAGS) $(LATEXCACHE) -jobname=$(OUTPUT_NAME) $<

letter: cover_letter/cover_letter.tex
	$(CC) $(PDFLATEXFLAGS) $(LATEXCACHE) -jobname=$(OUTPUT_NAME) $<

clean:
	latexmk -C
	@rm -rf compile
	@rm -rf *.log
