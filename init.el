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

