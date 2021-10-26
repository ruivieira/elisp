(setq quarkus-version "2.3.1.Final")

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
