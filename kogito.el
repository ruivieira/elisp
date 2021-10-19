(setq kogito-apps-root "~/Sync/code/rh/trusty/kogito-apps")
(defun kogito-make-path (p) (concat kogito-apps-root "/" p))
(defun maven-install (p) (shell-command-to-string (concat "mvn -f " (kogito-make-path p) " clean install -DskipTests")))

(setq my_shell_output (maven-install "persistence-commons/pom.xml"))
(message my_shell_output)

(setq my_shell_output (maven-install "explainability/pom.xml"))
(message my_shell_output)
