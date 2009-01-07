(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(load-home-init-file t t))

(set-face-font 'default "-apple-inconsolata-medium-r-normal--18-0-72-72-m-0-iso10646-1")
(prefer-coding-system 'utf-8)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Monaco")))))

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

;; (add-to-list 'load-path "~/.emacs.d/vendor/color-theme")
;; (require 'color-theme)
;; (color-theme-initialize)
;;(color-theme-charcoal-black)
