EMACS  := emacs --init-directory=.
TANGLE := "(progn (require 'ob-tangle) \
                  (org-babel-tangle-file \"roots.org\"))"
TERM   := "(use-package eat :ensure :config (eat-compile-terminfo))"

all: run

install: eat run

eat: retangle
	$(EMACS) -q --batch --eval $(TERM)

run: retangle
	$(EMACS)

retangle: init.el

init.el: roots.org
	$(EMACS) -q --batch --eval $(TANGLE)

clean:
	rm -rf init.el var/eln-cache/

package-clean: clean
	rm -rf elpa/
