(defun vlad/display-current-time ()
  (interactive)
  (message (format-time-string "%Y-%m-%d %H:%M:%S")))

(defun vlad/open-file (filename directory)
  (find-file (expand-file-name filename directory)))

(defun vlad/open-org-file (filename)
  (vlad/open-file filename vlad/org-directory))

(defun vlad/open-personal-file (filename)
  (vlad/open-file filename (expand-file-name "personal" vlad/org-directory)))

(defun vlad/open-config-file (filename)
  (vlad/open-file filename user-emacs-directory))

(defun vlad/open-plan ()
  (interactive)
  (vlad/open-personal-file "plan.org"))

(defun vlad/open-todo ()
  (interactive)
  (vlad/open-personal-file "todo.org"))

(defun vlad/open-config ()
  ;; TODO: test if file exists
  (interactive)
  (vlad/open-config-file "config.el"))

(defun vlad/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(85 . 50) '(100 . 100)))))

(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

(defun global-text-scale-adjust (inc) (interactive)
       (text-scale-set 1)
       (kill-local-variable 'text-scale-mode-amount)
       (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
       (global-text-scale-mode 1))

(defun vlad/font-adjust (increment)
  (let ((inhibit-message t))
    (global-text-scale-adjust increment)))

(defun vlad/font-inc ()
  (interactive)
  (vlad/font-adjust +1))

(defun vlad/font-dec ()
  (interactive)
  (vlad/font-adjust -1))

;; --- org-mode ---

;; FIXME: remove code duplication
(defun vlad/set-creation-time-heading-property ()
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (org-set-property "CREATED" (format-time-string "%T"))))

(defun vlad/set-creation-date-time-heading-property ()
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (org-set-property "CREATED" (format-time-string "%Y-%m-%d %T"))))

(defun vlad/org-mode-date-heading-on ()
  "Turn on heading creation time property"
  (interactive)
  (add-hook 'org-insert-heading-hook #'vlad/set-creation-time-heading-property))

(defun vlad/org-mode-date-heading-off ()
  "Turn off heading creation time property"
  (interactive)
  (remove-hook 'org-insert-heading-hook #'vlad/set-creation-time-heading-property))
