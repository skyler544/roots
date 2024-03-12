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
