;; -*- lexical-binding: t; -*-

;;; Functions
(eval-and-compile
  (defun emacs-path (path)
    (expand-file-name path user-emacs-directory))

  (setq custom-file (emacs-path "custom.el"))
  (load custom-file 'noerror)


  (defmacro with-system (type &rest body)
    "Evaluate BODY if `system-type' equals TYPE."
    (declare (indent defun))
    `(when (eq system-type ',type)
       ,@body))
  )

;;; Environment
(eval-and-compile
  (add-to-list 'load-path "~/.emacs.d/site-lisp/use-package")
  (require 'use-package)
  (setq use-package-always-ensure t
        use-package-always-defer t
        use-package-verbose t)

  ;; (with-system darwin
  ;;   (setq mac-option-key-is-meta nil
  ;;     mac-command-key-is-meta t
  ;;     mac-command-modifier 'meta
  ;;     mac-option-modifier 'super))
  )

(use-package diminish
  :demand t
  )

;;; Editor Settings
(use-package exec-path-from-shell
  ;; :if (memq window-system '(mac ns))
  :hook
  (after-init . exec-path-from-shell-initialize)
  )

(use-package ivy
  :diminish ivy-mode
  :commands
  (ivy-set-occur)
  :bind
  (
;;; standard commands
   ("C-x b"   . ivy-switch-buffer)
   ("C-c v"   . ivy-push-view)
   ("C-c V"   . ivy-pop-view)
;;; other commands
   ("C-c C-r" . ivy-resume)
   )
  :bind
  (:map ivy-minibuffer-map
        ("C-c o" . ivy-occur)
        ("<tab>" . ivy-alt-done)
        ("C-i"   . ivy-partial-or-done)
        ("C-r"   . ivy-previous-line-or-history)
        ("M-r"   . ivy-reverse-i-search)
        ("<return>" . ivy-alt-done))
  :custom
  ((ivy-count-format "(%d/%d) ")
   (ivy-display-style 'fancy)
   (ivy-use-selectable-prompt t)
   (ivy-use-virtual-buffers t)
   (ivy-wrap t))
  :init
  (ivy-mode 1)
  :config
  (ivy-set-occur 'swiper 'swiper-occur)
  (ivy-set-occur 'ivy-switch-buffer 'ivy-switch-buffer-occur)
  )

(use-package swiper
  :after ivy
  :demand t
  :bind
  (("C-c u a" . swiper-all)
   ("C-s" . swiper-isearch))
  :bind
  (:map swiper-map
        ("M-q" . swiper-query-replace)
        ("C-l" . swiper-recenter-top-bottom)
        ("C-'" . swiper-avy)
        ("M-c" . swiper-mc))
  )


(use-package counsel
  :after swiper
  :bind
  (
;;; standard commands
   ("M-x"     . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("M-y"     . counsel-yank-pop)
   ("C-x C-b" . counsel-ibuffer)
   ("C-x C-r" . counsel-recentf)
   ("C-x C-m" . counsel-bookmark)
   ("C-h a"   . counsel-apropos)
;;; shell and system tools
   ("C-c c"   . counsel-compile)
   ("C-c g"   . counsel-git)
   ("C-c j"   . counsel-git-grep)
   ("C-c L"   . counsel-git-log)
   ("C-c k"   . counsel-rg)
   ("C-x l"   . counsel-locate)
   )
  :bind
  (:map minibuffer-local-map
        ("C-r" . counsel-minibuf-history))
  :custom
  (counsel-find-file-at-point t)
  )

(use-package hydra)

(use-package ivy-hydra
  :after (ivy hydra)
  )

(use-package which-key
  :diminish which-key-mode
  :hook
  (after-init . which-key-mode)
  :init
  (which-key-setup-side-window-right-bottom)
  )

(use-package ws-butler
  :diminish ws-butler-mode
  :hook
  (prog-mode . ws-butler-mode)
  )

(use-package expand-region
  :bind
  (("C-=" . er/expand-region)
   ("C--" . er/contract-region))
  )

(use-package highlight-indent-guides
  :if window-system
  :diminish highlight-indent-guides-mode
  :hook
  (prog-mode . highlight-indent-guides-mode)
  :custom
  ((highlight-indent-guides-method 'character)
   (highlight-indent-guides-character ?\|)
   (highlight-indent-guides-auto-odd-face-perc 15)
   (highlight-indent-guides-auto-even-face-perc 15)
   (highlight-indent-guides-auto-character-face-perc 20))
  )

(use-package clean-aindent-mode
  :hook prog-mode
  :custom
  (clean-aindent-is-simple-indent t)
  )

(use-package dtrt-indent
  :diminish dtrt-indent-mode
  :hook
  (prog-mode . dtrt-indent-mode)
  :custom
  (dtrt-indent-verbosity 0)
  )

(use-package aggressive-indent
  :diminish aggressive-indent-mode
  :hook
  ((emacs-lisp-mode cmake-mode) . aggressive-indent-mode)
  :config
  (add-to-list
   'aggressive-indent-dont-indent-if
   '(and (derived-mode-p 'c++-mode)
         (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
                             (thing-at-point 'line)))))
  )


(use-package winner
  :ensure nil
  :hook
  (after-init . winner-mode)
  )

(use-package magit
  :bind
  ("C-x g" . magit-status)
  )

;; development
(use-package projectile
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :hook
  (after-init . projectile-mode)
  :custom
  (projectile-index-method 'alien)
  (projectile-sort-order 'recently-active)
  (projectile-completion-system 'ivy)
  )

(use-package company
  :diminish company-mode
  :hook
  (after-init . global-company-mode)
  :custom
  ((company-tooltip-limit 20)
   (company-idle-delay 0.0)
   (company-echo-delay 0)
   (company--show-numbers t))
  )

(use-package company-quickhelp
  :if window-system
  :requires company
  :bind
  (:map company-active-map
        ("M-h" . company-quickhelp-manual-begin))
  :hook
  (company-mode . company-quickhelp-mode)
  :custom
  (company-quickhelp-delay nil)
  )

(use-package lsp-mode
  :after which-key
  :hook
  ((c-mode c++-mode) . lsp)
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :init
  (setq lsp-keymap-prefix "C-c l")
  )

(use-package lsp-ivy
  :commands
  (lsp-ivy-workspace-symbol)
  )

(use-package lsp-ui
  :commands
  (lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        ("C-c i" . lsp-ui-peek-find-implementation)
        ("C-c m" . lsp-ui-imenu))
  :custom
  (
;;; lsp-ui-sideline
   (lsp-ui-sideline-show-diagnostics t)
;;; lsp-ui-doc
   (lsp-ui-doc-enable t)
;;; lsp-ui-peek
   (lsp-ui-peek-enable t)
;;; lsp-ui-imenu
   (lsp-ui-imenu t)
   )
  )

(use-package flycheck
  :diminish flycheck-mode
  :hook
  (prog-mode . flycheck-mode)
  )

(use-package comment-dwim-2
  :bind
  ("M-;" . comment-dwim-2)
  )

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode)
  )

(use-package hideshow
  :ensure nil
  :diminish hs-minor-mode
  :hook
  (prog-mode . hs-minor-mode)
  )

(use-package ggtags
  :hook
  ((c-mode c++-mode) . ggtags-mode)
  :custom
  ((ggtags-use-idutils t)
   (ggtags-global-ignore-case t))
  )

(use-package disaster
  :after cc-mode
  :bind
  (:map c-mode-base-map
        ("C-c d" . disaster))
  :init
  (with-system darwin
    (setq disaster-cflags (or (getenv "CFLAGS") "")
          disaster-cxxflags (or (getenv "CXXFLAGS") ""))
    )
  )

(use-package gdb-mi
  :ensure nil
  :defer t
  :custom
  ((gdb-many-windows t)
   (gdb-show-main t))
  )

(use-package clang-format
  :after cc-mode
  :bind
  (:map c-mode-base-map
        ("C-c u b" . clang-format-buffer)
        ("C-c u r" . clang-format-region))
  )

(use-package irony
  :hook
  ((c++-mode c-mode) . irony-mode)
  :hook
  (irony-mode . irony-cdb-autosetup-compile-options)
  )

(use-package company-irony)

(use-package call-graph)

(use-package modern-cpp-font-lock
  :hook
  (c++-mode . #'modern-c++-font-lock-mode)
  )

;; Emacs Lisp
(use-package lispy
  :diminish lispy-mode
  :hook
  (emacs-lisp-mode . lispy-mode)
  )

(use-package auto-compile
  :hook
  ((emacs-lisp-mode . auto-compile-on-load-mode)
   (emacs-lisp-mode . auto-compile-on-save-mode))
  :custom
  ((auto-compile-display-buffer nil)
   (auto-compile-mode-line-counter t))
  )

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
