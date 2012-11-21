;; init.el

; 言語を日本語にする
(set-language-environment 'Japanese)

; できるだけUTF−8とする
(prefer-coding-system 'utf-8-unix)

; 行数を左側に表示する
(global-linum-mode t)

; バックアップファイルを作らない
(setq make-backup-files nil)

;;起動時のスタートアップ画面を無効にする
(setq inhibit-startup-screen t)

;;起動時のフレームサイズを設定する
(setq initial-frame-alist
      (append
       (list
        '(width  . 90)
        '(height . 50))
       initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;;Delete と C-h を入れ替える
(keyboard-translate ?\C-h ?\C-?)
(keyboard-translate ?\C-? ?\C-h)

;;IMEを切替える
(global-set-key (kbd "C-o") 'toggle-input-method)

;; ビープ音を抑制する
(setq visible-bell t)

;;パーレンを強調表示する
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match-face nil
                    :background "#aaffff"
                    :underline nil
                    :weight 'extra-bold)
(setq kill-whole-line 1)
(column-number-mode 1)
(line-number-mode 1)
(which-function-mode 1)
(setq delete-auto-save-files t)

;; 字下げにはタブを使用せずにスペースを使う
(setq-default tab-width 4 indent-tabs-mode nil)

;;; ---------------------------------------------------------------------------
;;; マウスホイールで1行ずつスクロールするようにする
(setq mouse-wheel-progressive-speed nil)
(defun scroll-down-with-lines ()
  ""
  (interactive)
  (scroll-down 1))
(defun scroll-up-with-lines ()
  ""
  (interactive)
  (scroll-up 1))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [double-wheel-up] 'scroll-down-with-lines)
(global-set-key [triple-wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
(global-set-key [double-wheel-down] 'scroll-up-with-lines)
(global-set-key [triple-wheel-down] 'scroll-up-with-lines)
;; スクロールステップ1に設定
(setq scroll-step 1)

(global-set-key (kbd "C-c n f") 'new-frame)
(global-set-key (kbd "C-c d f") 'delete-frame)
(global-set-key (kbd "C-9") 'other-frame)

;;find-file 時に大文字と小文字を区別しない
(setq completion-ignore-case t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://d.hatena.ne.jp/kitokitoki/20100608/p2
;; バッファの削除と復元を手軽に行える，小さなコードを書きました。以前どこかで見
;; かけたものをスタックで書き直しました。以下の設定を dot.emacs に付け足せば，
;; C-x k でのバッファ削除時にyes-no 確認を行いません。削除したファイル名をプッシ
;; ュして保存しているので，C-x / でどんどん開き直せます。
;;
(require 'cl)

(defvar my-killed-file-name-list nil)

(defun my-push-killed-file-name-list ()
  (when (buffer-file-name)
    (push (expand-file-name (buffer-file-name)) my-killed-file-name-list)))

(defun my-pop-killed-file-name-list ()
  (interactive)
  (unless (null my-killed-file-name-list)
    (find-file (pop my-killed-file-name-list))))

(add-hook 'kill-buffer-hook 'my-push-killed-file-name-list)

(global-set-key "\C-xk" (lambda() (interactive)(kill-buffer (buffer-name))))
(global-set-key "\C-x/" 'my-pop-killed-file-name-list)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; C/C++ に関する設定
(defun my-c-mode-hook ()
  (c-set-style "ellemtel")

  ;; 名前空間中のインデントを無効にする
  (c-set-offset 'innamespace 0)
  
  ;;タブの代わりにスペースを使う
  ;; タブサイズを4にする
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-basic-offset tab-width)

  ;; 自動改行を有効にする
  (c-toggle-auto-state t)

  ;; コンパイル時は強制的に保存する
  (setq compilation-ask-about-save nil)
  
  ;;セミコロンで自動改行しない
  (setq c-hanging-semi&comma-criteria nil)

  (setq c-auto-newline t)

  ;; 空白の一括削除を有効にする
  (setq c-toggle-hungry-state t)

  ;; 自動改行する条件
  (setq c-hanging-braces-alist
        '(
          (class-open before after)
          (class-close before )
          (defun-open before)
          (defun-close before)
          (block-open before after)
          (block-close before after)
          )
        )
  
  (local-set-key (kbd "C-m") 'newline-and-indent)
;  (local-set-key (kbd "C-h") 'c-electric-backspace)
  (local-set-key (kbd "C-c c") 'compile)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; open *.h file in c++-mode
(setq auto-mode-alist (append
		       '(("\\.h$" . c++-mode))
		       auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ウィンドウに関する設定
(when window-system
  (cond
   ((<= emacs-major-version 21)
    (message "Emacs Major Version is less than 21"))
   
   ((=  emacs-major-version 22)
    (message "Emacs Major Version is 22"))

   ((>= emacs-major-version 23)
    (message "Emacs Major Version is 23 or more.")
    (let (my-font-height my-font my-font-ja my-font-size my-fontset my-font-kana)
      ;; ツールバーを非表示にする
      (tool-bar-mode 0)

      ;;OS と Emacs のバージョンによって使用するフォントを変更する
      (cond

       ;; Cocoa Emacs のとき
       ((eq window-system 'ns)
        (setq mac-allow-anti-aliasing t)
        (setq my-font-height 120)
        (setq my-font "Menlo")
        (setq my-font-kana "Mio W4")
        (setq my-font-ja "Hiragino Maru Gothic Pro")
        ))

      ;; フォントの設定を行う
      (cond
       (my-font
        (set-face-attribute 'default nil
                            :family my-font
                            :height my-font-height)))

      ;; 日本語の設定を行う
      (when my-font-ja
        (let ((fn (or my-fontset (frame-parameter nil 'font)))
              (rg "iso10646-1"))
          (set-fontset-font fn 'katakana-jisx0201 `(,my-font-kana . ,rg))
          (set-fontset-font fn 'japanese-jisx0208 `(,my-font-ja . ,rg))
          (set-fontset-font fn 'japanese-jisx0212 `(,my-font-ja . ,rg))
              )))
      )))

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
(add-to-list 'load-path "auto-complete-1.3.1/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
(ac-config-default)

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

