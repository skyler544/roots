;;; -*- lexical-binding: t -*-
;;
;; Basic initialization
;; ----------------------------------------------------
;; Create some directories for later use
(unless (file-directory-p "var") (make-directory "var"))
(unless (file-directory-p "etc") (make-directory "etc"))

;; Redirect native-comp cache.
(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name "var/eln-cache" user-emacs-directory))))

;; Don't let `customize' output to `init.el'.
(setq custom-file (expand-file-name "var/custom.el" user-emacs-directory))

;; MacOS specific settings
(when (string-equal system-type "darwin")
  (add-to-list 'default-frame-alist '(undecorated-round . t))
  (setq insert-directory-program "gls")
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta)
  (setq manual-program "gman"))
