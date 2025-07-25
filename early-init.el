;;; -*- lexical-binding: t -*-
;;
;; This is Roots. This early-init file sets a few initial settings, enables the
;; Emacs package manager, `use-package' (declarative macro for configuring
;; packages), and some organizational packages for init-directory housekeeping.
;;
;; Requires Emacs 30+ with native compilation and treesitter.
;;
;; Hacks and optimizations
;; ----------------------------------------------------
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold (* 1024 1024 20))))
(setq gc-cons-threshold most-positive-fixnum)
(setq inhibit-default-init t)

(add-hook 'window-setup-hook
          (lambda ()
            (setq-default inhibit-redisplay nil)
            (setq-default inhibit-message nil)))
(setq inhibit-redisplay t)
(setq inhibit-message t)

(mapc (lambda (parameter)
        (push `(,parameter . nil) default-frame-alist))
      '(menu-bar-lines tool-bar-lines vertical-scroll-bars))

;; Organization
;; ----------------------------------------------------
(mapc (lambda (dir)
        (let ((dir (locate-user-emacs-file dir)))
          (unless (file-directory-p dir) (make-directory dir))))
      '("var" "etc"))

(startup-redirect-eln-cache
 (locate-user-emacs-file "var/eln-cache"))

(setq custom-file (locate-user-emacs-file "var/custom.el"))

;; Package management
;; ----------------------------------------------------
(use-package package
  :init
  (package-initialize)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (unless package-archive-contents
    (package-refresh-contents)))

(use-package use-package
  :custom ((use-package-always-ensure t)
           (use-package-always-defer t)
           (use-package-expand-minimally t)))

;; Garbage collection
;; ----------------------------------------------------
(use-package gcmh
  :init (setq gcmh-idle-delay 'auto)
  :hook (emacs-startup . gcmh-mode))
