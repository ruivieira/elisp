;;; agile.el --- Agile utilities

;; Copyright (C) 2021 Rui Vieira

;; Author: Rui Vieira <ruidevieira@googlemail.com>
;; Version: 0.1
;; Keywords: python, projects
;; URL: https://github.com/ruivieira/elisp

;;; Commentary:

;; Agile shortcuts.


;;; Code:
(require 'org)

(setq agile/doc-root (expand-file-name "~/Sync/notes/pages/JIRAs/"))

(defun agile--build-ticket-string (id title)
  (format "#+Title: %1$s-%2$s\n\n\
* JIRA Merge %1$s\n\
** REVIEW %1$s\n\
*** JIRA PR %1$s\n" id title)
  )

(defun agile--build-ticket-filename (id title)
  (format "%s - %s.org" id title))

(defun agile-ticket-create ()
  (interactive)
  (setq ticket-id (read-string "Ticket ID: "))
  (setq ticket-title (read-string "Ticket title: " "Ticket title"))
  (write-region (agile--build-ticket-string ticket-id ticket-title)
                nil
                (concat agile/doc-root
                        (agile--build-ticket-filename ticket-id ticket-title)))
  )

(setq
 org-agenda-custom-commands
 '(
   ("l" todo "LATER")
   ("j" "Agenda and JIRAs" ((agenda "") (todo "JIRA") (todo "REVIEW")))
   ("m" "Agenda and meetings" ((agenda "") (todo "MEETING")))
   ("w" "Work tasks and meetings" ((agenda "") (todo "MEETING") (todo "REVIEW") (todo "JIRA") (tags "+work")))
   ("tw" tags-todo "+work")
   ("n" "Agenda and all TODOs" ((agenda "") (todo "TODO")))
   ("f" "Fortnight agenda and all TODOs" ((agenda "" ((org-agenda-span 14))) (alltodo "")))
   ))

(provide 'agile)
;;; agile.el ends here
