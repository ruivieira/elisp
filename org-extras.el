;;; org-extras.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Rui Vieira
;;
;; Author: Rui Vieira <https://github.com/rui>
;; Maintainer: Rui Vieira <ruidevieira@googlemail.com>
;; Created: November 09, 2021
;; Modified: November 09, 2021
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/rui/org-extras
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:
(require 'org)

(defun org-extras-notes ()
  "Switch to the notes view"
  (interactive)
  (delete-other-windows)
  (find-file "~/Sync/notes/pages/contents.org")
  (split-window-horizontally)
  (org-agenda))


(provide 'org-extras)
;;; org-extras.el ends here
