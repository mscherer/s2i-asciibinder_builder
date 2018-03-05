STYLESHEET=https://www.projectatomic.io/stylesheets/application.css

ALL_ADOC_FILES := $(shell find . -type f -name '*.adoc')
ALL_HTMl_FILES = $(patsubst %.adoc,%.html,$(ALL_ADOC_FILES))

all: $(ALL_HTMl_FILES)

_build:
	mkdir _build

%.html: %.adoc _build
	asciidoctor -a linkcss -a stylesheet=$(STYLESHEET) $< -o _build/$@

