(require 'autotest)

(add-to-list 'load-path (concat dotfiles-dir "/vendor"))
(require 'toggle)

(font-lock-add-keywords
 'ruby-mode
 '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
    1 font-lock-warning-face t)))

(add-hook 'ruby-mode-hook
    '(lambda ()
       (whitespace-mode t)
        (inf-ruby-keys)
	(add-hook 'local-write-file-hooks
		  '(lambda()
		     (save-excursion
		       (untabify (point-min) (point-max))
		       (delete-trailing-whitespace)
		       )))
	(set (make-local-variable 'indent-tabs-mode) 'nil)
	(set (make-local-variable 'tab-width) 2)
	(imenu-add-to-menubar "IMENU")
	(require 'ruby-electric)
	(ruby-electric-mode t)
        (add-to-list 'compilation-mode-font-lock-keywords
                     '("^\\([[:digit:]]+\\) examples?, \\([[:digit:]]+\\) failures?\\(?:, \\([[:digit:]]+\\) pendings?\\)?$"
                       (0 '(face nil message nil help-echo nil mouse-face nil) t)
                       (1 compilation-info-face)
                       (2 (if (string= "0" (match-string 2))
                              compilation-info-face
                            compilation-error-face))
                       (3 compilation-info-face t t)))
        (local-set-key "\C-c\C-t" 'toggle-buffer)
	))

(autoload 'rubydb "rubydb3x" "Ruby debugger" t)
(add-hook 'ruby-mode-hook 'turn-on-font-lock)

;;(add-hook 'rhtml-mode-hook (lambda () (rinari-launch)))

;; (add-to-list 'load-path "~/Development/rinari")
;; (require 'rinari)

;; (require 'haml-mode nil 't)
;; (add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
;; (add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;;; Flymake

;; (require 'flymake)

;; Invoke ruby with '-c' to get syntax checking
;; (defun flymake-ruby-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "ruby" (list "-c" local-file))))

;; (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

;; (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
;;       flymake-err-line-patterns)

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (when (and buffer-file-name (file-writable-p buffer-file-name))
;;               (local-set-key (kbd "C-c d")
;;                              'flymake-display-err-menu-for-current-line)
;;               (flymake-mode t))))

(provide 'my-ruby)
