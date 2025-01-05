EMACS  := emacs --init-directory=.
EARLY  := --load 'early-init.el'
TANGLE := "(progn (require 'ob-tangle) \
				  (org-babel-tangle-file \"roots.org\"))"
TERM   := "(use-package eat :ensure :config (eat-compile-terminfo))"
PHP    := "(use-package php-ts-mode \
			  :config (php-ts-mode-install-parsers))"
TS     := "(use-package treesit-auto :demand \
			   :custom (treesit-auto-install t) \
			   :config (treesit-auto-install-all))"

all: run

shave: package-clean clean treesit-clean install run

install: eat treesit-install php run

eat:
	$(EMACS) --batch --eval $(TERM)

treesit-install:
	$(EMACS) --batch $(EARLY) --eval $(TS)

php:
	$(EMACS) --batch --eval $(PHP)

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
