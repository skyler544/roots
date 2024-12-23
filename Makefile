EMACS  := emacs --init-directory=.
TANGLE := "(progn (require 'ob-tangle) \
				  (org-babel-tangle-file \"roots.org\"))"
TERM   := "(use-package eat :ensure :config (eat-compile-terminfo))"
PHP    := "(progn (require 'php-ts-mode) \
				  (php-ts-mode-install-parsers))"

all: run

install: eat php run

eat:
	$(EMACS) --batch --eval $(TERM)

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
