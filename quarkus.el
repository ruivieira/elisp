(require 'request)
(require 'json)

(setq quarkus-version "2.3.1.Final")
(setq quarkus--api-url "https://stage.code.quarkus.io/api")

(defun quarkus-create-app ()
  (interactive)
  (setq group-id (read-string "Group ID: " "org.acme"))
  (setq artifact-id (read-string "Artifact ID: " "getting-started"))
  (setq namespace (replace-regexp-in-string "-" "\." (concat group-id "." artifact-id)))
  (cd "~/tmp")
  (comint-send-string
   (get-buffer-process (shell))
   (format "mvn io.quarkus.platform:quarkus-maven-plugin:%1$s:create \
    -DprojectGroupId=%2$s \
    -DprojectArtifactId=%3$s \
    -DclassName='%4$s.GreetingResource' \
    -Dpath='/hello'\n" quarkus-version group-id artifact-id namespace))
  )

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
  (interactive)
  (setq extensions (quarkus--get-extensions))
  (string-join (mapcar '(lambda (e)
             (format "%s (%s)"
             (alist-get 'name e)
             (alist-get 'version e)))
          extensions)
               "\n"))

  (defun quarkus-add-extension ()
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
