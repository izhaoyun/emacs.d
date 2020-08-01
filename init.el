;; -*- lexical-binding: t; -*-

(setq custom-file
      (expand-file-name
       "custom.el"
       user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

(package-initialize)
(add-to-list 'load-path
             (expand-file-name
              "site-lisp/use-package"
              user-emacs-directory))
(require 'use-package)

(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-verbose t)

(use-package auto-compile
  :hook
  ((emacs-lisp-mode . auto-compile-on-load-mode)
   (emacs-lisp-mode . auto-compile-on-save-mode))
  :custom
  ((auto-compile-display-buffer nil)
   (auto-compile-mode-line-counter t))
  )

(add-to-list 'load-path
             (expand-file-name
              "lisp"
              user-emacs-directory))

(require 'init-editor)
(require 'init-develop)
(require 'init-writing)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
