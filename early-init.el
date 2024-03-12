;;; -*- lexical-binding: t -*-
;;
;; Basic initialization
;; ----------------------------------------------------
;; Create some directories for later use
(unless (file-directory-p "var") (make-directory "var"))
(unless (file-directory-p "etc") (make-directory "etc"))
