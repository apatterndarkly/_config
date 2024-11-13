(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fc1275617f9c8d1c8351df9667d750a8e3da2658077cfdda2ca281a2ebc914e0" "8548580c2e217d73ffe03adf961f348a05d118849cd8b6deba327d78a8cdf758" default))
 '(package-selected-packages
   '(odin-mode cider flycheck-clang-tidy flycheck flymake-lua nushell-ts-mode nushell-mode dap-mode lsp-ui lsp-mode powerline-evil smart-mode-line-atom-one-dark-theme vertico undo-fu smart-mode-line-powerline-theme jbeans-theme evil-terminal-cursor-changer evil-collection))
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

(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

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
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(menu-bar-mode 0)

(use-package vertico
  :config
  (vertico-mode))

(add-to-list 'load-path "/Users/aya/local/bin")
(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '(odin-mode . ("ols")))
  :hook
  ((odin-mode . eglot-ensure)))
(use-package odin-mode
  :load-path "locals/"
  :mode ("\\.odin\\'" . odin-mode)
  :hook (odin-mode . eglot))
(add-hook 'odin-mode-hook 'eglot-ensure)

(use-package jbeans-theme
  :config
  (load-theme 'jbeans))

(setq sml/theme 'dark)
(sml/setup)
