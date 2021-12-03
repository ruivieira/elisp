;;; trustyai.el --- TrustyAI utilities -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Rui Vieira
;;
;; Author: Rui Vieira <https://github.com/ruivieira>
;; Maintainer: Rui Vieira <ruidevieira@googlemail.com>
;; Created: November 22, 2021
;; Modified: November 22, 2021
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/ruivieira/elisp
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:



(provide 'trustyai)
(require 'f)

(setq prerelease-tag "1.14")
(setq root "~/tmp")
(cd root)


(defun trustyai--remove-if-exists (arg)
  "Delete directory if it exists"
  (setq full-path (f-join root arg))
  (if (file-directory-p full-path)
        (progn
          (message (format "Deleting %s" full-path))
          (f-delete full-path t))))

(mapc #'trustyai--remove-if-exists '("kogito-runtimes" "kogito-apps" "kogito-examples"))

(compile
 (concat
  (format "git clone -b %s.x https://github.com/kiegroup/kogito-runtimes.git" prerelease-tag) " ; "
  (format "git clone -b %s.x https://github.com/kiegroup/kogito-apps.git" prerelease-tag) " ; "
  (format "git clone -b %s.x https://github.com/kiegroup/kogito-examples.git" prerelease-tag)))

(cd (f-join root "kogito-runtimes"))
(compile "mvn clean install -Dquickly")mvn clean install -DskipTests
;;; trustyai.el ends here
