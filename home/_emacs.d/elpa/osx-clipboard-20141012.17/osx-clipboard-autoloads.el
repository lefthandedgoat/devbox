;;; osx-clipboard-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "osx-clipboard" "osx-clipboard.el" (21600 61768
;;;;;;  0 0))
;;; Generated autoloads from osx-clipboard.el

(let ((loads (get 'osx-clipboard 'custom-loads))) (if (member '"osx-clipboard" loads) nil (put 'osx-clipboard 'custom-loads (cons '"osx-clipboard" loads))))

(defvar osx-clipboard-mode nil "\
Non-nil if Osx-Clipboard mode is enabled.
See the command `osx-clipboard-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `osx-clipboard-mode'.")

(custom-autoload 'osx-clipboard-mode "osx-clipboard" nil)

(autoload 'osx-clipboard-mode "osx-clipboard" "\
Kill and yank using the OS X clipboard when running in a text terminal.

This mode allows Emacs to use the OS X system clipboard when
running in the terminal, making killing and yanking behave
similarly to a graphical Emacs.  It is not needed in a graphical
Emacs, where NS clipboard integration is built in.

It sets the variables `interprogram-cut-function' and
`interprogram-paste-function' to thin wrappers around the
\"pbcopy\" and \"pbpaste\" command-line programs.

Consider also customizing the variable
  `save-interprogram-paste-before-kill' to `t' for best results.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; osx-clipboard-autoloads.el ends here
