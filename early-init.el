;;; -*- lexical-binding: t -*-
;;
;; This is Roots. This early-init file sets a few initial settings, enables the
;; Emacs package manager, `use-package' (declarative macro for configuring
;; packages), and some organizational packages for init-directory housekeeping.
;;
;; Requires Emacs 30+ with native compilation and treesitter.
;;
;; Basic initialization
;; ----------------------------------------------------
(mapc (lambda (dir)
        (let ((dir (locate-user-emacs-file dir)))
          (unless (file-directory-p dir) (make-directory dir))))
      '("var" "etc"))

(startup-redirect-eln-cache
 (locate-user-emacs-file "var/eln-cache"))

(setq custom-file (locate-user-emacs-file "var/custom.el"))

(use-package emacs :when (not (daemonp))
  :hook (window-setup . r/redisplay-after-first-frame)
  :custom ((inhibit-redisplay t)
           (inhibit-message t))
  :config (defun r/redisplay-after-first-frame ()
            (setq-default inhibit-redisplay nil)
            (setq-default inhibit-message nil)
            (redisplay)))

;; Package management
;; ----------------------------------------------------
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(unless package-archive-contents
  (package-refresh-contents))

(use-package use-package
  :custom ((use-package-always-ensure t)
           (use-package-always-defer t)))

;; Organization
;; ----------------------------------------------------
(use-package no-littering :demand)
(use-package minions
  :hook (after-init . minions-mode)
  :custom (minions-mode-line-lighter "--"))

;; UI Tweaks
;; ----------------------------------------------------
(mapc (lambda (parameter)
        (push `(,parameter . nil) default-frame-alist))
      '(menu-bar-lines tool-bar-lines vertical-scroll-bars))

;; Garbage collection
;; ----------------------------------------------------
(use-package gcmh
  :init (setq gcmh-idle-delay 'auto)
  :hook (emacs-startup . gcmh-mode))
