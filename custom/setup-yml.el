(unless (package-installed-p 'yaml-mode)
  (package-install 'yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\Pipfile\\'" . yaml-mode)) ;; Python pipenv dependency files

; Unlike python-mode, this mode follows the Emacs convention of not
; binding the ENTER key to `newline-and-indent'.
; To get this behavior, add the key definition to `yaml-mode-hook':
(add-hook 'yaml-mode-hook
          #'(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


(provide 'setup-yml)
