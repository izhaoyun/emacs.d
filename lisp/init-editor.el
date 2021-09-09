(use-package exec-path-from-shell
  ;; :if (memq window-system '(mac ns))
  :hook
  (after-init . exec-path-from-shell-initialize)
  )

(use-package use-package-hydra)

(use-package ivy
  :diminish ivy-mode
  :bind
  (("C-x b" . ivy-switch-buffer)
   ("C-c C-r" . ivy-resume)
   ("C-c v" . ivy-push-view)
   ("C-c V" . ivy-pop-view))
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
  (("C-c u a" . swiper-all))
  :bind
  (:map swiper-map
        ("M-q" . swiper-query-replace)
        ("C-l" . swiper-recenter-top-bottom)
        ("C-'" . swiper-avy)
        ("M-c" . swiper-mc))
  )

(use-package counsel
  :requires swiper
  :bind
  (("C-s" . counsel-grep-or-swiper)
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-r" . counsel-recentf)
   ("C-x r b" . counsel-bookmark)
   ("C-x r d" . counsel-bookmarked-directory)
   ("C-x C-b" . counsel-ibuffer)
   ("C-c c" . counsel-compile)
   ("C-c g m" . counsel-imenu)
   ("C-c g g" . counsel-git)
   ("C-c g j" . counsel-git-grep)
   ("C-c g l" . counsel-git-log)
   ("C-c g b" . counsel-switch-to-shell-buffer)
   ("C-c k" . counsel-ag)
   ("C-x l" . counsel-locate)
   ("C-x m" . counsel-mark-ring)
   ("M-y" . counsel-yank-pop)
   ("C-c f" . counsel-git-log)
   ("C-c P" . counsel-package)
   ("M-s d" . counsel-dired-jump)
   ("M-s f" . counsel-file-jump)
   ("C-h a" . counsel-apropos)
   ("C-h l" . counsel-find-library)
   ("C-h L" . counsel-load-library)
   ("C-h b" . counsel-descbinds)
   ("C-h w" . woman))
  :bind
  (:map minibuffer-local-map
        ("C-r" . counsel-minibuf-history))
  :custom
  (counsel-find-file-at-point t)
  )

(use-package avy
  :bind
  (("C-:" . avy-goto-char)
   ("C-'" . avy-goto-char-2)
   ("M-g c" . avy-goto-char)
   ("M-g f" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)
   ("M-g e" . avy-goto-word-0)
   ("C-c C-j" . avy-resume))
  :init
  (avy-setup-default)
  )

(use-package ace-pinyin
  :requires avy
  :diminish ace-pinyin-mode
  )

(use-package ace-window
  :requires avy
  :bind
  ("M-o" . ace-window)
  )

(use-package avy-zap
  :requires avy
  :bind
  (("M-z" . avy-zap-to-char-dwim)
   ("M-Z" . avy-zap-up-to-char-dwim))
  )

(use-package ace-link
  :requires avy
  :init
  (ace-link-setup-default)
  )

(use-package volatile-highlights
  :after (undo-tree)
  :diminish volatile-highlights-mode
  :init
  (volatile-highlights-mode)
  :config
  (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-move)
  (vhl/install-extension 'undo-tree)
  )

(use-package highlight-symbol
  :after hydra
  :bind
  ("C-h c" . hydra-hs/body)
  :hydra (hydra-hs (:color blue :hint nil)
		   "
		   ^Highlight Symbol^
--------------------------------------------------------------
 _c_: highlight-symbol
 _n_: highlight-symbol-next
 _p_: highlight-symbol-prev
 _r_: highlight-symbol-query-replace
"
		   ("c" highlight-symbol)
		   ("n" highlight-symbol-next)
		   ("p" highlight-symbol-prev)
		   ("r" highlight-symbol-query-replace)
  		   )
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

(use-package undo-tree
  :diminish undo-tree-mode
  :hook
  ((prog-mode cmake-mode org-mode) . undo-tree-mode)
  :bind
  (("C-x u" . undo-tree-visualize)
   ("C-x r u" . undo-tree-save-state-to-register)
   ("C-x r U" . undo-tree-restore-state-from-register)
   ("C-/" . undo-tree-undo)
   ("C-_" . undo-tree-undo)
   ("C-?" . undo-tree-redo)
   ("M-_" . undo-tree-redo))
  :init
  (defalias 'redo 'undo-tree-redo)
  :custom
  ((undo-tree-visualizer-diff t)
   (undo-tree-visualizer-timestamps t))
  )

(use-package dired-async
  :ensure async
  :hook
  (dired-mode . dired-async-mode)
  )

(use-package hippie-exp
  :ensure nil
  :bind
  ("M-/" . hippie-expand)
  )

(use-package paren
  :ensure nil
  :hook
  (prog-mode . show-paren-mode)
  )

(use-package winner
  :ensure nil
  :hook
  (after-init . winner-mode)
  )

(use-package diminish)

(use-package dired-narrow
  :disabled
  :bind
  (("C-c C-n" . dired-narrow))
  )

(use-package recentf
  :ensure nil
  :hook
  (after-init . recentf-mode)
  )

(provide 'init-editor)
