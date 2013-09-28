THEME = theme.sed

install: ~/.nano/syntax.nanorc

install-separate: $(addprefix ~/.nano/syntax/, $(wildcard *.nanorc))

~/.nano/syntax.nanorc: *.nanorc mixins/*.nanorc $(THEME) | ~/.nano/
	@sed -f mixins.sed *.nanorc | sed -f $(THEME) $(FILTER) > $@
	@printf 'Installed: $@\n\n'
	@printf 'To enable, add the following line to your ~/.nanorc:\n\n'
	@printf '  include $@\n\n'

~/.nano/syntax/%.nanorc: %.nanorc mixins/*.nanorc $(THEME) | ~/.nano/syntax/
	@sed -f mixins.sed $< | sed -f $(THEME) $(FILTER) > $@
	@echo 'Installed: $@'

~/.nano/ ~/.nano/syntax/:
	@mkdir -p $@


ifeq ($(shell test -f ~/.nanotheme && echo 1),1)
  THEME = ~/.nanotheme
endif

# Remove "header" directives if not supported (introduced in nano 2.1.6)
NANOVER = $(shell nano -V | sed -n 's/^.* version \([0-9\.]*\).*/\1/p')
ifeq ($(shell printf "2.1.5\n$(NANOVER)" | sort -nr | head -1),2.1.5)
  FILTER += | sed -e '/^header/d'
endif

ifdef TEXT
  FILTER += | sed -e 's|^color \(bright\)\{0,1\}black|color \1$(TEXT)|'
endif

ifdef BSDREGEX
  FILTER += | sed -e 's|\\<|[[:<:]]|g;s|\\>|[[:>:]]|g'
endif


.PHONY: install install-separate ~/.nano/syntax.nanorc
