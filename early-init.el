;;; -*- lexical-binding: t -*-
;;
;; This is Roots. This early-init file sets a few initial settings, enables the
;; Emacs package manager, `use-package' (declarative macro for configuring
;; packages), and some organizational packages for init-directory housekeeping.
;;
;;
;; Basic initialization
;; ----------------------------------------------------
(mapc (lambda (dir)
        (let ((dir (concat user-emacs-directory dir)))
          (unless (file-directory-p dir) (make-directory dir))))
      '("var" "etc"))

(startup-redirect-eln-cache
 (concat user-emacs-directory "var/eln-cache"))

(setq inhibit-startup-screen t)
(setq inhibit-x-resources t)
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)
(setq load-prefer-newer noninteractive)

(setq custom-file (expand-file-name "var/custom.el" user-emacs-directory))

(when (string-equal system-type "darwin")
  (add-to-list 'default-frame-alist '(undecorated-round . t))
  (setq insert-directory-program "gls")
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta)
  (setq manual-program "gman")
  (fringe-mode 4))

;; Package management
;; ----------------------------------------------------
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(unless package-archive-contents
  (package-refresh-contents))

(use-package use-package
  :custom
  (use-package-always-ensure t)
  (use-package-always-defer t))

;; Organization
;; ----------------------------------------------------
(use-package no-littering :demand t)
(use-package minions
  :hook (after-init . minions-mode)
  :custom (minions-mode-line-lighter "--"))

;; Garbage collection
;; ----------------------------------------------------
(use-package gcmh
  :init (setq gcmh-idle-delay 'auto)
  :hook (emacs-startup . gcmh-mode))
