EMACS   := emacs --init-directory=.
TANGLE  := "(progn (require 'ob-tangle) (org-babel-tangle-file \"roots.org\"))"

run:
	$(EMACS)

retangle:
	$(EMACS) -q --batch --eval $(TANGLE)

clean:
	rm -rf init.el elpa/
