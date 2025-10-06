;;; init.el --- Minimal Emacs config with Evil and theme -*- lexical-binding: t; -*-

;; Ensure GUI Emacs gets a proper PATH on macOS
(when (memq window-system '(mac ns))
  ;; Common Nix profile locations:
  (dolist (p '("~/.nix-profile/bin"
               "/etc/profiles/per-user/$USER/bin"
               "/run/current-system/sw/bin"
               "/nix/var/nix/profiles/default/bin"))
    (when (file-directory-p (substitute-in-file-name p))
      (add-to-list 'exec-path (substitute-in-file-name p))
      (setenv "PATH" (concat (substitute-in-file-name p) ":" (getenv "PATH"))))))

;; (Optional but nice) also pull the shell env
(use-package exec-path-from-shell
  :straight t
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-copy-env "PATH"))

;; put these near the top of your init
(when (memq window-system '(mac ns))
  (setenv "PATH" (concat "/opt/homebrew/bin:/usr/local/bin:" (getenv "PATH")))
  (add-to-list 'exec-path "/opt/homebrew/bin")
  (add-to-list 'exec-path "/usr/local/bin"))

;; ---------------------------------------
;; Basic settings
;; ---------------------------------------
(setq inhibit-startup-message t
      ring-bell-function 'ignore
      make-backup-files nil
      auto-save-default nil)

;; Clean UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(add-to-list 'exec-path "/opt/homebrew/bin")


;; ---------------------------------------
;; Package management: straight.el
;; ---------------------------------------
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;; ---------------------------------------
;; Theme - Load FIRST before anything else
;; ---------------------------------------
(use-package doom-themes
  :straight t
  :demand t
  :config
  (load-theme 'doom-one t))

;; ---------------------------------------
;; Evil mode
;; ---------------------------------------
(use-package evil
  :straight t
  :demand t
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :straight t
  :after evil
  :demand t
  :config
  (evil-collection-init))

(use-package general
  ;;:straight t
  ;;:ensure t
  :after evil
  :config
  ;; Create the insert-state definer used in the README example
  (general-create-definer general-imap
    :states '(insert))

(general-imap "k"
              (general-key-dispatch 'self-insert-command
                :timeout 0.25
                "j" 'evil-normal-state)))
;; ---------------------------------------
;; Basic nice-to-haves
;; ---------------------------------------
(use-package which-key
  :straight t
  :demand t
  :config
  (which-key-mode 1))

;; ---------------------------------------
;; Completion: Corfu
;; ---------------------------------------
(use-package corfu
  :straight t
  :demand t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.2)
  (corfu-cycle t)
  (corfu-preselect 'first)
  :config
  ;; TAB-and-Go navigation
  (define-key corfu-map (kbd "TAB") #'corfu-next)
  (define-key corfu-map (kbd "<tab>") #'corfu-next)
  (define-key corfu-map (kbd "S-TAB") #'corfu-previous)
  (define-key corfu-map (kbd "<backtab>") #'corfu-previous))

;; ---------------------------------------
;; LSP: Python support
;; ---------------------------------------
(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook (python-mode . lsp-deferred)
  :custom
  (lsp-completion-provider :capf)  ;; Use completion-at-point (Corfu)
  (lsp-keymap-prefix "C-c l")
  (lsp-idle-delay 0.5)
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-pyright
  :straight t
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

(use-package lsp-ui
  :straight t
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-enable t))

;; completion front-end
(use-package vertico
  :straight t
  :init (vertico-mode))

;; better candidate filtering (fuzzy matching)
(use-package orderless
  :straight t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides
        '((file (styles partial-completion)))))

;; richer commands (like Telescope pickers)
(use-package consult
  :straight t
  :bind (("C-s"     . consult-line)            ;; fuzzy search in buffer
         ("C-x b"   . consult-buffer)          ;; switch buffer
         ("C-x C-b" . consult-buffer)
         ("M-y"     . consult-yank-pop)
         ("C-x C-r" . consult-recent-file)
         ("C-c p f" . project-find-file)
         ("C-c p s" . consult-ripgrep)))       ;; fuzzy search project

(use-package marginalia
  :straight t
  :init (marginalia-mode))

;; (A) projectile
(use-package projectile
  :straight t
  :config
  (projectile-mode 1)
  (setq projectile-project-search-path '("~/smithy/"))
  (setq projectile-switch-project-action #'projectile-dired))

;; (B) perspectives
(use-package persp-mode
  :straight t
  :config
  (persp-mode 1))

;; (C) purpose
;;(use-package purpose
;;  :straight t
;;  :config
;;  (purpose-mode 1)
;;  (add-to-list 'purpose-user-mode-purposes '(vterm-mode . terminal))
;;  (add-to-list 'purpose-user-mode-purposes '(shell-mode . terminal))
;;  (add-to-list 'purpose-user-mode-purposes '(help-mode . help))
;;  (purpose-compile-user-configuration))

;; (D) layout functions
(defun my/layout-default ()
  "Main editing + terminal below."
  (delete-other-windows)
  (split-window-below)
  (other-window 1)
  (vterm)
  (other-window 1))

(defun my/project-open-with-layout ()
  (interactive)
  (let ((proj (projectile-project-name)))
    (persp-switch (concat "proj:" proj))
    (projectile-switch-project)
    (my/layout-default)))

;; Keybindings
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "SPC p o") #'my/project-open-with-layout)
  (define-key evil-normal-state-map (kbd "SPC p w") #'projectile-switch-project)
  (define-key evil-normal-state-map (kbd "SPC p v") (lambda () (interactive) (vterm)))

  ;; Unbind the old behavior (optional, but safer)
  (define-key evil-normal-state-map "H" nil)
  (define-key evil-normal-state-map "L" nil)

  ;; Bind H / L in normal (and maybe visual / motion) states:
  (define-key evil-normal-state-map "H" 'evil-beginning-of-line)
  (define-key evil-normal-state-map "L" 'evil-end-of-line)

  (define-key evil-visual-state-map "H" 'evil-beginning-of-line)
  (define-key evil-visual-state-map "L" 'evil-end-of-line)
  
  (define-key evil-motion-state-map "H" 'evil-beginning-of-line)
  (define-key evil-motion-state-map "L" 'evil-end-of-line))

(with-eval-after-load 'lsp-mode
  (define-key evil-normal-state-map (kbd "gd") #'lsp-find-definition)
  (define-key evil-normal-state-map (kbd "gD") #'lsp-find-declaration)
  (define-key evil-normal-state-map (kbd "gr") #'lsp-find-references)
  (define-key evil-normal-state-map (kbd "gi") #'lsp-find-implementation)
  (define-key evil-normal-state-map (kbd "K")  #'lsp-ui-doc-glance))

(provide 'init)
;;; init.el ends here

