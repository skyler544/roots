EMACS  := emacs --init-directory=.
SETUP  := ROOTS_PACKAGE_SETUP=1
EARLY  := --load 'early-init.el'
INIT   := --load 'init.el'
TANGLE := "(progn (require 'ob-tangle) \
				  (org-babel-tangle-file \"roots.org\"))"
PHP    := "(use-package php-ts-mode :demand t \
			  :config (php-ts-mode-install-parsers))"
TS     := "(use-package treesit-auto :demand \
			   :custom (treesit-auto-install t) \
			   :config (treesit-auto-install-all))"
GHOSTTY := "(progn \
				 (require 'ghostel-module-install) \
				 (unless (ghostel--download-module \
				          (ghostel--module-directory) nil t) \
				   (error \"Failed to install the prebuilt Ghostty module\")))"

.NOTPARALLEL:

all: run

shave: package-clean treesit-clean install run

install: retangle install-all ghostty-module-install treesit-install

treesit-install: php
	$(SETUP) $(EMACS) --batch $(EARLY) --eval $(TS)

php:
	$(SETUP) $(EMACS) --batch $(EARLY) --eval $(PHP)

install-all:
	$(SETUP) $(EMACS) --batch $(EARLY) \
		--eval '(package-upgrade-all)' $(INIT) \
		--eval '(package-recompile-all)'

ghostty-module-install: install-all
	$(EMACS) --batch $(EARLY) --eval $(GHOSTTY)

run: retangle
	$(EMACS)

retangle: init.el

init.el: roots.org
	$(EMACS) --batch --eval $(TANGLE)

clean:
	rm -rf init.el var/eln-cache/

package-clean: clean
	rm -rf elpa/

treesit-clean:
	rm -rf tree-sitter
