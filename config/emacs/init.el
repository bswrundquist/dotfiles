
;;; init.el --- Clean, reliable Emacs setup -*- lexical-binding: t; -*-

;; ---------------------------------------
;; Start simple & predictable
;; ---------------------------------------
;; Reduce GC during startup, then raise for interactive use
(setq gc-cons-threshold 100000000   ;; 100 MB
      gc-cons-percentage 0.6)

(setq inhibit-startup-message t
      ring-bell-function 'ignore
      make-backup-files nil
      auto-save-default nil
      package-enable-at-startup nil
      frame-resize-pixelwise t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(setq display-line-numbers-type 'relative)

;; Optional: quiet native-comp warnings
(setq native-comp-async-report-warnings-errors 'silent)

;; ---------------------------------------
;; straight.el + use-package bootstrap
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

;; Configure straight.el
(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(require 'use-package)

;; Ensure core packages are installed
;; (straight-use-package 'rainbow-delimiters)
(straight-use-package 'which-key)
(straight-use-package 'magit)
(straight-use-package 'org)
(straight-use-package 'yaml-mode)
(straight-use-package 'dockerfile-mode)
(straight-use-package 'docker-compose-mode)

;; --- LSP + Corfu (use CAPF) ----------------------------------------
;; Make lsp-mode provide completion via completion-at-point (CAPF).
(setq lsp-completion-provider :capf)   ;; <— not :none

;; Do NOT use Company.
(use-package company :disabled t)

;; Corfu popup for CAPF
(use-package corfu
  :straight t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-auto-delay 0.0)
  (corfu-cycle t)
  (corfu-preselect 'first))

;; LSP client (built-in)
(use-package eglot
  :straight t
  :hook
  (python-mode . eglot-ensure)
  (python-ts-mode . eglot-ensure))

;; Start Eglot for your language(s)
(add-hook 'python-mode-hook #'eglot-ensure)     ;; adjust for your modes

;; Show docs/types in a help buffer with `K`
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "K") #'eldoc-doc-buffer))

;; Nice echo-area docs while you move the cursor
(setq eldoc-echo-area-use-multiline-p t
      eldoc-idle-delay 0.1)


;; Optional extra CAPF sources
(use-package cape :after corfu
  :init
  ;; Append CAPE sources so LSP (added by lsp-completion-mode) stays first
  (add-to-list 'completion-at-point-functions #'cape-file t)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev t))

;; Snippets for LSP (yasnippet)
(use-package yasnippet
  :init (yas-global-mode 1))

;; TAB cycles when menu is open
(with-eval-after-load 'corfu
  (define-key corfu-map (kbd "TAB") #'corfu-next)
  (define-key corfu-map (kbd "<tab>") #'corfu-next)
  (define-key corfu-map (kbd "S-TAB") #'corfu-previous)
  (define-key corfu-map (kbd "<backtab>") #'corfu-previous))

;; Make TAB trigger completion when no selection menu is visible
(define-key prog-mode-map (kbd "TAB") #'completion-at-point)
(define-key text-mode-map (kbd "TAB") #'completion-at-point)


;; ---------------------------------------
;; UI: theme, modeline, icons, org look
;; ---------------------------------------
(use-package doom-themes
  :straight t
  :init (load-theme 'doom-one t)
  :config (doom-themes-visual-bell-config))

(use-package all-the-icons
  :straight t
  :if (display-graphic-p)) ; M-x all-the-icons-install-fonts (once)

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1))

(use-package which-key
  :straight t
  :init (which-key-mode 1))

;;(use-package rainbow-delimiters
;;  :straight t
;;  :demand t
;;  :config
;;  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package org-modern
  :straight t
  :ensure t
  :hook (org-mode . org-modern-mode))

;; ---------------------------------------
;; Fuzzy finding: Vertico + Orderless + friends
;; ---------------------------------------
(use-package vertico
  :straight t
  :init (vertico-mode 1))

(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))
                                  (lsp-capf (styles orderless)))))

(use-package marginalia
  :straight t
  :init (marginalia-mode 1))

(use-package consult
  :straight t)
;; Handy search keys
(global-set-key (kbd "C-c s s") #'consult-line)
(global-set-key (kbd "C-c s g") #'consult-ripgrep)
(global-set-key (kbd "C-c s b") #'consult-buffer)
(global-set-key (kbd "C-c s f") #'consult-find)

;; ---------------------------------------
;; Projects (built-in project.el is enough)
;; ---------------------------------------
(setq project-switch-commands
      '((project-find-file "Find file")
        (project-find-dir "Find dir")
        (project-switch-to-buffer "Switch buffer")
        (project-dired "Dired")
        (consult-ripgrep "Ripgrep")))

;; ---------------------------------------
;; Evil (Vim) + Evil-collection
;; ---------------------------------------
(use-package evil
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil)
  :config
  (evil-mode 1))
(use-package evil-collection :after evil :ensure t :config (evil-collection-init))

;; ---------------------------------------
;; Git
;; ---------------------------------------
(use-package magit
  :straight t
  :ensure t
  :commands magit-status)
(global-set-key (kbd "C-c g s") #'magit-status)

;; ---------------------------------------
;; Org + Jupyter
;; ---------------------------------------
(use-package org
  :straight t
  :ensure t
  :defer t)
;; (use-package jupyter :after org :defer t)

;;((with-eval-after-load 'org
;;  (org-babel-do-load-languages
;;   'org-babel-load-languages
;;     (python . t)
;;     (emacs-lisp . t)))
  ;; Run code blocks without asking every time
;;  (setq org-confirm-babel-evaluate nil
;;        org-hide-emphasis-markers t
;;        org-ellipsis " ▾"))

;; ---------------------------------------
;; LSP + Python (pyright) + Flycheck
;; ---------------------------------------
(defun my/python-lsp-start ()
  "Ensure lsp-pyright is loaded, then start LSP for Python."
  (require 'lsp-pyright)
  (lsp-deferred))

(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook ((python-mode . my/python-lsp-start)
         (lsp-mode . lsp-completion-mode))
  :custom
  (lsp-auto-configure nil) ; don't auto-wire Company; we'll use Corfu/CAPF
  (lsp-keymap-prefix "C-c l")
  (lsp-enable-snippet t)
  (read-process-output-max (* 4 1024 1024))
  (lsp-idle-delay 0.40))

(use-package lsp-ui
  :straight t
  :after lsp-mode
  :commands lsp-ui-mode)

(use-package lsp-pyright
  :straight t
  :after lsp-mode
  :defer t)

(use-package flycheck
  :straight t
  :init (global-flycheck-mode 1))
;; Pin to Nix path so Emacs always finds the language server
(with-eval-after-load 'lsp-pyright
  (setq lsp-pyright-langserver-command "${pkgs.pyright}/bin/pyright-langserver"))

;; ---------------------------------------
;; Terminals / Env
;; ---------------------------------------
;;(use-package vterm
;;  :ensure t
;;  :bind (("C-c t" . vterm)))
;; (Optional) direnv if you use it: (use-package direnv :init (direnv-mode 1))
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "SPC t") #'vterm))  ;; SPC t opens vterm

;; ---------------------------------------
;; Docker / Compose / YAML / Makefile
;; ---------------------------------------
(use-package docker
  :straight t
  :ensure t
  :commands docker)

(use-package dockerfile-mode
  :straight t
  :ensure t
  :mode "Dockerfile\\'")

(use-package docker-compose-mode
  :straight t
  :ensure t
  :mode "docker-compose.*\\.ya?ml\\'")

(use-package yaml-mode
  :straight t
  :ensure t
  :mode "\\.ya?ml\\'")
(add-hook 'makefile-mode-hook (lambda () (setq indent-tabs-mode t))) ; Keep real TABs

;; ---------------------------------------
;; Ruff via uvx helpers (your requested commands)
;; ---------------------------------------
(defun my/project-root ()
  "Return current project root or `default-directory`."
  (or (when-let* ((proj (project-current)))
        (car (project-roots proj)))
      default-directory))

(defun my/uvx-run (args &optional use-project-root)
  "Run `uvx ARGS` via `compile`. If USE-PROJECT-ROOT, run from project root."
  (let* ((default-directory (if use-project-root (my/project-root) default-directory))
         (cmd (concat "uvx " args)))
    (compile cmd)))

(defun my/ruff-format-buffer ()
  "Format current file with `uvx ruff format`."
  (interactive)
  (unless buffer-file-name (user-error "Current buffer is not visiting a file"))
  (save-buffer)
  (my/uvx-run (format "ruff format %s" (shell-quote-argument buffer-file-name))))

(defun my/ruff-format-project ()
  "Format project with `uvx ruff format .`."
  (interactive)
  (my/uvx-run "ruff format ." t))

(defun my/ruff-fix-project ()
  "Auto-fix project with `uvx ruff check --fix .`."
  (interactive)
  (my/uvx-run "ruff check --fix ." t))

(global-set-key (kbd "C-c r b") #'my/ruff-format-buffer)
(global-set-key (kbd "C-c r f") #'my/ruff-format-project)
(global-set-key (kbd "C-c r x") #'my/ruff-fix-project)

;; ---------------------------------------
;; Quality-of-life
;; ---------------------------------------
;; Recent files
(recentf-mode 1)
(setq recentf-max-saved-items 500)

;; Save desktop/session
(desktop-save-mode 1)

;; Slightly smoother scrolling
(setq scroll-margin 6
      scroll-conservatively 101)

(provide 'init)
;;; init.el ends here

