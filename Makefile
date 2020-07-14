BUILD_DIR := build
FILES := \
    cv_en.pdf \
    cv_fr.pdf \

.PHONY: all
all: $(FILES)

%.pdf: $(BUILD_DIR)/%.pdf
	cp $< $@

$(BUILD_DIR)/%.pdf: %.tex cv_common.tex twentysecondcv.cls
	@latexmk $< # Let the tool do its job

.PHONY: clean
clean:
	$(RM) -r build cv_en.pdf
