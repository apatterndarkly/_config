(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("07885feecd236e4ba3837e7ff15753d47694e1f9a8049400c114b3298285534e" "c3bcebe2117cbd3ab7e2ccb8536c6da089bf7efbdbac697e134205b5729ca358" "5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" "f747c4004e38bcdc131649a90325c00d246bb7dc73bc6ab6e0e7ab5489da8459" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "4e8d50bd0814a2f79ac9306d2860aac88eca1e1052f5061d650a58b8256663b4" "31dc824dd1bd213bbfc55dcbfd9b43dbd076a6c26c127f72015d1b32fb788330" "c38ca564fb26ae0414ed076b9a8462cdfbb1e20eb651001bfaa789e842fdbfdd" "ebbd4bbb0f017cb09f7a3b1363b83dfde0c5f4970cda2705419457366cd2de91" "d3a63c40fddcd2369b7465beca48ddd61fa8e980e9fa88adc52c3cfc78b2b352" "508eea8d6eb720b0d1d532bb682837803d35f602b03739836eb9a39622119c24" "3b69ddebc3b1386c63e70afa0eca90d1a775c52ad144d16df932400f3afe1c30" "ffa1f10eda4be15d8c6b441fd60ae3fb9f65aa03e0cd0955b59864cbad0baf8d" "9312a0692efc799e797c6689b3216c45d80e460184f666fffdb6dab65d8d4947" "7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" "062e6ec918ed89d5d9a342dbbefd99e8690c5514c6698a78fc25f259972e9242" "fc1275617f9c8d1c8351df9667d750a8e3da2658077cfdda2ca281a2ebc914e0" "8548580c2e217d73ffe03adf961f348a05d118849cd8b6deba327d78a8cdf758" default))
 '(package-selected-packages
   '(corfu treesit-auto odin-mode cider flycheck-clang-tidy flycheck flymake-lua nushell-ts-mode nushell-mode dap-mode lsp-ui lsp-mode powerline-evil smart-mode-line-atom-one-dark-theme vertico undo-fu smart-mode-line-powerline-theme jbeans-theme evil-terminal-cursor-changer evil-collection))
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

(defun comment-or-uncomment-line-or-region ()
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))

