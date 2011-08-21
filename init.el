;; init.el

;;起動時のスタートアップ画面を無効にする
(setq inhibit-startup-screen t)

;;起動時のフレームサイズを設定する
(setq initial-frame-alist
      (append
       (list
        '(width  . 45)
        '(height . 30))
       initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;;ウィンドウに関する設定
(if window-system
    (progn
      (tool-bar-mode nil)
      (set-scroll-bar-mode 'right)))

;;Delete と C-h を入れ替える
(keyboard-translate ?\C-h ?\C-?)
(keyboard-translate ?\C-? ?\C-h)

;;IMEを切替える
(global-set-key (kbd "C-o") 'toggle-input-method)

;;パーレンを強調表示する
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match-face nil
                    :background "#aaffff"
                    :foreground nil
                    :underline  nil
                    :weight 'extra-bold)
(setq kill-whole-line t)
(column-number-mode t)
(line-number-mode t)
(which-function-mode t)
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
(global-set-key [wheel-up] 'scroll-up-with-lines)
(global-set-key [double-wheel-up] 'scroll-up-with-lines)
(global-set-key [triple-wheel-up] 'scroll-up-with-lines)
(global-set-key [wheel-down] 'scroll-down-with-lines)
(global-set-key [double-wheel-down] 'scroll-down-with-lines)
(global-set-key [triple-wheel-down] 'scroll-down-with-lines)
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

  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key "\C-h" 'c-electric-backspace)
  (local-set-key (kbd "C-c C-c") 'compile))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;;open *.h file in c++-mode
(setq auto-mode-alist (append
		       '(("\\.h$" . c++-mode))
		       auto-mode-alist))
