EMACS   := emacs --init-directory=.
TANGLE  := "(progn (require 'ob-tangle) \
                   (org-babel-tangle-file \"roots.org\"))"

all: run

run: retangle
	$(EMACS)

retangle: init.el

init.el: roots.org
	$(EMACS) -q --batch --eval $(TANGLE)

clean:
	rm -rf init.el var/eln-cache/

package-clean: clean
	rm -rf elpa/
