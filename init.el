;; init.el
(add-to-list 'load-path "~/.emacs.d/elpa/init-loader-20130218.1210/")
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits/")

;; package.el に関する設定
(require 'package)

; パッケージアーカイブを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

; 初期化
(package-initialize)

; melpa.el
(require 'melpa)

;; anything.el
(add-to-list 'load-path "~/.emacs.d/elpa/anything-1.287/")
(require 'anything)
(require 'anything-config)
(global-set-key (kbd "C-x b") 'anything-for-files)

;;; auto-complete mode の設定
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.3.1/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
(ac-config-default)

;;; magit の設定
(add-to-list 'load-path "~/.emacs.d/elpa/magit-20130611.2010")
(require 'magit)

;; Enable LLVM Mode
(add-to-list 'load-path "~/.emacs.d")
(require 'llvm-mode)

;; auto-async-byte-compile
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; (add-to-list 'ac-dictionary-directories (concat ac-dir "ac-dict/"))
;; (require 'auto-complete-clang)
;; (defun my-ac-cc-mode-setup ()
;;   (setq ac-clang-prefix-header "stdafx.pch")
;;   (setq ac-auto-start nil)
;;   (setq ac-clang-flags '("-w" "-ferror-limit" "1"))
;;   (setq ac-sources (append '(ac-source-clang
;;                              ac-source-yasnippet
;;                              ac-source-gtags)
;;                            ac-sources)))
;; (defun my-ac-config ()
;;   (global-set-key (kbd "M-/") 'ac-start)
;;   (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
;;   (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
;;   (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
;;   (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;   (global-auto-complete-mode t))

;; (my-ac-config)

;; 全角スペースとタブを目立たせる
(require 'whitespace)
;; space-markとtab-mark、それからspacesとtrailingを対象とする
(setq whitespace-style '(space-mark tab-mark face spaces trailing))
(setq whitespace-display-mappings
      '(
        ;; (space-mark   ?\     [?\u00B7]     [?.]) ; space - centered dot
        (space-mark   ?\xA0  [?\u00A4]     [?_]) ; hard space - currency
        (space-mark   ?\x8A0 [?\x8A4]      [?_]) ; hard space - currency
        (space-mark   ?\x920 [?\x924]      [?_]) ; hard space - currency
        (space-mark   ?\xE20 [?\xE24]      [?_]) ; hard space - currency
        (space-mark   ?\xF20 [?\xF24]      [?_]) ; hard space - currency
        (space-mark ?\u3000 [?\u25a1] [?_ ?_]) ; full-width-space - square
        ;; NEWLINE is displayed using the face `whitespace-newline'
        ;; (newline-mark ?\n    [?$ ?\n])  ; eol - dollar sign
        ;; (newline-mark ?\n    [?\u21B5 ?\n] [?$ ?\n]); eol - downwards arrow
        ;; (newline-mark ?\n    [?\u00B6 ?\n] [?$ ?\n]); eol - pilcrow
        ;; (newline-mark ?\n    [?\x8AF ?\n]  [?$ ?\n]); eol - overscore
        ;; (newline-mark ?\n    [?\x8AC ?\n]  [?$ ?\n]); eol - negation
        ;; (newline-mark ?\n    [?\x8B0 ?\n]  [?$ ?\n]); eol - grade
        ;;
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t]) ; tab - left quote mark
        ))
;; whitespace-spaceの定義を全角スペースにし、色をつけて目立たせる
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-space "cyan")
(set-face-background 'whitespace-space 'nil)
;; whitespace-trailingを色つきアンダーラインで目立たせる
(set-face-underline  'whitespace-trailing t)
(set-face-foreground 'whitespace-trailing "cyan")
(set-face-background 'whitespace-trailing 'nil)
(global-whitespace-mode 1)
