;;; starter-kit-js.el --- Some helpful Javascript helpers
;;
;; Part of the Emacs Starter Kit

(font-lock-add-keywords
 'espresso-mode `(("\\(function *\\)("
                   (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                             "ƒ")
                             nil)))))

(font-lock-add-keywords 'espresso-mode
                        '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
                           1 font-lock-warning-face t)))

(autoload 'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
(add-hook 'espresso-mode-hook 'moz-minor-mode)
(add-hook 'espresso-mode-hook 'esk-paredit-nonlisp)
(add-hook 'espresso-mode-hook 'run-coding-hook)
(add-hook 'espresso-mode-hook 'idle-highlight)
(setq espresso-indent-level 2)

;; espresso's insert-and-indent doesn't play nicely with pretty-lambda
(eval-after-load 'espresso
  '(progn (define-key espresso-mode-map "{" 'paredit-open-brace)
          (define-key espresso-mode-map "}" 'paredit-close-brace-and-newline)))

(provide 'starter-kit-js)
;;; starter-kit-js.el ends here
