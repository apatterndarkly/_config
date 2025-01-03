(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 '("31dc824dd1bd213bbfc55dcbfd9b43dbd076a6c26c127f72015d1b32fb788330" "fc1275617f9c8d1c8351df9667d750a8e3da2658077cfdda2ca281a2ebc914e0" default))
 '(ignored-local-variable-values
	 '((vc-default-patch-addressee . "bug-gnu-emacs@gnu.org")
		 (etags-regen-ignores "test/manual/etags/")
		 (etags-regen-regexp-alist
			(("c" "objc")
			 "/[ \11]*DEFVAR_[A-Z_ \11(]+\"\\([^\"]+\\)\"/\\1/" "/[ \11]*DEFVAR_[A-Z_ \11(]+\"[^\"]+\",[ \11]\\([A-Za-z0-9_]+\\)/\\1/"))))
 '(package-selected-packages
	 '(corfu treesit-auto odin-mode cider flycheck-clang-tidy flycheck flymake-lua nushell-ts-mode nushell-mode dap-mode lsp-ui lsp-mode powerline-evil smart-mode-line-atom-one-dark-theme vertico undo-fu smart-mode-line-powerline-theme jbeans-theme evil-terminal-cursor-changer evil-collection))
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq warning-minimum-level :error)
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

(use-package vterm-toggle
  :straight (:type git :host github :repo "jixiuf/vterm-toggle")
	:config
	(setq vterm-toggle-fullscreen-p nil)
	(add-to-list 'display-buffer-alist
							 '((lambda (buffer-or-name _)
									 (let ((buffer (get-buffer buffer-or-name)))
										 (with-current-buffer buffer
											 (or (equal major-mode 'vterm-mode)
													 (string-prefix-p vterm-buffer-name
																						(buffer-name buffer))))))
								 (display-buffer-reuse-window display-buffer-at-bottom)
								 (display-buffer-reuse-window display-buffer-in-direction)
								 (direction . bottom)
								 (dedicated . t)
								 (reusable-framesk. visible)
								 (window-height . 0.3))))


