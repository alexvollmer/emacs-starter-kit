(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(load-home-init-file t t)
 '(tool-bar-mode nil))

(prefer-coding-system 'utf-8)
(setq visible-bell nil)

;; Font
(set-face-font 'default "-apple-inconsolata-medium-r-normal--18-0-72-72-m-0-iso10646-1")

(if (equal system-type 'darwin)
    (progn
      (setq one-buffer-one-frame nil)
      (cua-mode 0)
      (setq mac-command-modifier 'meta)
      (setq x-select-enable-clipboard t)
      (set-variable 'default-buffer-file-coding-system 'mac-roman-unix)
      (set-default-coding-systems 'mac-roman-unix)
      (set-selection-coding-system 'mac-roman)
      (set-keyboard-coding-system 'mac-roman)
      (prefer-coding-system 'mac-roman-unix)
      (setq-default cursor-type t)
      (setq browse-url-browser-function
            '(("." . browse-url-default-macosx-browser)))))

;; Color Themes
(add-to-list 'load-path (concat dotfiles-dir "/vendor/color-theme"))
(require 'color-theme)
(color-theme-initialize)
;(color-theme-aalto-light)
;(color-theme-andreas)
;(color-theme-charcoal-black)
(color-theme-blackboard)

;; extra CSS goodness for portal work
(add-to-list 'auto-mode-alist '("\\.css\\.ncss$" . css-mode))

;; don't use js2-mode
;; (add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
;; (setq javascript-indent-level 2)

;; Confluence
(require 'confluence)
(custom-set-variables
 '(confluence-url "http://confluence.evri.corp/confluence/rpc/xmlrpc")
 '(confluence-default-space-alist (list (cons confluence-url "ZGST"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; confluence editing support (with longlines mode)

(autoload 'confluence-get-page "confluence" nil t)

(eval-after-load "confluence"
  '(progn
     (require 'longlines)
     (progn
       (add-hook 'confluence-mode-hook 'longlines-mode)
       (add-hook 'confluence-before-save-hook 'longlines-before-revert-hook)
       (add-hook 'confluence-before-revert-hook 'longlines-before-revert-hook)
       (add-hook 'confluence-mode-hook
                 '(lambda ()
                    (local-set-key "\C-j" 'confluence-newline-and-indent))))))

;; LongLines mode: http://www.emacswiki.org/emacs-en/LongLines
(autoload 'longlines-mode "longlines" "LongLines Mode." t)

(eval-after-load "longlines"
  '(progn
     (defvar longlines-mode-was-active nil)
     (make-variable-buffer-local 'longlines-mode-was-active)

     (defun longlines-suspend ()
       (if longlines-mode
           (progn
             (setq longlines-mode-was-active t)
             (longlines-mode 0))))

     (defun longlines-restore ()
       (if longlines-mode-was-active
           (progn
             (setq longlines-mode-was-active nil)
             (longlines-mode 1))))

     ;; longlines doesn't play well with ediff, so suspend it during diffs
     (defadvice ediff-make-temp-file (before make-temp-file-suspend-ll
                                             activate compile preactivate)
       "Suspend longlines when running ediff."
       (with-current-buffer (ad-get-arg 0)
         (longlines-suspend)))

     (add-hook 'ediff-cleanup-hook
               '(lambda ()
                  (dolist (tmp-buf (list ediff-buffer-A
                                         ediff-buffer-B
                                         ediff-buffer-C))
                    (if (buffer-live-p tmp-buf)
                        (with-current-buffer tmp-buf
                          (longlines-restore))))))))

;; keybindings (change to suit)

;; open confluence page
(global-set-key "\C-xwf" 'confluence-get-page)

;; setup confluence mode
(add-hook 'confluence-mode-hook
          '(lambda ()
             (local-set-key "\C-xw" confluence-prefix-map)))

;; HAML and SASS
(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;; Quick window navigation
(require 'window-number)
(window-number-meta-mode 1)

(column-number-mode)
(whitespace-mode t)

;; Make IDO rock *even* more
(setq imenu-auto-rescan t)

;; erlang
(add-to-list 'load-path (concat dotfiles-dir "/vendor/erlang-mode"))
(setq erlang-root-dir "/usr/local/otp")
(setq exec-path (cons "/usr/local/otp/bin" exec-path))
(require 'erlang-start)
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))

;; yasnippet
(add-to-list 'load-path (concat dotfiles-dir "/vendor/yasnippet.el"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "/vendor/yasnippet.el/snippets"))

(require 'magit)

(server-start)

;; tramp
(setq tramp-default-method "ssh")
(setq shell-prompt-pattern "^.*~: $")

;; insert Emacs-appropriate encoding comment for encoding in
;; the commenting style appropriate to the current mode
(defun insert-encoding (encoding)
  "Insert the encoding local variable"
  (interactive "sEncoding: ")
  (insert (format "-*- coding: %s -*-" encoding))
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (move-end-of-line nil)
  (comment-dwim nil)
  (insert "\n"))
