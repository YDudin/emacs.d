(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa"."http://melpa.milkbox.net/packages/") t)
(add-to-list 'load-path "~/Emacs/neotree")

(require 'expand-region)
(require 'neotree)
(require 'mark-more-like-this)

;;syntax check for ruby
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;;(defvar my-map (make-keymap) "my prog keys")

(when (window-system)
  (tool-bar-mode -1))

;; mark-multiple shortcuts
(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-*") 'mark-all-like-this)

;; multiple cursors shortcut
(global-set-key (kbd "C-c m") 'mc/mark-all-like-this)

;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-`") 'browse-kill-ring)
(global-set-key [f12] 'neotree-toggle)

;; Ruby shell
(global-set-key (kbd "C-c r r") 'inf-ruby)

;;(set-frame-font "Source Code Pro for Powerline-14")
(set-face-attribute 'default nil :height 140)
(global-visual-line-mode t)
(delete-selection-mode t)
(blink-cursor-mode t)
(show-paren-mode t)

(setq make-backup-file nil)
(setq auto-save-default nil)
(setq inhibit-startup-message t)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(fset 'yes-or-no-p 'y-or-n-p)

;; ido-mode
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

;; ace-jump-mode
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; linum mode
;;(linum-mode 1)
(global-linum-mode 1)

;;(define-minor-mode my-keys-prog-mode
;;  "A minor mode for my custom keys while programming"
;;  t " prog-keys" 'my-map)

;;(my-keys-prog-mode t)

;; All modes
(require 'saveplace)
(setq save-place-file(concat user-emacs-directory "saveplace.el"))
(setq-default save-place t)

(defun select-current-line()
  "Selects the current line"
  (interactive)
  (end-of-line)
  (push-mark (line-beginning-position) nil t))
(global-set-key (kbd "M-l") 'select-current-line)

;; Programming mode
(electric-indent-mode t)

(require 'auto-complete-config)
(ac-config-default)

(defun line-above()
  "Creates line above"
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))
(global-set-key (kbd "M-RET") 'line-above)

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (beginning-of-visual-line)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))
(global-set-key (kbd "M-s-d") 'duplicate-current-line-or-region)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
