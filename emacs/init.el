(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("062e6ec918ed89d5d9a342dbbefd99e8690c5514c6698a78fc25f259972e9242" "fc1275617f9c8d1c8351df9667d750a8e3da2658077cfdda2ca281a2ebc914e0" "8548580c2e217d73ffe03adf961f348a05d118849cd8b6deba327d78a8cdf758" default))
 '(package-selected-packages
   '(lua-mode corfu treesit-auto odin-mode cider flycheck-clang-tidy flycheck flymake-lua nushell-ts-mode nushell-mode dap-mode lsp-ui lsp-mode powerline-evil smart-mode-line-atom-one-dark-theme vertico undo-fu smart-mode-line-powerline-theme jbeans-theme evil-terminal-cursor-changer evil-collection))
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq package-archives 
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))
(add-to-list 'load-path "/Users/aya/local/bin")

(setq straight-use-package-by-default t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(eval-when-compile (require 'use-package))

(setq evil-want-keybinding nil)
(use-package evil-leader
  :straight (:host github :repo "cofi/evil-leader")
	:config
	(global-evil-leader-mode)
	(evil-leader/set-leader "<SPC>"))

(setq evil-want-keybinding nil)
(straight-use-package
 '(evil-terminal-cursor-changer :type git :host github :repo "7696122/evil-terminal-cursor-changer"))
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate))

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-motion-state-cursor 'box)
  (setq evil-visual-state-cursor 'box)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'bar)
  (setq evil-emacs-state-cursor  'hbar)
  :config 
  (evil-mode 1))


(use-package evil-collection
  :after evil
  :config
  :custom (evil-collection-setup-minibuffer t)
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package neotree
 :straight (:host github :repo "jaypei/emacs-neotree")
  :config
	(evil-leader/set-key
	"b"  'neotree-toggle
	"n"  'neotree-project-dir)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neotree-mode-hook
    (lambda ()
      (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
      (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
      (define-key evil-normal-state-local-map (kbd "z") 'neotree-stretch-toggle)
      (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
      (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
      (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
      (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
      (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
      (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)
      (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(use-package vertico
  :config
  (vertico-mode))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(straight-use-package 'reformatter)

(straight-use-package
 '(odin-mode :type git :host github :repo "mattt-b/odin-mode"
  :mode ("\\.odin\\'" . odin-mode)
  :hook (odin-mode . eglot)))

(straight-use-package
 '(nushell-mode :type git :host github :repo "mrkkrp/nushell-mode"
   :mode ("\\.nu\\'" . nushell-mode)
   :hook (nushell-mode . eglot)))

(straight-use-package
 '(v-mode :type git :host github :repo "damon-kwok/v-mode"
    :files ("tokens" "v-mode.el")
    :bind-keymap
    ("M-z" . v-menu)
    ("<f6>" . v-menu)
    ("C-c C-f" . v-format-buffer)
    :mode ("\\(\\.v?v\\|\\.vsh\\)$" . v-mode)
    :hook (v-mode . eglot)))

(straight-use-package
 '(zig-mode :type git :host github :repo "ziglang/zig-mode"
   :mode ("\\.zig\\'" . zig-mode)
   :hook (zig-mode . eglot)))

(if (>= emacs-major-version 28)
    (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
  (progn
    (defun colorize-compilation-buffer ()
      (let ((inhibit-read-only t))
        (ansi-color-apply-on-region compilation-filter-start (point))))
    (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs
			   '(odin-mode . ("ols")))
  (add-to-list 'eglot-server-programs
			   '(lua-mode . ("lua-language-server")))
  (add-to-list 'eglot-server-programs
			   '(nushell-mode . ("nuls")))
  (add-to-list 'eglot-server-programs
			   '(v-mode . ("v-analyzer")))
  (add-to-list 'eglot-server-programs
			   '(zig-mode . ("zls")))
  :hook
  ((odin-mode . eglot) (lua-mode . eglot) (nushell-mode . eglot) (v-mode . eglot)))

;; TAB-only configuration
(use-package corfu
  :custom
  (corfu-auto t)               ;; Enable auto completion
  (corfu-preselect 'directory) ;; Select the first candidate, except for directories
  :init
  (global-corfu-mode)
  :config
  ;; Free the RET key for less intrusive behavior.
  ;; Option 1: Unbind RET completely
  ;; (keymap-unset corfu-map "RET")
  ;; Option 2: Use RET only in shell modes
  (keymap-set
   corfu-map "RET" `( menu-item "" nil
	:filter
	,(lambda (&optional _)
	(and (derived-mode-p 'eshell-mode 'comint-mode)
		#'corfu-send)))))

(straight-use-package
 '(corfu-terminal
   :type git
   :repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))
(unless (display-graphic-p) (corfu-terminal-mode +1))

(straight-use-package 'smart-mode-line)
(setq sml/theme 'dark)
(sml/setup)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(menu-bar-mode 0)
(setq-default tab-width 4)

(use-package jbeans-theme
  :config
  (load-theme 'jbeans))
