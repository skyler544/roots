EMACS   := emacs --init-directory=.
TANGLE  := "(progn (require 'ob-tangle) (org-babel-tangle-file \"roots.org\"))"
INSTALL := "(add-hook 'native-comp-async-all-done-hook 'kill-emacs)"

all: run

run: retangle
	$(EMACS)

retangle:
	$(EMACS) -q --batch --eval $(TANGLE)

clean:
	rm -rf init.el elpa/

clean-install: clean retangle
	$(EMACS) --eval $(INSTALL)