(setq evil-want-keybinding nil)
(use-package evil-leader
	:straight (:host github :repo "cofi/evil-leader")
	:config
	(global-evil-leader-mode)
	(evil-leader/set-leader "<SPC>")
	(evil-leader/set-key "/" 'comment-or-uncomment-line-or-region)
	(evil-leader/set-key "v" 'vterm-toggle-cd)
	(evil-leader/set-key "c" 'calendar)
	(evil-leader/set-key "o" 'org-mode)
	(evil-leader/set-key "e" 'eval-last-sexp))

(setq evil-want-keybinding nil)
(straight-use-package
 '(evil-terminal-cursor-changer
	 :type git
	 :host github
	 :repo "7696122/evil-terminal-cursor-changer"))

(unless (display-graphic-p)
	(require 'evil-terminal-cursor-changer)
	(evil-terminal-cursor-changer-activate))

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
			;; find a better way to do this. map? each?
      (define-key evil-normal-state-local-map
									(kbd "q") 'neotree-hide)
      (define-key evil-normal-state-local-map
									(kbd "I") 'neotree-hidden-file-toggle)
      (define-key evil-normal-state-local-map
									(kbd "z") 'neotree-stretch-toggle)
      (define-key evil-normal-state-local-map
									(kbd "R") 'neotree-refresh)
      (define-key evil-normal-state-local-map
									(kbd "m") 'neotree-rename-node)
      (define-key evil-normal-state-local-map
									(kbd "c") 'neotree-create-node)
      (define-key evil-normal-state-local-map
									(kbd "d") 'neotree-delete-node)
      (define-key evil-normal-state-local-map
									(kbd "s") 'neotree-enter-vertical-split)
      (define-key evil-normal-state-local-map
									(kbd "S") 'neotree-enter-horizontal-split)
      (define-key evil-normal-state-local-map
									(kbd "RET") 'neotree-enter))))

(use-package vertico :config (vertico-mode))
(straight-use-package 'vterm)
(straight-use-package 'reformatter)
(straight-use-package '(magit :type git :host github :repo "magit/magit"))

(use-package app-launcher
  :straight '(app-launcher :host github :repo "SebastienWae/app-launcher"))

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
			 :url "https://git.sr.ht/~amk/hare-ts-mode"
			 :ext "\\.ha\\'"))
(add-to-list 'treesit-auto-recipe-list custom-hare-tsauto-config)

(straight-use-package
 '(nushell-ts-babel :type git :host github :repo "herbertjones/nushell-ts-babel"))
(setq treesit-language-source-alist
			'((nu https://github.com/nushell/tree-sitter-nu)))
(use-package nushell-ts-mode
  :straight (nushell-ts-mode :type git :host github :repo "herbertjones/nushell-ts-mode")
  :config
	(require 'nushell-ts-babel)
  (defun hfj/nushell/mode-hook ()
    (electric-pair-local-mode 1)
    (electric-indent-local-mode 1))
  (add-hook 'nushell-ts-mode-hook 'hfj/nushell/mode-hook))

(add-to-list 'treesit-language-source-alist
						 '(c3 "https://github.com/c3lang/tree-sitter-c3"))
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
						 '(ruby "https://github.com/tree-sitter/tree-sitter-ruby"))
(setq custom-ruby-tsauto-config
      (make-treesit-auto-recipe
       :lang 'ruby
       :ts-mode 'ruby-ts-mode
       :remap '(enh-ruby-mode)
			 :requires 'ruby
       :ext "\\.ruby\\'"))
(add-to-list 'treesit-auto-recipe-list custom-ruby-tsauto-config)

(add-to-list 'treesit-language-source-alist
						 '(fennel "https://github.com/alexmozaidze/tree-sitter-fennel"))
(setq custom-fennel-tsauto-config
      (make-treesit-auto-recipe
       :lang 'fennel
       :ts-mode 'fennel-ts-mode
       :remap '(fennel-mode)
			 :requires 'fennel
       :ext "\\.fnl\\|.fennelrc$"))
(add-to-list 'treesit-auto-recipe-list custom-fennel-tsauto-config)

(add-to-list 'treesit-language-source-alist
						 '(scheme "https://github.com/codepod-io/tree-sitter-scheme"))
(setq custom-scheme-tsauto-config
      (make-treesit-auto-recipe
       :lang 'scheme
       :ts-mode 'scheme-ts-mode
       :remap '(scheme-mode)
			 :requires 'scheme
       :ext "\\.scm$"))
(add-to-list 'treesit-auto-recipe-list custom-fennel-tsauto-config)

(use-package odin-mode
  :straight (:type git :host github :repo "mattt-b/odin-mode")
  :mode ("\\.odin\\'" . odin-mode)
  :hook (odin-mode . eglot))

(use-package :nushell-mode
	:straight (:type git :host github :repo "mrkkrp/nushell-mode")
	:mode ("\\.nu\\'" . nushell-mode)
	:hook (nushell-mode . eglot))

(use-package v-mode
	:straight
	(:type git :host github :repo "damon-kwok/v-mode" :files ("tokens" "v-mode.el"))
	:bind-keymap
	("M-z" . v-menu)
	("<f6>" . v-menu)
	("C-c C-f" . v-format-buffer)
	:mode ("\\(\\.v?v\\|\\.vsh\\)$" . v-mode)
	:hook (v-mode . eglot))

(use-package zig-mode
  :straight (:type git :host github :repo "ziglang/zig-mode")
  :mode ("\\.\\(zig\\|zon\\)\\'" . zig-mode)
  :hook (zig-mode . eglot))

(if (>= emacs-major-version 28)
    (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
  (progn
    (defun colorize-compilation-buffer ()
      (let ((inhibit-read-only t))
        (ansi-color-apply-on-region compilation-filter-start (point))))
    (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)))

(use-package hare-mode
  :straight (:type git :repo "https://git.sr.ht/~laumann/hare-mode")
  :mode ("\\.ha\\'" . hare-mode)
  :hook (hare-mode . eglot))

(use-package terra-mode
	:straight (:type git :host github :repo "terralang/terra-mode")
  :mode ("\\.t\\'" . terra-mode)
  :hook (terra-mode . eglot))

(use-package elm-mode
	:straight (:type git :host github :repo "jcollard/elm-mode")
  :mode ("\\.elm\\'" . elm-mode)
  :hook ((elm-mode . eglot) (elm-mode . elm-format-on-save-mode))
  :init (setq elm-sort-imports-on-save t))

(use-package lua-mode
	:straight (:type git :host github :repo "immerrr/lua-mode")
	:mode ("\\.lua\\'" . lua-mode)
	:hook (lua-mode . eglot))

(use-package rust-mode
	:straight (:type git :host github :repo "rust-lang/rust-mode")
  :mode ("\\.rs\\'" . rust-mode))

(setq rustic-lsp-client 'eglot)
(use-package rustic
  :straight (:type git :host github :repo "emacs-rustic/rustic"))
(with-eval-after-load 'rust-mode
  (require 'rustic nil t))

(use-package enh-ruby-mode
	:straight (:type git :host github :repo "zenspider/enhanced-ruby-mode")
  :mode
  ("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

(use-package fennel-mode
	:straight (:type git :host github :repo "emacsmirror/fennel-mode")
	:mode ("\\.fnl\\|.fennelrc$" . fennel-mode)
	:hook (fennel-mode . eglot))

(use-package kdl-mode
	:straight (:type git :host github :repo "apatterndarkly/kdl-mode")
	:mode ("\\.kdl$" . kdl-mode))

(use-package gambit
	:straight
	(:host github
				 :repo "gambit/gambit"
				 :files ("misc/gambit.el")
				 :branch "master")
	:mode ("\\.$" . gambit-mode))

(progn
	(defvar *gerbil-path*
		(shell-command-to-string "gxi -e '(display (path-expand \"~~\"))'\
			-e '(flush-output-port)'"))

	(use-package gerbil-mode
		:straight
		(:host github
					 :repo "mighty-gerbils/gerbil"
					 :files ("etc/gerbil-mode.el")
					 :branch "master")
		:defer t
		:mode (("\\.ss\\'"  . gerbil-mode)
					 ("\\.pkg\\'" . gerbil-mode))
		:bind (:map comint-mode-map
								(("C-S-n" . comint-next-input)
								 ("C-S-p" . comint-previous-input)
								 ("C-S-l" . clear-comint-buffer))
								:map gerbil-mode-map
								(("C-S-l" . clear-comint-buffer)))
    ;; :init
    ;; (autoload 'gerbil-mode
    ;;   (expand-file-name "share/emacs/site-lisp/gerbil-mode.el" *gerbil-path*)
    ;; "Gerbil editing mode." t)
    :hook
    ((gerbil-mode-hook . linum-mode)
		 (gerbil-mode . eglot)
     (inferior-scheme-mode-hook . gambit-inferior-mode))
    :config
    (require 'gambit)
    ;; (setf scheme-program-name (expand-file-name "bin/gxi" *gerbil-path*))
    ;; (let ((tags (locate-dominating-file default-directory "TAGS")))
    ;;   (when tags (visit-tags-table tags)))
    ;; (let ((tags (expand-file-name "src/TAGS" *gerbil-path*)))
    ;;   (when (file-exists-p tags) (visit-tags-table tags)))

    (when (package-installed-p 'smartparens)
      (sp-pair "'" nil :actions :rem)
      (sp-pair "`" nil :actions :rem))

    (defun clear-comint-buffer ()
      (interactive)
      (with-current-buffer "*scheme*"
				(let ((comint-buffer-maximum-size 0))
          (comint-truncate-buffer)))))

  (defun gerbil-setup-buffers ()
    "Change current buffer mode to gerbil-mode and start a REPL"
    (interactive)
    (gerbil-mode)
    (split-window-right)
    (shrink-window-horizontally 2)
    (let ((buf (buffer-name)))
      (other-window 1)
      (run-scheme "gxi")
      (switch-to-buffer-other-window "*scheme*" nil)
      (switch-to-buffer buf)))
  (global-set-key (kbd "C-c C-g") 'gerbil-setup-buffers))

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs
							 '(odin-mode . ("ols")))
  (add-to-list 'eglot-server-programs
							 '(lua-mode . ("lua-language-server")))
  (add-to-list 'eglot-server-programs
							 '(nushell-mode . ("nu" "--lsp")))
  (add-to-list 'eglot-server-programs
							 '(v-mode . ("v-analyzer")))
  (add-to-list 'eglot-server-programs
							 '(zig-mode . ("zls")))
  (add-to-list 'eglot-server-programs
							 '(c3-mode . ("c3lsp")))
  (add-to-list 'eglot-server-programs
							 '(go-mode . ("gopls")))
  (add-to-list 'eglot-server-programs
							 '(elm-mode . ("elm-language-server")))
  (add-to-list 'eglot-server-programs
							 '(rust-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs
							 '(enh-ruby-mode . ("ruby-lsp")))
  (add-to-list 'eglot-server-programs
							 '(fennel-mode . ("fennel-ls")))
	:hook
	((odin-mode . eglot) (lua-mode . eglot) (nushell-mode . eglot) (v-mode . eglot)
	 (zig-mode . eglot) (c3-mode . eglot) (go-mode . eglot) (elm-mode . eglot)
	 (rust-mode . eglot) (enh-ruby-mode . eglot) (fennel-mode . eglot)))

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
(setq-default column-number-mode t)
(display-time-mode t)
(setq sml/theme 'dark)
(sml/setup)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(menu-bar-mode 0)
(setq-default tab-width 2)
(setq-default display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(set-face-attribute 'fill-column-indicator nil :foreground "black")
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package timu-spacegrey-theme
	:config
	(load-theme 'timu-spacegrey))

(defun set-background-for-terminal (&optional frame)
	(or frame (setq frame (selected-frame)))
	"unsets the background color in terminal mode"
	(unless (display-graphic-p frame)
		(set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

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
