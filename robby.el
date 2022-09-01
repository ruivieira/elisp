;;; robby.el --- Personal automation

;; Copyright (C) 2022 Rui Vieira

;; Author: Rui Vieira <ruidevieira@googlemail.com>
;; Version: 0.1
;; Keywords: python, projects, xonsh
;; URL: https://github.com/ruivieira/elisp

;;; Commentary:

;; A package for personal automation.


;;; Code:
(provide 'trustyai)

(defun robby-notes-move ()
  "Move the Obsidian notes"
  (interactive)
  (compile "/home/rui/Sync/code/robby/robby/xontrib/notes.xsh move"))

(map! :leader
      (:prefix-map ("r" . "robby")
       (:prefix ("n" . "notes")
        :desc "Move notes" "m" #'robby-notes-move
        :desc "Another entry" "s" #'robby-notes-move)))

;;; robby.el ends here
