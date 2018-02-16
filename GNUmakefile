cram =
tests = t

bindir = /usr/local/bin

.PHONY: all
all: ghisco

.PHONY: check
check: all
	env -i PATH="$$PATH" BUILDDIR="$$PWD" cram $(cram) $(tests)

.PHONY: html
html: README.html

%.html: %.rst
	rst2html --strict $< $@

.PHONY: install
install: all
	install -m 755 ghisco $(DESTDIR)$(bindir)

ghisco: s/ghisco.sh
	install -m 755 $< $@
