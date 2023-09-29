;; -*- lexical-binding: t; -*-

;; Personal information
(setq user-full-name "Vladislav Sharshukov"
      user-mail-address "vsharshukov@gmail.com")

(defconst xdg/cache-home (getenv "XDG_CACHE_HOME"))

(defconst vlad/home-directory (getenv "HOME"))
(defconst vlad/source-directory (expand-file-name "src" vlad/home-directory))
(defconst vlad/org-directory (expand-file-name "data/org" vlad/home-directory))

(defconst vlad/bibliography-file (expand-file-name "references.bib" vlad/org-directory))

(defalias 'yes-or-no-p 'y-or-n-p)

;; --- Theme ---
(set-frame-font "Fira Code 13" nil t)

(use-package gruvbox-theme
  :ensure t
  :init
  (load-theme 'gruvbox-dark-hard t)
  )

;; (global-display-line-numbers-mode 1)
;; See https://libreddit.tiekoetter.com/r/emacs/comments/8pfdlb/weird_shifting_problem_with_new_emacs_line_numbers/
(setq display-line-numbers-type 'relative
      display-line-numbers-width-start t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq standard-indent 2)

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

    "SPC" 'projectile-find-file

    "dy" 'org-roam-dailies-goto-yesterday
    "dt" 'org-roam-dailies-goto-today

    "ea" 'embark-act

    "fs" 'grep-find

    "gs" 'magit-status

    "hf" 'describe-function
    "hk" 'describe-key
    "hv" 'describe-variable

    "kb" 'kill-buffer
    "kw" 'delete-window

    "nc" 'org-roam-capture
    "nf" 'org-roam-node-find
    "ni" 'org-roam-node-insert
    "ns" 'vlad/org-capture-slipbox
    "nt" 'org-roam-buffer-toggle

    "oa" 'org-agenda
    "oc" 'vlad/open-config

    "ps" 'projectile-switch-project
    "pf" 'projectile-ripgrep

    "sb" 'ivy-switch-buffer

    "vs" 'load-theme
    "vtt" 'vlad/toggle-transparency

    "ua" 'vlad/refresh-org-agenda-files)

  (general-def 'normal
    "C-S-j" 'vlad/font-dec
    "C-О" 'vlad/font-dec
    "C-S-k" 'vlad/font-inc
    "C-Л" 'vlad/font-inc)

  (general-def 'insert
    "C-ц" 'evil-delete-backward-word
    "C-т" 'evil-complete-next
    "C-з" 'evil-complete-previous)

  (general-def 'insert org-mode-map
    "C-M-<return>" 'org-insert-todo-heading)

  (general-nmap org-mode-map
    :prefix "SPC"

    "aa" 'org-attach-attach

    "c" 'org-ctrl-c-ctrl-c

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
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; --- LSP ---
(use-package lsp-mode
  :ensure t)

(use-package yasnippet
  :ensure t
  )

;; --- Tree sitter ---
(setq treesit-language-source-alist
      '((elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (json "https://github.com/tree-sitter/tree-sitter-json")))

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

(use-package ivy
  :ensure t
  :init
  (setq ivy-initial-inputs-alist nil)
  :config
  (ivy-mode)
  )

(use-package counsel
  :after ivy
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
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

(require 'org)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))

(use-package org-roam
  :ensure t

  :custom
  (org-roam-directory vlad/org-directory)

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

        ("p" "personal" plain "%?"
         :if-new
         (file+head "personal/%<%Y%m%d%H%M%S>-${slug}.org"
                    ":PROPERTIES:\n:CATEGORY: ${title}\n:END:\n#+TITLE: ${title}\n#+CREATED: %U\n#+FILETAGS: :personal:\n")
         :immediate-finish t
         :unnarrowed t)

        ("y" "yandex" plain "%?"
         :if-new
         (file+head "yandex/%<%Y%m%d%H%M%S>-${slug}.org"
                    ":PROPERTIES:\n:CATEGORY: Yandex - ${title}\n:END:\n#+TITLE: Yandex - ${title}\n#+CREATED: %U\n#+FILETAGS: :yandex:nda:\n")
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

(setq org-roam-dailies-directory "daily/")
(setq org-roam-dailies-capture-templates
      `(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))

;; --- Projectile ---
(use-package projectile
  :ensure t
  :diminish
  :config
  (projectile-mode))

(use-package projectile-ripgrep
  :after projectile
  :ensure t
  :diminish
  :init
  (setq ripgrep-arguments `("--hidden"))
  )

;; --- Web dev ---
(use-package emmet-mode
  :ensure t
  :diminish
  :hook
  (html-mode . emmet-mode))

;; --- Programming languages ---
(use-package json-mode
  :ensure t)
