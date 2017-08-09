EMACS ?= emacs25
CASK ?= cask

all: test

ob-influxdb.elc:
	EMACS=${EMACS} ${CASK} build

compile: ob-influxdb.elc

test: compile
	EMACS=${EMACS} ${CASK} exec ert-runner

clean:
	EMACS=${EMACS} ${CASK} clean-elc

run:
	EMACS=${EMACS} ${CASK} emacs

.PHONY: compile test clean run
