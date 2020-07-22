;; -*- lexical-binding: t; -*-

(use-package org
  :ensure org-plus-contrib
  :pin org
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ;; ("C-c b" . org-iswitchb)
   )
  :custom
  ((org-image-actual-width nil)
   (org-catch-invisible-edits 'smart)
   (org-src-fontify-natively t)
   (org-preview-latex-default-process 'imagemagick)
   (org-latex-packages-alist
    '(("" "ctex")
      ("" "minted")
      ("" "color")
      ("" "tikz")))
   )
  )

(use-package ob
  :ensure org-plus-contrib
  )

(use-package ox
  :ensure org-plus-contrib
  :custom
  ((org-export-with-toc nil)
   (org-export-default-language "zh-CN")
   (org-export-time-stamp-file nil))
  )

(use-package ox-html
  :ensure org-plus-contrib
  :custom
  ((org-html-validation-link nil)
   (org-html-doctype "html5")
   (org-html-html5-fancy t))
  )

(use-package ox-latex
  :ensure org-plus-contrib
  :custom
  ((org-latex-compiler "xelatex")
   (org-latex-listings 'minted)
   (org-latex-pdf-process
    '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
      "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
      "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
   )
  )

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  )

(provide 'init-writing)

;; Local Variables:
;; mode: emacs-lisp
;; indent-tabs-mode: nil
;; coding: utf-8
;; End:
