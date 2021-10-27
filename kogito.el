;;; kogito.el --- Kogito utilities

;; Copyright (C) 2021 Rui Vieira

;; Author: Rui Vieira <ruidevieira@googlemail.com>
;; Version: 0.1
;; Keywords: python, projects
;; URL: https://github.com/ruivieira/elisp

;;; Commentary:

;; A package to manage Kogito projects.


;;; Code:
(setq kogito-apps-root "~/Sync/code/rh/trusty/kogito-apps")
(defun kogito-make-path (p) (concat kogito-apps-root "/" p))
(defun kogito--maven-install-string (p) (concat "mvn -f " (kogito-make-path p) "/pom.xml clean install -DskipTests\n"))

(defun maven-install (p)
  "Start a Maven clean-install in the `shell' buffer."
  (interactive)
  (comint-send-string
   (get-buffer-process (shell))
   (kogito--maven-install-string p)))

(provide 'kogito)
;;; kogito.el ends here
