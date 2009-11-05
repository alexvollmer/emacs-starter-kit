;; ESS
(add-to-list 'load-path (concat dotfiles-dir "/vendor/ess/lisp"))
(require  'ess-site)
(setq ess-S-assign-key (kbd "C-="))
(ess-toggle-S-assign-key t)             ; enable above key definition
;; leave my underscore key alone!
(ess-toggle-underscore nil)
(setq ess-r-versions '("R-"))
(setq ess-use-inferior-program-name-in-buffer-name t)
(add-to-list 'auto-mode-alist '("\\.Rd\\'" . Rd-mode))
(setq ess-indent-level 4)

(setq ess-nuke-trailing-whitespace-p 1)
(add-hook 'ess-mode-hook
          '(lambda () 
             (setq fill-column 72)
             (highlight-trailing-whitespace)))

(provide 'my-ess)