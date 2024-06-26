;;; setup-files --- file explorer, backups, etc

;;; Commentary:
;; taken from https://tuhdo.github.io/emacs-tutor3.html

(provide 'setup-files)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; group: Files                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq large-file-warning-threshold 100000000) ;; size in bytes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> Back up            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar backup-directory "~/.backups")
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))
(setq
 make-backup-files t        ; backup a file the first time it is saved
 backup-directory-alist `((".*" . ,backup-directory)) ; save backup files in ~/.backups
 backup-by-copying t     ; copy the current file into backup directory
 version-control t   ; version numbers for backup files
 delete-old-versions t   ; delete unnecessary versions
 kept-old-versions 6     ; oldest versions to keep when a new numbered backup is made (default: 2)
 kept-new-versions 9 ; newest versions to keep when a new numbered backup is made (default: 2)
 auto-save-default t ; auto-save every buffer that visits a file
 auto-save-timeout 20 ; number of seconds idle time before auto-save (default: 30)
 auto-save-interval 200 ; number of keystrokes between auto-saves (default: 300)
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> Dired              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
 dired-dwim-target t            ; if another Dired buffer is visible in another window, use that directory as target for Rename/Copy
 dired-recursive-copies 'always         ; "always" means no asking
 dired-recursive-deletes 'top           ; "top" means ask once for top level directory
 dired-listing-switches "-lha"          ; human-readable listing
 )

;; automatically refresh dired buffer on changes
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; if it is not Windows, use the following listing switches
(when (not (eq system-type 'windows-nt))
  (setq dired-listing-switches "-lha --group-directories-first"))

;;; KEY BINDINGS.
;; (define-key ctl-x-map "\C-j" 'dired-jump)
;; (define-key ctl-x-4-map "\C-j" 'dired-jump-other-window))
;; (define-key dired-mode-map "\C-x\M-o" 'dired-omit-mode)
;; (define-key dired-mode-map "*O" 'dired-mark-omitted)
;; (define-key dired-mode-map "\M-(" 'dired-mark-sexp)
;; (define-key dired-mode-map "*(" 'dired-mark-sexp)
;; (define-key dired-mode-map "*." 'dired-mark-extension)
;; (define-key dired-mode-map "\M-!" 'dired-smart-shell-command)
;; (define-key dired-mode-map "\M-G" 'dired-goto-subdir)
;; (define-key dired-mode-map "F" 'dired-do-find-marked-files)
;; (define-key dired-mode-map "Y"  'dired-do-relsymlink)
;; (define-key dired-mode-map "%Y" 'dired-do-relsymlink-regexp)
;; (define-key dired-mode-map "V" 'dired-do-run-mail)
(require 'dired-x) ; provide extra commands for Dired

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> Dired -> Wdired    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wdired allows you to edit a Dired buffer and write changes to disk
;; - Switch to Wdired by C-x C-q
;; - Edit the Dired buffer, i.e. change filenames
;; - Commit by C-c C-c, abort by C-c C-k
(require 'wdired)
(setq
 wdired-allow-to-change-permissions t   ; allow to edit permission bits
 wdired-allow-to-redirect-links t       ; allow to edit symlinks
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> Recentf            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package recentf-ext
  :ensure t
  :config ; execute after the package is loaded
  (recentf-mode)
  (setq
   recentf-max-menu-items 30
   recentf-max-saved-items 5000)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> Ztree              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; text-tree explorer (M-x ztree-dir) and
;; diff on two directories (M-x ztree-diff)
(use-package ztree
  :ensure t
  :config ; execute after the package is loaded
  (setq ztree-draw-unicode-lines t
        ztree-dir-move-focus t) ; move focus to the other window when the RET key is pressed
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Files -> View Large Files   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package vlf
  :ensure t
  :config
  (setq vlf-application 'dont-ask) ; automatically use vlf on large file, when the file exceed large-file-warning-threshold
  )
