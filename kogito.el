;;; kogito.el --- Kogito utilities

;; Copyright (C) 2021 Rui Vieira

;; Author: Rui Vieira <ruidevieira@googlemail.com>
;; Version: 0.1
;; Keywords: python, projects
;; URL: https://github.com/ruivieira/elisp

;;; Commentary:

;; A package to manage Kogito projects.


;;; Code:
(defun kogito--create-app-str (group-id artifact-id version)
(format "mvn io.quarkus:quarkus-maven-plugin:create \
    -DprojectGroupId=%1$s -DprojectArtifactId=%2$s \
    -DprojectVersion=%3$s -Dextensions=kogito-quarkus\n" group-id artifact-id version))

(defun kogito-app-create ()
  (interactive)
  (setq target (read-directory-name "Target directory: " "~/"))
  (setq group-id (read-string "Group ID: " "org.acme"))
  (setq artifact-id (read-string "Artifact ID: " "getting-started"))
  (setq version (read-string "Version: " "1.0.0-SNAPSHOT"))
  (cd target)
  (compile (kogito--create-app-str group-id artifact-id version))
  ;; (eshell-command (kogito--create-app-str group-id artifact-id version))
  ;;(comint-send-string (get-buffer-process (shell)) (kogito--create-app-str group-id artifact-id version))
  )
(setq kogito-apps-root "~/Sync/code/rh/trusty/kogito-apps")
(defun kogito-make-path (p) (concat kogito-apps-root "/" p))
(defun kogito--maven-install-string (p) (concat "mvn -f " (kogito-make-path p) "/pom.xml clean install -DskipTests\n"))

(defun kogito-maven-install (p)
  "Start a Maven clean-install in the `shell' buffer."
  (interactive)
  (comint-send-string
   (get-buffer-process (shell))
   (kogito--maven-install-string p)))

(defun kogito-app-scaffold ()
  (interactive)
  (when (locate-dominating-file default-directory "pom.xml")
    (cd (locate-dominating-file default-directory "pom.xml"))
    (compile "mvn compile kogito:scaffold")
    )
  )

(provide 'kogito)
;;; kogito.el ends here
