;;; -*- lexical-binding: t -*-
;;
;; This is Roots. This config works with Emacs 29.1+; older versions may require
;; manual tweaking. See the file `roots.org' for the documentation for this
;; config. This file ensures that packages can be installed and then installs
;; and configures `use-package' (declarative macro for configuring packages),
;; `no-littering' (library for keeping `user-emacs-directory' organized),
;; 'minions' (space saving package for the modeline), and `gcmh' (package for
;; automating a common "fix" for excessive elisp garbage collection).
;;
;; `init.el' will not exist without tangling `roots.org'. Run make retangle in
;; your shell to generate it.
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

;; Package management
;; ----------------------------------------------------
;; Start up the built-in Emacs package manager.
(package-initialize)

;; Add a larger package repository.
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")))

;; If the package list is empty, initialize it.
(unless package-archive-contents
  (package-refresh-contents))

;; Enable `use-package'; not necessary on Emacs 29.1+.
;; `use-package' is used to declaratively configure packages.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))

(use-package use-package
  :config
  ;; Install missing packages by default
  (setq use-package-always-ensure t)
  (setq use-package-always-defer t)
  (setq use-package-verbose t)
  (setq use-package-compute-statistics t))

;; Organization
;; ----------------------------------------------------
(use-package no-littering :demand t)
(use-package minions
  :hook (after-init . minions-mode)
  :config (setq minions-mode-line-lighter "--"))

;; Garbage collection
;; ----------------------------------------------------
(use-package gcmh
  :init (setq gcmh-idle-delay 'auto)
  :hook (emacs-startup . gcmh-mode))
