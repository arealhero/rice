;; Personal information
(setq user-full-name "Vladislav Sharshukov"
      user-mail-address "vsharshukov@gmail.com")

(defconst xdg/cache-home (getenv "XDG_CACHE_HOME"))

(defconst vlad/home-directory (getenv "HOME"))
(defconst vlad/source-directory (expand-file-name "src" vlad/home-directory))
(defconst vlad/org-directory (expand-file-name "www/sharshukov.xyz" vlad/source-directory))

(defconst vlad/bibliography-file (expand-file-name "references.bib" vlad/org-directory))

;; (defconst xdg/data-dir (getenv "XDG_DATA_DIR")) ;; TODO: this is not XDG's
;; (defconst vlad/org-directory (expand-file-name "org" xdg/data-dir))

(defalias 'yes-or-no-p 'y-or-n-p)

;; --- Theme ---

(set-frame-font "Fira Code 11" nil t)
(load-theme 'modus-operandi)
;; (load-theme 'modus-vivendi)

;; (global-display-line-numbers-mode 1)
;; See https://libreddit.tiekoetter.com/r/emacs/comments/8pfdlb/weird_shifting_problem_with_new_emacs_line_numbers/
(setq display-line-numbers-type 'relative
      display-line-numbers-width-start t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq standard-indent 2)

(use-package writeroom-mode
  :ensure t)

(use-package diminish
  :ensure t)

;; Ignore win-space language toggle
(global-set-key [?\s- ] 'ignore)

(use-package general
  :ensure t
  :config

  (general-evil-setup)

  (general-nmap
    :prefix "SPC"

    "SPC" 'org-roam-node-find

    "dy" 'org-roam-dailies-goto-yesterday
    "dt" 'org-roam-dailies-goto-today

    "ea" 'embark-act

    "fs" 'grep-find

    "gs" 'magit-status

    "hf" 'describe-function
    "hk" 'describe-key
    "hv" 'describe-variable

    "kb" 'kill-buffer

    "nc" 'org-roam-capture
    "nf" 'org-roam-node-find
    "ni" 'org-roam-node-insert
    "ns" 'vlad/org-capture-slipbox
    "nt" 'org-roam-buffer-toggle

    "oa" 'org-agenda
    "oc" 'vlad/open-config
    "op" 'vlad/open-plan

    ;; Reference Open
    "ro" 'citar-open

    "st" 'vlad/display-current-time

    "vs" 'load-theme
    "vtt" 'vlad/toggle-transparency

    "ua" 'vlad/refresh-org-agenda-files

    "zt" 'writeroom-toggle-mode-line
    "zz" 'writeroom-mode)

  (general-def 'normal
    "C-S-j" 'vlad/font-dec
    "C-О" 'vlad/font-dec
    "C-S-k" 'vlad/font-inc
    "C-Л" 'vlad/font-inc)

  (general-def 'insert
    "C-ц" 'evil-delete-backward-word)

  (general-def 'normal org-mode-map
    "TAB" 'org-cycle)

  (general-nmap org-mode-map
    :prefix "SPC"

    "aa" 'org-attach-attach

    "c" 'org-ctrl-c-ctrl-c

    "ic" 'citar-insert-citation

    "lt" 'vlad/set-creation-time-heading-property

    ;; Mark
    "md" 'org-deadline
    "ms" 'org-schedule
    "mt" 'org-set-tags-command

    "oo" 'org-open-at-point

    "pf" 'org-latex-preview

    "," 'org-metaleft
    "." 'org-metaright

    "t" 'org-todo)
  )

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode))

;; --- git ---
(use-package magit
  :ensure t)

(use-package git-gutter
  :ensure t
  :diminish
  :config
  (global-git-gutter-mode +1))

;; --- Misc ---

(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)
(setq electric-pair-skip-whitespace nil)
(setq-default electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)

;; See https://libredd.it/r/emacs/comments/l42oep/comment/gkmnh3y/
(setq comp-async-report-warnings-errors nil)
(setq native-comp-async-report-warnings-errors nil)

(setq scroll-margin 5
      scroll-step 1
      scroll-conservatively 10000)

(setq confirm-kill-emacs nil)

;; By default Emacs creates backup files (e.g. test.c~) and autosave
;; files (e.g. #test.c#) in the same directory the file belongs to.
;; The next code block moves those files to the separate directory.
(defconst emacs-cache-dir (expand-file-name "emacs" xdg/cache-home))
(make-directory emacs-cache-dir t)

(setq backup-directory-alist
      `((".*" . ,emacs-cache-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-cache-dir t)))
(setq auto-save-list-file-prefix
      emacs-cache-dir)

(setq undo-tree-history-directory-alist
      `((".*" . ,emacs-cache-dir)))

(use-package undo-tree
  :after evil
  :ensure t
  :diminish
  :config
  (global-undo-tree-mode)
  (evil-set-undo-system 'undo-tree))

(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  )

(use-package orderless
  :after vertico
  :ensure t
  :init

  (setq orderless-matching-styles '(orderless-flex))

  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))
        )
  )

(use-package marginalia
  :after vertico
  :ensure t
  :init
  (marginalia-mode)
  )

(use-package citar
  :ensure t
  :custom
  (citar-bibliography (list vlad/bibliography-file))
  (citar-notes-paths '((expand-file-name "references" vlad/org-directory)))
  ;; (citar-notes-paths '("~/data/org/roam/references"))

  ;; FIXME: set this after citer is installed & org is required

  (org-cite-global-bibliography (list vlad/bibliography-file))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  )

(use-package evil-commentary
  :ensure t
  :diminish
  :hook
  (after-init . evil-commentary-mode))

;; --- Org ---

(setq org-directory vlad/org-directory
      org-attach-use-inheritance t
      org-hide-emphasis-markers nil
      ;; org-startup-indented t
      org-confirm-babel-evaluate nil)

(setq org-todo-keywords '((sequence "TODO(t)" "JOB(j)" "UNI(u)" "|" "DONE(d)" "CANCELLED(c)")))
(setq org-log-done 'time)
;; (setq org-scheduled-past-days 0)
(setq org-scheduled-past-days 10000)

(defun vlad/refresh-org-agenda-files ()
   (interactive)
   (setq org-agenda-files (directory-files-recursively vlad/org-directory "\\.org$")))

(vlad/refresh-org-agenda-files)

;; Just messing around with KaTeX. AFAIK it is significantly
;; faster than MathJax, but lacks some functionality.
(setq org-html-mathjax-template
      (with-temp-buffer
        (insert-file-contents (expand-file-name "katex.html" user-emacs-directory))
        (buffer-string)))

(require 'org)
;; (setq org-preview-latex-default-process 'dvisvgm)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))

(add-hook 'org-mode-hook
          #'(lambda ()
              (delete '("\\.pdf\\'" . default) org-file-apps)
              (delete '("\\.djvu\\'" . default) org-file-apps)
              (add-to-list 'org-file-apps '("\\.pdf\\'" . "sioyek %s"))
              (add-to-list 'org-file-apps '("\\.djvu\\'" . "zathura %s"))

              (delete '("\\.webm\\'" . default) org-file-apps)
              (delete '("\\.mkv\\'" . default) org-file-apps)
              (add-to-list 'org-file-apps '("\\.webm\\'" . "mpv --speed=1.75 --fs %s"))
              (add-to-list 'org-file-apps '("\\.mkv\\'" . "mpv --speed=1.75 --fs %s"))))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; beamer support in org-mode
(eval-after-load "ox-latex"
  '(add-to-list 'org-latex-classes
                `("beamer"
                  ,(concat "\\documentclass[presentation]{beamer}\n"
                           "[DEFAULT-PACKAGES]"
                           "[PACKAGES]"
                           "[EXTRA]\n")
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(use-package org-roam
  :ensure t

  :custom
  (org-roam-directory vlad/org-directory)
  ;; (org-roam-directory (expand-file-name "roam" vlad/org-directory))

  :config
  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
         (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))

  (setq org-roam-node-display-template
        (concat "${type:15} ${title:*} "
                (propertize "${tags:10}" 'face 'org-tag)))

  (org-roam-db-autosync-mode))

(setq org-roam-capture-templates
      `(("m" "main" plain "%?"
         :if-new
         (file+head "main/%<%Y%m%d%H%M%S>-${slug}.org"
                    ":PROPERTIES:\n:CATEGORY: ${title}\n:END:\n#+TITLE: ${title}\n#+CREATED: %U\n")
         :immediate-finish t
         :unnarrowed t)

        ("r" "reference" plain "%?"
         :if-new
         (file+head "references/${citar-citekey}.org"
                    ":PROPERTIES:\n:CATEGORY: ${citar-citekey}\n:END:\n#+TITLE: ${note-title}\n#+CREATED: %U\n#+FILETAGS: :reference:\n")
         ;; (file+head "references/%<%Y%m%d%H%M%S>-${slug}.org"
         ;;            ":PROPERTIES:\n:CATEGORY: ${citar-citekey}\n:END:\n#+TITLE: ${citar-citekey} ${note-title}\n#+CREATED: %U\n#+FILETAGS: :reference:\n")
         :immediate-finish t
         :unnarrowed t)

        ("p" "personal" plain "%?"
         :if-new
         (file+head "personal/%<%Y%m%d%H%M%S>-${slug}.org"
                    ":PROPERTIES:\n:CATEGORY: ${title}\n:END:\n#+TITLE: ${title}\n#+CREATED: %U\n#+FILETAGS: :personal:\n")
         :immediate-finish t
         :unnarrowed t)

        ("h" "people" plain "%?"
         :if-new
         (file+head "personal/people/%<%Y%m%d%H%M%S>-${slug}.org"
                    ":PROPERTIES:\n:CATEGORY: ${title}\n:END:\n#+TITLE: ${title}\n#+CREATED: %U\n#+FILETAGS: :personal:people:\n")
         :immediate-finish t
         :unnarrowed t)

        ("u" "uni" plain "%?"
         :if-new
         (file+head "uni/${slug}.org"
                    ":PROPERTIES:\n:CATEGORY: ${title}\n:END:\n#+TITLE: ${title}\n#+CREATED: %U\n#+FILETAGS: :uni:\n")
         :immediate-finish t
         :unnarrowed t)

        ("a" "article" plain "%?"
         :if-new
         (file+head "articles/%<%Y%m%d%H%M%S>-${slug}.org"
                    ":PROPERTIES:\n:CATEGORY: ${title}\n:END:\n#+TITLE: ${title}\n#+CREATED: %U\n#+FILETAGS: :article:\n")
         :immediate-finish t
         :unnarrowed t)
        ))

(setq org-capture-templates
      `(
        ("s" "Slipbox" entry (file "personal/inbox.org")
         "* %?\n"
         :empty-lines 1
         :unnarrowed t)
        ))

(defun vlad/org-capture-slipbox ()
  (interactive)
  (org-capture nil "s"))

(defun vlad/tag-new-node-as-draft ()
  (org-roam-tag-add '("draft")))
(add-hook 'org-roam-capture-new-node-hook #'vlad/tag-new-node-as-draft)

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((octave . t)
;;    (C . t)
;;    (python . t)))

(setq org-roam-dailies-directory "daily/")
(setq org-roam-dailies-capture-templates
      `(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))

(use-package citar-org-roam
  :after (citar org-roam)
  :ensure t
  :diminish
  :config

  (citar-org-roam-mode)
  (setq citar-org-roam-note-title-template "${author:%sn} - ${title}"
        citar-org-roam-capture-template-key "r")

  (setq citar-org-roam-template-fields
        '((:citar-title "title")
          (:citar-author "author" "editor")
          (:citar-date "date" "year" "issued")
          (:citar-pages "pages")
          (:citar-type "=type="))
        )


  (add-to-list 'citar-file-open-functions
               '("pdf" . citar-file-open-external))
  (add-to-list 'citar-file-open-functions
               '("djvu" . citar-file-open-external))
  )

(use-package embark
  :ensure t)

(use-package citar-embark
  :after citar embark
  :ensure t
  :diminish
  :config

  (citar-embark-mode))
