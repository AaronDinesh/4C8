DOCNAME=main

all: report

.PHONY: clean

report:
	pdflatex -jobname=Lab03_20332661_AaronDinesh $(DOCNAME).tex -interation=nonstopmode
	# bibtex $(DOCNAME).aux
	pdflatex -jobname=Lab03_20332661_AaronDinesh $(DOCNAME).tex
	# pdflatex $(DOCNAME).tex

view:
	open $(DOCNAME).pdf

clean:
	rm *.blg *.bbl *.aux *.log

cleanpdf:
	rm *.pdf
