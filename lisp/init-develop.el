;; -*- lexical-binding: t; -*-

(use-package projectile
  :delight
  '(:eval (concat " " (projectile-project-name)))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :hook
  (after-init . projectile-mode)
  :custom
  ((projectile-completion-system 'ivy)
   (projectile-sort-order 'recently-active)
   (projectile-enable-caching t))
  )

(use-package counsel-projectile
  :requires (projectile counsel)
  :init
  (counsel-projectile-mode)
  )

(use-package treemacs
  :bind
  (("M-0" . treemacs-select-window)
   ("C-x t 1" . treemacs-no-delete-other-windows)
   ("C-x t t" . treemacs)
   ("C-x t b" . treemacs-bookmark))
  :hook
  ((treemacs-mode . treemacs-filewatch-mode)
   (treemacs-mode . treemacs-git-mode))
  :custom
  ((treemacs-deferred-git-apply-delay 0.5)
   (treemacs-indentation 2)
   (treemacs-directory-name-transformer #'identity)
   (treemacs-position 'left)
   (treemacs-show-hidden-files t)
   (treemacs-silent-filewatch nil)
   (treemacs-silent-refresh nil)
   (treemacs-sorting 'alphabetic-asc)
   (treemacs-display-in-side-window t)
   (treemacs-eldoc-display t)
   (treemacs-file-event-delay 5000)
   (treemacs-file-follow-delay 0.2)
   (treemacs-file-name-transformer #'identity)
   (treemacs-follow-after-init t)
   (treemacs-git-command-pipe "")
   (treemacs-goto-tag-strategy 'refetch-index)
   (treemacs-indentation 2)
   (treemacs-indentation-string " ")
   (treemacs-is-never-other-window nil)
   (treemacs-max-git-entries 5000)
   (treemacs-missing-project-action 'ask)
   (treemacs-move-forward-on-expand nil)
   (treemacs-no-png-images nil)
   (treemacs-no-delete-other-windows t)
   (treemacs-project-follow-cleanup nil)
   (treemacs-persist-file (expand-file-name
                           ".cache/treemacs-persist"
                           user-emacs-directory))
   )
  )

(use-package treemacs-projectile
  :after (projectile treemacs)
  :bind-keymap
  ("C-c C-p" . treemacs-project-map)
  )

(use-package treemacs-magit
  :after (magit treemacs)
  )

(use-package company
  :diminish company-mode
  :demand t
  :bind
  ("C-c y" . company-yasnippet)
  :hook
  (after-init . global-company-mode)
  :custom
  ((company-tooltip-limit 20)
   (company-minimum-prefix-length 1)
   (company-idle-delay 0.0)
   (company-echo-delay 0)
   (company-show-numbers t))
  )

(use-package company-quickhelp
  ;; :if window-system
  :requires company
  :bind
  (:map company-active-map
        ("M-h" . company-quickhelp-manual-begin))
  :hook
  (company-mode . company-quickhelp-mode)
  :custom
  (company-quickhelp-delay nil)
  )

(use-package flycheck
  :diminish flycheck-mode
  :hook
  ((python-mode c-mode c++-mode go-mode) . flycheck-mode)
  )

(use-package yasnippet
  :diminish yas-minor-mode
  :bind
  (:map yas-minor-mode-map
        ("<f2> x" . yas-expand)
        ("<f2> i" . yas-insert-snippet))
  :hook
  (after-init . yas-global-mode)
  )

(use-package yasnippet-snippets :requires yasnippet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package lsp-mode
  :commands
  (lsp lsp-deferred)
  :hook
  ((c-mode c++-mode python-mode go-mode rust-mode) . lsp)
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :custom
  ((lsp-enable-xref t)
   (lsp-modeline-diagnostics-enable t)
   (lsp-headerline-breadcrumb-enable t)
   (lsp-enable-snippet t)
   (lsp-enable-imenu t)
   (lsp-enable-file-watchers t)
   (lsp-prefer-flymake nil)
   (lsp-keymap-prefix "s-l"))
  )

(use-package lsp-ui
  :requires lsp-mode
  :demand t
  :hook
  (lsp-mode . lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        ("C-c i" . lsp-ui-peek-find-implementation)
        ("C-c m" . lsp-ui-imenu))
  :custom
  ((lsp-ui-doc-enable t)
   (lsp-ui-flycheck-enable t)
   (lsp-ui-imenu-enable t)
   (lsp-ui-peek-enable t)
   (lsp-ui-peek-fontify 'on-demand))
  )

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list
  :hook
  (lsp-mode . lsp-treemacs-sync-mode)
  )

(use-package lsp-ivy
  :after lsp
  :commands lsp-ivy-workspace-workspace-symbol
  )

(use-package dap-mode
  :requires lsp-mode
  :demand t
  )

(use-package hideshow
  :ensure nil
  :diminish hs-minor-mode
  )

(use-package eldoc
  :ensure nil
  :diminish eldoc-mode
  )

(use-package comment-dwim-2
  :bind
  ("M-;" . comment-dwim-2)
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

(use-package rainbow-delimiters
  :hook
  ((prog-mode cmake-mode) . rainbow-delimiters-mode)
  )

(use-package magit
  :bind
  ("C-x g" . magit-status)
  :config
  (setq magit-completing-read-function 'ivy-completing-read)
  )

(use-package dumb-jump
  :bind
  (("<f2> o" . dumb-jump-go-other-window))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cc-mode
  :ensure nil
  :demand t
  :mode
  ("\\.h\\'" . c++-mode)
  )

(use-package xcscope
  :hook
  ((c-mode c++-mode) . cscope-setup)
  :bind
  (:map cscope-minor-mode-keymap
        ("C-c s a" . cscope-set-initial-directory)
        ("C-c s A" . cscope-unset-initial-directory)
        ("C-c s s" . cscope-unset-find-this-symbol)
        ("C-c s d" . cscope-unset-find-global-definition))
  :custom
  (cscope-program "/opt/homebrew/bin/gtags-cscope")
  )

(use-package ggtags
  :hook
  ((c-mode c++-mode) . ggtags-mode)
  :bind
  (:map ggtags-mode-map
        ("C-c g s" . ggtags-find-other-symbol)
        ("C-c g h" . ggtags-view-tag-history)
        ("C-c g r" . ggtags-find-reference)
        ("C-c g f" . ggtags-find-file)
        ("C-c g c" . ggtags-create-tags)
        ("C-c g u" . ggtags-update-tags)
        ("C-c g p"   . ggtags-prev-mark)
        ("C-c g ["   . ggtags-prev-mark)
        ("C-c g n"   . ggtags-next-mark)
        ("C-c g ]"   . ggtags-next-mark))
  :config
  (setq-local imenu-create-index-function
              #'ggtags-build-imenu-index)
  (setq-local eldoc-documentation-function
              #'ggtags-eldoc-function)
  (setq-local hippie-expand-try-functions-list
              (cons 'ggtags-try-complete-tag
                    hippie-expand-try-functions-list))
  )

(use-package irony
  :hook
  ((c-mode c++-mode) . irony-mode)
  :hook
  (irony-mode . irony-cdb-autosetup-compile-options)
  :bind
  (:map irony-mode-map
        ([remap completion-at-point] . counsel-irony)
        ([remap complete-symbol] . counsel-irony))
  )

(use-package irony-eldoc
  :after (irony)
  :hook
  (irony-mode . irony-eldoc)
  )

(use-package company-c-headers
  :after (company cc-mode)
  :init
  (push 'company-c-headers company-backends)
  )

(use-package google-c-style
  :hook
  (((c-mode c++-mode) . google-set-c-style)
   ((c-mode c++-mode) . google-make-newline-indent))
  )

(use-package modern-cpp-font-lock
  :diminish modern-c++-font-lock-mode
  :hook
  (c++-mode . modern-c++-font-lock-mode)
  )

(use-package clang-format
  :after cc-mode
  :bind
  (:map c-mode-base-map
        ("C-c u b" . clang-format-buffer)
        ("C-c u r" . clang-format-region))
  )

(use-package disaster
  :after cc-mode
  :bind
  (:map c-mode-base-map
        ("C-c u d" . disaster))
  )

(use-package elf-mode)

(use-package demangle-mode)

(use-package bpftrace-mode
  :mode
  ("\\.bt\\'" . bpftrace-mode)
  )

(use-package systemtap-mode
  :mode
  (("\\.stp\\'" . systemtap-mode)
   ("\\.stpm\\'" . systemtap-mode))
  )

(use-package cmake-mode
  :mode
  (("CMakeLists\\.txt\\'" . cmake-mode)
   ("\\.cmake\\'" . cmake-mode))
  )

(use-package cmake-font-lock
  :after cmake-mode
  :hook
  (cmake-mode . cmake-font-lock-activate)
  )

(use-package helm-make
  :custom
  (helm-make-completion-method 'ivy)
  )

(use-package dap-gdb-lldb
  :ensure dap-mode
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package go-mode
  :config
  (add-hook 'before-save-hook (lambda () (when (eq 'go-mode major-mode)
                                           (gofmt-before-save))))
  )

(use-package company-go
  :after (company go-mode)
  :init
  (push 'company-go company-backends)
  )

(use-package dap-go
  :ensure dap-mode
  :after go-mode
  :hook
  ((go-mode . dap-mode)
   (go-mode . dap-ui-mode)
   (go-mode . dap-tooltip-mode))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rust-mode
  :config
  (add-hook 'before-save-hook (lambda () (when (eq 'rust-mode major-mode)
                                           (lsp-format-buffer))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  )

(use-package dap-python
  :ensure dap-mode
  :after python-mode
  :hook
  ((python-mode . dap-mode)
   (python-mode . dap-ui-mode)
   (python-mode . dap-tooltip-mode))
  )

(use-package virtualenvwrapper
  :hook
  (python-mode . venv-initialize-interactive-shells)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package lispy
  :diminish lispy-mode
  :hook
  (emacs-lisp-mode . lispy-mode)
  :config
  (unbind-key "M-o" lispy-mode-map)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'init-develop)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:
