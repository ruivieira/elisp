;;; quarkus.el --- Quarkus utilities

;; Copyright (C) 2021 Rui Vieira

;; Author: Rui Vieira <ruidevieira@googlemail.com>
;; Version: 0.1
;; Package-Requires: ((emacs "24.4") (emacs "25.1") (emacs "26.1") (request "0.3"))
;; Keywords: java, quarkus, projects
;; URL: https://github.com/ruivieira/elisp

;;; Commentary:

;; Package for Quarkus


;;; Code:
(require 'request)
(require 'json)

(defvar quarkus-version "2.5.1.Final")
(defvar quarkus--api-url "https://stage.code.quarkus.io/api")

(defun quarkus--maven-create-project-str (group-id artifact-id namespace)
  (format "mvn io.quarkus.platform:quarkus-maven-plugin:%1$s:create \
    -DprojectGroupId=%2$s \
    -DprojectArtifactId=%3$s \
    -DclassName='%4$s.GreetingResource' \
    -Dpath='/hello'\n" quarkus-version group-id artifact-id namespace))

(defun quarkus-create-app ()
  "Create a quarkus application"
  (interactive)
  (setq group-id (read-string "Group ID: " "org.acme"))
  (setq artifact-id (read-string "Artifact ID: " "getting-started"))
  (setq namespace (replace-regexp-in-string "-" "\." (concat group-id "." artifact-id)))
  (cd "~/tmp")
  (compile (quarkus--maven-create-project-str group-id artifact-id namespace)))

(defun quarkus--get-extensions ()
  (request-response-data (request (concat quarkus--api-url "/extensions")
    :parser 'json-read
    :sync t
    ))
  )

(defun quarkus--maven-add-extension (extension)
  (comint-send-string
   (get-buffer-process (shell))
   (format "./mvnw quarkus:add-extension -Dextensions=\"%s\"\n" extension))
  )

(defun quarkus-list-extensions ()
  "Return a list of available Quarkus extensions"
  (interactive)
  (setq extensions (quarkus--get-extensions))
  (string-join (mapcar '(lambda (e)
             (format "%s (%s)"
             (alist-get 'name e)
             (alist-get 'version e)))
          extensions)
               "\n"))

(defun quarkus-add-extension ()
  "Add a Quarkus extension to the current project"
    (interactive)

    (setq extensions (quarkus--get-extensions))
    (setq ext-table (make-hash-table :test 'equal))
    (mapcar '(lambda (e)
               (puthash
                (format "%s (%s)"
                       (alist-get 'name e)
                       (alist-get 'version e))
                e ext-table))
            extensions)
    (quarkus--maven-add-extension (alist-get 'id (gethash (ido-completing-read "Extension to add: " (hash-table-keys ext-table)) ext-table)))
    )

(defun quarkus-build-binary ()
  "Compile current Quarkus application to native"
     (interactive)
     (comint-send-string
      (get-buffer-process (shell))
      "./mvnw package -Pnative\n")
     )

(provide 'quarkus)
;;; quarkus.el ends here
