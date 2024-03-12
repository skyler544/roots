EMACS   := emacs --init-directory=.

run:
	$(EMACS)

clean:
	rm -rf elpa/