(setq evil-want-keybinding nil)
(use-package evil-leader
  :straight (:host github :repo "cofi/evil-leader")
	:config
	(global-evil-leader-mode)
	(evil-leader/set-leader "<SPC>")
	(evil-leader/set-key "/" 'comment-or-uncomment-line-or-region))

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
  (setq evil-search-module 'evil-search)
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

(straight-use-package 'vterm)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(setq treesit-language-source-alist
   '((hare https://git.d2evs.net/~ecs/tree-sitter-hare)))
(setq custom-hare-tsauto-config
      (make-treesit-auto-recipe
       :lang 'hare
       :ts-mode 'hare-ts-mode
       :remap '(hare-mode)
	   :requires 'hare
       :url "https://sr.ht/~amk/hare-ts-mode"
       :ext "\\.ha\\'"))
(add-to-list 'treesit-auto-recipe-list custom-hare-tsauto-config)

(add-to-list 'treesit-language-source-alist
  '(c3 https://github.com/c3lang/tree-sitter-c3))
(setq custom-c3-tsauto-config
      (make-treesit-auto-recipe
       :lang 'c3
       :ts-mode 'c3-ts-mode
	   :requires 'c3
       :url "https://github.com/c3lang/tree-sitter-c3"
       :ext "\\.c3\\'"))
(add-to-list 'treesit-auto-recipe-list custom-c3-tsauto-config)

(add-to-list 'treesit-language-source-alist
	'(go "https://github.com/tree-sitter/tree-sitter-go"))
(add-to-list 'treesit-language-source-alist
	'(gomod "https://github.com/camdencheek/tree-sitter-go-mod"))

(add-to-list 'treesit-language-source-alist
	'(c "https://github.com/tree-sitter/tree-sitter-c"))
(setq custom-c-tsauto-config
      (make-treesit-auto-recipe
       :lang 'c
       :ts-mode 'c-ts-mode
       :remap '(c-mode)
	   :requires 'c
       :ext "\\.c\\'"))
(add-to-list 'treesit-auto-recipe-list custom-c-tsauto-config)

(add-to-list 'treesit-language-source-alist
	'(cpp "https://github.com/tree-sitter/tree-sitter-cpp"))
(setq custom-cpp-tsauto-config
      (make-treesit-auto-recipe
       :lang 'cpp
       :ts-mode 'cpp-ts-mode
       :remap '(cpp-mode)
	   :requires 'cpp
       :ext "\\.cpp\\'"))
(add-to-list 'treesit-auto-recipe-list custom-cpp-tsauto-config)

(add-to-list 'treesit-language-source-alist
	'(elvish "https://github.com/elves/tree-sitter-elvish"))
(setq custom-elvish-tsauto-config
      (make-treesit-auto-recipe
       :lang 'elvish
       :ts-mode 'elvish-ts-mode
       :remap '(elvish-mode)
	   :requires 'elvish
       :ext "\\.elv\\'"))
(add-to-list 'treesit-auto-recipe-list custom-elvish-tsauto-config)

(add-to-list 'treesit-language-source-alist
  '(elm "https://github.com/elm-tooling/tree-sitter-elm"))
(setq custom-elm-tsauto-config
      (make-treesit-auto-recipe
       :lang 'elm
       :ts-mode 'elm-ts-mode
       :remap '(elm-mode)
	   :requires 'elm
       :ext "\\.elm\\'"))
(add-to-list 'treesit-auto-recipe-list custom-elm-tsauto-config)

(add-to-list 'treesit-language-source-alist
  '(rust "https://github.com/tree-sitter/tree-sitter-rust"))
(setq custom-rust-tsauto-config
      (make-treesit-auto-recipe
       :lang 'rust
       :ts-mode 'rust-ts-mode
       :remap '(rust-mode)
	   :requires 'rust
       :ext "\\.rs\\'"))
(add-to-list 'treesit-auto-recipe-list custom-rust-tsauto-config)

(add-to-list 'treesit-language-source-alist
  '(lua "https://github.com/tree-sitter-grammars/tree-sitter-lua"))
(setq custom-lua-tsauto-config
      (make-treesit-auto-recipe
       :lang 'lua
       :ts-mode 'lua-ts-mode
       :remap '(lua-mode)
	   :requires 'lua
       :ext "\\.lua\\'"))
(add-to-list 'treesit-auto-recipe-list custom-lua-tsauto-config)

(add-to-list 'treesit-language-source-alist
  '(julia "https://github.com/tree-sitter/tree-sitter-julia"))
(setq custom-julia-tsauto-config
      (make-treesit-auto-recipe
       :lang 'julia
       :ts-mode 'julia-ts-mode
       :remap '(julia-mode)
	   :requires 'julia
       :ext "\\.julia\\'"))
(add-to-list 'treesit-auto-recipe-list custom-julia-tsauto-config)

(add-to-list 'treesit-language-source-alist
  '(ruby "https://github.com/tree-sitter/tree-sitter-julia"))
(setq custom-ruby-tsauto-config
      (make-treesit-auto-recipe
       :lang 'ruby
       :ts-mode 'ruby-ts-mode
       :remap '(enh-ruby-mode)
	   :requires 'ruby
       :ext "\\.ruby\\'"))
(add-to-list 'treesit-auto-recipe-list custom-ruby-tsauto-config)

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

(straight-use-package
 '(hare-mode :type git :repo "https://git.sr.ht/~laumann/hare-mode"
   :mode ("\\.ha\\'" . hare-mode)
   :hook (hare-mode . eglot)))

(straight-use-package
 '(terra-mode :type git :host github :repo "terralang/terra-mode"
   :mode ("\\.t\\'" . terra-mode)
   :hook (terra-mode . eglot)))

(straight-use-package
 '(elvish-mode :type git :host github :repo "ALSchwalm/elvish-mode"
   :mode ("\\.elv\\'" . elvish-mode)
   :hook (elvish-mode . eglot)))

(straight-use-package
 '(elm-mode :type git :host github :repo "jcollard/elm-mode"
   :mode ("\\.elm\\'" . elm-mode)
   :hook ((elm-mode . eglot) (elm-mode . elm-format-on-save-mode))
   :init (setq elm-sort-imports-on-save t)))

(straight-use-package
'(lua-mode :type git :host github :repo "immerrr/lua-mode"
			:mode ("\\.lua\\'" . lua-mode)
			:hook (lua-mode . eglot)))

(straight-use-package
 '(rust-mode :type git :host github :repo "rust-lang/rust-mode"
   :mode ("\\.rs\\'" . rust-mode)))

(setq rustic-lsp-client 'eglot)
(straight-use-package
  '(rustic :type git :host github :repo "emacs-rustic/rustic"))
(with-eval-after-load 'rust-mode
  (require 'rustic nil t))

(straight-use-package
 '(julia-mode :mode ("\\.jl\\'" . julia-mode)))
(straight-use-package
 '(julia-repl :hook (julia-mode . julia-repl-mode)
  ;; :init
  ;; (setenv "JULIA_NUM_THREADS" "8")
  ;; :config
  ;; ;; Set the terminal backend
  ;; (julia-repl-set-terminal-backend 'vterm)
  ;; ;; Keybindings for quickly sending code to the REPL
  ;; (define-key julia-repl-mode-map (kbd "<C-RET>") 'my/julia-repl-send-cell)
  ;; (define-key julia-repl-mode-map (kbd "<M-RET>") 'julia-repl-send-line)
  ;; (define-key julia-repl-mode-map (kbd "<S-return>") 'julia-repl-send-buffer))
))
;; (defun my/julia-repl-send-cell() 
;;   ;; "Send the current julia cell (delimited by ###) to the julia shell"
;;   (interactive)
;;   (save-excursion (setq cell-begin (if (re-search-backward "^###" nil t) (point) (point-min))))
;;   (save-excursion (setq cell-end (if (re-search-forward "^###" nil t) (point) (point-max))))
;;   (set-mark cell-begin)
;;   (goto-char cell-end)
;;   (julia-repl-send-region-or-line)
;;   (next-line))
;; ;; Allow the use of evil jump list C-o to jump back to where we were before executing the cell
;; (evil-add-command-properties #'my/julia-repl-send-cell :jump t)

(straight-use-package
 '(enh-ruby-mode :type git :host github :repo "zenspider/enhanced-ruby-mode"
   :mode
   ("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))) 

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
  (add-to-list 'eglot-server-programs
			   '(c3-mode . ("c3lsp")))
  (add-to-list 'eglot-server-programs
			   '(go-mode . ("gopls")))
  (add-to-list 'eglot-server-programs
			   '(elvish-mode . ("elvish" "-lsp")))
  (add-to-list 'eglot-server-programs
			   '(elm-mode . ("elm-language-server")))
  (add-to-list 'eglot-server-programs
			   '(rust-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs
			   '(enh-ruby-mode . ("ruby-lsp")))
  ;; (add-to-list 'eglot-server-programs
  ;; 			   '(julia-mode . ("lsp-julia")))
  :hook
  ((odin-mode . eglot) (lua-mode . eglot) (nushell-mode . eglot)
   (v-mode . eglot) (c3-mode . eglot) (elvish-mode . eglot)
   (elm-mode . eglot) (rust-mode . eglot) (enh-ruby-mode . eglot)
;; (julia-mode . eglot)
 ))

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

;;(use-package jbeans-theme
;;  :config
;;  (load-theme 'jbeans))
;;(use-package ujelly-theme
;;  :config
;;  (load-theme 'ujelly))
;;(use-package darktooth-theme
;;  :config
;;  (load-theme 'darktooth))
;;(use-package seti-theme
;;  :config
;;  (load-theme 'seti))
(use-package timu-spacegrey-theme
  :config
  (load-theme 'timu-spacegrey))
;;(use-package jazz-theme
;;  :config
;;  (load-theme 'jazz))
;;(use-package zen-and-art-theme
;;  :config
;;  (load-theme 'zen-and-art))
;;(use-package klere-theme
;;  :config
;;  (load-theme 'klere))
;;(use-package naquadah-theme
;;  :config
;;  (load-theme 'naquadah))
;;(use-package mustard-theme
;;  :config
;;  (load-theme 'mustard))
;;(use-package gruvbox-theme
;;  :config
;;  (load-theme 'gruvbox))
;(use-package yoshi-theme
;  :config
;  (load-theme 'yoshi))
;;(use-package twilight-theme
;;  :config
;;  (load-theme 'twilight))
;;(use-package liso-theme
;;  :config
;;  (load-theme 'liso))

(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

;;(use-package timu-rouge-theme
;;  :config
;;  (load-theme 'timu-rouge))
;;(use-package tron-legacy-theme
;;  :config
;;  (setq tron-legacy-theme-vivid-cursor t)
;;  (load-theme 'tron-legacy t))
;;(use-package hemisu-theme
;;  :config
;; (load-theme 'hemisu-dark t))
;;(use-package soothe-theme
;;  :config
;;  (load-theme 'soothe))
;;(straight-use-package
;;  '(ld-dark-theme :type git :host github :repo "emacs-jp/replace-colorthemes"
;;  :config
;;  (load-theme 'ld-dark)))
;;(straight-use-package
;; '(emacs-color-themes :type git :host github :repo "owainlewis/emacs-color-themes"
;;  :config
;;  (load-theme 'hickey))) ;; brin dorsey fogus graham granger hickey junio mccarthy
                           ;; odersky ritchie spolsky wilson [sublime-themes]
