;; require package managers, but we'll avoid them if at all possible
(require 'package)

(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)
(push '("org" . "http://orgmode.org/elpa/") package-archives)

;;=====================================
;;plugins
;;=====================================

(setq package-list '(
   exec-path-from-shell
   evil
   evil-leader
   color-theme
   key-chord
   ido-vertical-mode
   flx-ido
   osx-clipboard
   expand-region
   ace-jump-mode
   scala-mode2
   full-ack
   navigate
   helm
   go-mode
   auto-complete
   zencoding-mode
   clojure-mode
   cider
   magit
   2048-game
   markdown-mode
   projectile))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'exec-path-from-shell)
(require 'evil)
(require 'evil-leader)
(require 'color-theme)
(require 'key-chord)
(require 'ido)
(require 'ido-vertical-mode)
(require 'flx-ido)
(require 'projectile)
(require 'osx-clipboard)
(require 'expand-region)
(require 'ace-jump-mode)
(require 'scala-mode2)
(require 'navigate)
(require 'helm)
(require 'go-mode)
(require 'auto-complete)
(require 'full-ack)
(require 'zencoding-mode)
(require 'web-mode)
(require 'magit)
(require 'markdown-mode)

;;=====================================
;;general configuration
;;=====================================
(menu-bar-mode -1) ;;remove menu bar
(define-key global-map (kbd "RET") 'newline-and-indent) ;;auto indent on new line
(setq-default truncate-lines t)

;;=====================================
;;evil leader
;;=====================================
(defun amir/touch ()
  "Run touch command on current file."
  (interactive)
  (when buffer-file-name
    (shell-command (concat "touch " (shell-quote-argument buffer-file-name)))
    (clear-visited-file-modtime)))

(defun amir/tab-space-four ()
  "Sets javascript and default tab space to four spaces."
  (interactive)
  (setq js-indent-level 4)
  (setq default-tab-width 4))

(defun amir/next-search-to-top ()
  "Primarily for presentations, finds next occurence of string and scrolls it to the top"
  (interactive)
  (progn
    (call-interactively (evil-next-search 1))
    (call-interactively (evil-scroll-line-to-top))))

(defun amir/previous-search-to-top ()
  "Primarily for presentations, finds previous occurence of string and scrolls it to the top"
  (interactive)
  (progn
    (evil-previous-search 1)
    (evil-scroll-line-to-top)))

(defun amir/tab-space-two ()
  "Sets javascript and default tab space to two spaces."
  (interactive)
  (setq js-indent-level 2)
  (setq default-tab-width 2))

(global-evil-leader-mode)

(evil-leader/set-leader ",")

(evil-leader/set-key
  "e" 'cider-eval-defun-at-point
  "E" 'eval-last-sexp
  "w" 'web-mode
  "j" 'ace-jump-char-mode
  "m" 'evil-window-vnew
  "g" 'projectile-find-file
  "t" 'amir/touch
  "a" 'amir/foo-inline
  "f" 'next-error
  "d" 'previous-error
  "b" 'ido-switch-buffer
  "." 'ido-dired
  "s" 'magit-status
  "h" 'vc-print-log
  "4" 'amir/tab-space-four
  "2" 'amir/tab-space-two
  "n" 'amir/next-search-to-top
  "p" 'amir/previous-search-to-top
  "i" 'install-packages)

;;=====================================
;; evil configuration
;;=====================================
(evil-mode 1)

(define-key evil-normal-state-map [escape] 'keyboard-quit) (define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; Remap org-mode meta keys for convenience
(mapcar (lambda (state)
    (evil-declare-key state org-mode-map
      (kbd "M-l") 'org-metaright
      (kbd "M-h") 'org-metaleft
      (kbd "M-k") 'org-metaup
      (kbd "M-j") 'org-metadown
      (kbd "M-L") 'org-shiftmetaright
      (kbd "M-H") 'org-shiftmetaleft
      (kbd "M-K") 'org-shiftmetaup
      (kbd "M-J") 'org-shiftmetadown))
  '(normal insert))

(defun evil-send-string-to-terminal (string)
  (unless (display-graphic-p) (send-string-to-terminal string)))

(defun evil-terminal-cursor-change ()
  (when (string= (getenv "TERM_PROGRAM") "iTerm.app")
    (add-hook 'evil-insert-state-entry-hook (lambda () (evil-send-string-to-terminal "\e]50;CursorShape=1\x7")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (evil-send-string-to-terminal "\e]50;CursorShape=0\x7"))))
  (when (and (getenv "TMUX")  (string= (getenv "TERM_PROGRAM") "iTerm.app"))
    (add-hook 'evil-insert-state-entry-hook (lambda () (evil-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=1\x7\e\\")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (evil-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=0\x7\e\\")))))

(evil-terminal-cursor-change)

;;=====================================
;;key chord
;;=====================================
(key-chord-mode 1)
;;(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;;(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)


;;=====================================
;;color theme configuration
;;=====================================
(color-theme-initialize)
(load "~/.emacs.d/railscasts-theme/railscasts-theme.el")

;;=====================================
;;projectile mode
;;=====================================
(projectile-global-mode)
;;(setq projectile-require-project-root nil)

;;=====================================
;;projectile vertical
;;=====================================
(ido-mode 1)
(ido-vertical-mode 1)

(add-hook 'ido-setup-hook 'vim-like-ido-keys)

(defun vim-like-ido-keys ()
  "Add vim like keybindings for ido."
  (define-key ido-completion-map (kbd "J") 'ido-next-match)
  (define-key ido-completion-map (kbd "K") 'ido-prev-match)
  (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-k") 'ido-prev-match)
)


;;=====================================
;;color changes
;;=====================================

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(col-highlight ((t (:background "color-233"))))
 '(diff-added ((t (:inherit diff-changed :background "#ddffdd" :foreground "black"))))
 '(diff-header ((t (:background "grey80" :foreground "black"))))
 '(diff-removed ((t (:inherit diff-changed :background "#ffdddd" :foreground "black"))))
 '(hl-line ((t (:background "color-233"))))
 '(lazy-highlight ((t (:background "black" :foreground "white" :underline t))))
 '(neo-dir-link-face ((t (:foreground "cyan"))))
 '(neo-file-link-face ((t (:foreground "white"))))
 '(secondary-selection ((t (:background "color-236"))))
 '(shadow ((t (:foreground "cyan"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "color-250"))))
 '(web-mode-html-tag-face ((t (:foreground "yellow")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;=====================================
;;flx fuzzy matching
;;=====================================
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode -1)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
;(setq ido-use-faces nil)

;;=====================================
;;osx clipboard
;;=====================================
(osx-clipboard-mode 1)

;;=====================================
;;whitespace
;;=====================================

(defun amir/turn-on-show-trailing-whitespace ()
  (interactive)
  (setq show-trailing-whitespace t))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook 'amir/turn-on-show-trailing-whitespace)

(setq-default indent-tabs-mode nil
              tab-width 2)


(setq css-indent-offset 2)

;;=====================================
;;ensime for scala development
;;=====================================
;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;(setenv "PATH" (concat "/usr/local/bin/sbt:" (getenv "PATH")))
;(setenv "PATH" (concat "/usr/local/bin/scala:" (getenv "PATH")))
;
;(when (memq window-system '(mac ns))
;  (exec-path-from-shell-initialize))

(defun amir/ruby-words ()
  (interactive)
  (modify-syntax-entry ?_ "w"))

(add-hook 'ruby-mode-hook 'amir/ruby-words)


;;=====================================
;; Tmux splits
;;=====================================

(defun amir/emacs-or-tmux (dir tmux-cmd)
  (interactive)
  (unless (ignore-errors (funcall (intern (concat "windmove-" dir))))
     (shell-command tmux-cmd)))

(global-set-key (kbd "C-j")
  '(lambda () (interactive) (amir/emacs-or-tmux "up"  "tmux select-pane -U")))
(global-set-key (kbd "C-k")
  '(lambda () (interactive) (amir/emacs-or-tmux "down"  "tmux select-pane -D")))
(global-set-key (kbd "C-l")
  '(lambda () (interactive) (amir/emacs-or-tmux "right" "tmux next-window")))
(global-set-key (kbd "C-h")
  '(lambda () (interactive) (amir/emacs-or-tmux "left"  "tmux previous-window")))


;;=====================================
;; tab width 2
;;=====================================
(setq js-indent-level 2)


;;=====================================
;; auto complete
;;=====================================
(global-auto-complete-mode 1)
(setq ac-auto-show-menu 0.1)
(ac-config-default)


;;=====================================
;; shell lines out
;;=====================================
(defun amir/foo-inline(cmd)
  (interactive)
  (shell-command-on-region (point) (mark) cmd nil t))

(defun amir/foo-above(cmd)
  (interactive)
  (let* ((buffer (generate-new-buffer "*shell-command*"))
         (output (progn
                   (shell-command-on-region (point) (mark) cmd buffer)
                   (with-current-buffer buffer
                     (buffer-string)))))
    (save-excursion
      (goto-char (min (point) (mark)))
      (insert output))))

(defun amir/foo-kill-ring(cmd)
  (interactive)
  (kill-new
   (let ((buffer (generate-new-buffer "*shell-command*")))
     (shell-command-on-region (point) (mark) cmd buffer)
     (with-current-buffer buffer
       (buffer-string))))
  (message "Output copied to kill ring"))
