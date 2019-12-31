.PHONY: all
all: cv_en.pdf

cv_en.pdf: build/cv_en.pdf
	cp build/cv_en.pdf .

.PHONY: build/cv_en.pdf
build/cv_en.pdf:
	@latexmk # Let the tool do its job
