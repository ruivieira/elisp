(setq kogito-apps-root "~/Sync/code/rh/trusty/kogito-apps")
(defun kogito-make-path (p) (concat kogito-apps-root "/" p))
(defun maven-install-string (p) (concat "mvn -f " (kogito-make-path p) "/pom.xml clean install -DskipTests\n"))

(defun maven-install (p)
  "Start a Maven clean-install in the `shell' buffer."
  (interactive)
  (comint-send-string
   (get-buffer-process (shell))
   (maven-install-string p)))

(maven-install "persistence-commons")
(maven-install "explainability")

