;;; -*- lexical-binding: t; no-byte-compile: t -*-
;;
;; This is Roots. This early-init file sets a few initial settings, enables the
;; Emacs package manager, `use-package' (declarative macro for configuring
;; packages), and some organizational packages for init-directory housekeeping.
;;
;; Requires Emacs 30+ with native compilation and treesitter.
;;
;; Startup hacks and optimizations
;; ----------------------------------------------------
(let ((file-name-handler-alist-old file-name-handler-alist))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq file-name-handler-alist file-name-handler-alist-old)
              (setq-default inhibit-redisplay nil))))

(setq gc-cons-threshold most-positive-fixnum
      file-name-handler-alist nil
      inhibit-default-init t
      load-prefer-newer noninteractive
      inhibit-redisplay t)

(dolist (parameter '(menu-bar-lines tool-bar-lines vertical-scroll-bars))
  (push `(,parameter . nil) default-frame-alist))

;; Organization
;; ----------------------------------------------------
(dolist (dir '("var" "etc"))
  (let ((dir (locate-user-emacs-file dir)))
    (unless (file-directory-p dir) (make-directory dir))))

(startup-redirect-eln-cache
 (locate-user-emacs-file "var/eln-cache"))

(setq custom-file (locate-user-emacs-file "var/custom.el"))

;; Package management
;; ----------------------------------------------------
(defconst r/package-setup-p (and (getenv "ROOTS_PACKAGE_SETUP") t)
  "Non-nil while the explicit package setup runs.")

(use-package package
  :init
  (package-initialize)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/"))
  (when r/package-setup-p
    (package-refresh-contents)))

(use-package use-package
  :custom ((use-package-always-ensure r/package-setup-p)
           (use-package-always-defer t)
           (use-package-expand-minimally t)))

;; Garbage collection
;; ----------------------------------------------------
(use-package gcmh
  :init (setq gcmh-idle-delay 'auto)
  :hook (emacs-startup . gcmh-mode))
