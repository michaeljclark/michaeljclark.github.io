all: images

IMAGES = \
	images/rv8.svg \
	images/bintrans.svg \
	images/inlining.svg

images: $(IMAGES)

images/%.svg: tmp/%.pdf
	pdf2svg $< $@

tmp/%.pdf: tex/%.tex
	@mkdir -p $(@D)
	cd tmp && pdflatex ../$<
