;;; humble.el --- org-mode SSG

;; Copyright (C) 2021 Rui Vieira

;; Author: Rui Vieira <ruidevieira@googlemail.com>
;; Version: 0.1
;; Keywords: python, projects
;; URL: https://github.com/ruivieira/elisp

;;; Commentary:

;; org-mode SSG


;;; Code:

(provide 'humble)
(require 'f)
(require 'ox-hugo)

(defun humble-export-all()
  "Export all pages in the source root to Markdown"
  (dolist (fil (f-glob "~/Sync/notes/pages/site/*.org"))
    (with-current-buffer (find-file-noselect fil)
      (org-hugo-export-wim-to-md)
      (message (format "Exporting %s" fil))
      (kill-buffer))))

;;; humble.el ends here
