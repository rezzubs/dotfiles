;; start an emacs server
(server-start)

;; remove bloat
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t
      fill-column 100
      confirm-kill-emacs #'y-or-n-p
      window-resize-pixelwise t
      frame-resize-pixelwise t
      initial-scratch-message ""
      read-file-name-completion-ignore-case t
      dired-kill-when-opening-new-dired-buffer t)


(setq-default major-mode
	      (lambda () ; guess major mode from file name
		(unless buffer-file-name
		  (let ((buffer-file-name (buffer-name)))
		    (set-auto-mode)))))

;; default modes FIXME
(save-place-mode t)
(savehist-mode t)
(recentf-mode t)
(setq auto-revert-mode t)
(electric-pair-mode t)
(electric-indent-mode t)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(keymap-global-set "C-c s" 'scratch-buffer)

(require 'package)

;; add melpa to package-archives

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; enable auto install
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(set-face-attribute 'default nil :family "JetBrains Mono" :height 140)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 40))

(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package hl-todo
  :config
  (global-hl-todo-mode t))

(use-package org
  :init
  (setq org-directory "~/org/")
  (require 'org-tempo)

  :config
  (setq org-agenda-files (list org-directory)
        org-capture-templates '(("t" "Todo" entry (file+headline "todo.org" "Inbox")
                                 "* TODO %?\n  %i\n  %a")
                                ("j" "Journal" entry (file+datetree "journal.org")
                                 "* %?\nEntered on %U\n  %i\n  %a"))
        org-return-follows-link t
        ;; make org pretty
        org-hide-emphasis-markers t
        org-link-descriptive t
        org-pretty-entities t)

        :bind (("C-c l" . org-store-link)
               ("C-c a" . org-agenda)
               ("C-c c" . org-capture))

        :hook (org-mode . org-indent-mode))

(use-package org-appear
    :hook (org-mode . org-appear-mode)
    :config
    (setq org-appear-autoemphasis t
          org-appear-autolinks t
          org-appear-autosubmarkers t
          org-appear-autoentities t))

(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Show more candidates
  (setq vertico-count 20))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

;; Configure directory extension. (nicer navigation)
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package which-key
  :init (which-key-mode))

(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package avy
  :bind ("C-:" . avy-goto-char-2))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
