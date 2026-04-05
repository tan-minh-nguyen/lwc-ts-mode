.PHONY: all compile clean test

EMACS ?= emacs
BATCH := $(EMACS) -Q --batch -L .

EL_FILES := lwc-ts-mode.el lwc-ts-common.el lwc-js-ts-mode.el lwc-html-ts-mode.el
ELC_FILES := $(EL_FILES:.el=.elc)

all: compile

compile: $(ELC_FILES)

%.elc: %.el
	$(BATCH) -f batch-byte-compile $<

clean:
	rm -f $(ELC_FILES)

test:
	$(BATCH) -l ert -l lwc-ts-mode.el -l test/*.el -f ert-run-tests-batch-and-exit

lint:
	$(BATCH) -l package-lint -f package-lint-batch-and-exit $(EL_FILES)

check-parens:
	$(BATCH) --eval '(dolist (f (list $(patsubst %,"%",$(EL_FILES)))) (find-file f) (check-parens))'
