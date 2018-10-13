(require 'aza-dired-ext)

(use-package dired
  :ensure nil
  :ensure-system-package thunar
  :bind ((:map dired-mode-map
               ("/" . ora-dired-up-directory)
               ("C-r" . ora-dired-rsync)
               ("C-o" . dired-view-current)
               ("n" . dired-view-next)
               ("p" . dired-view-previous)
               ("s" . xah-dired-sort)
               ("&" . ora-dired-do-async-shell-command)
               ("O" . ora-dired-other-window)
               ("z" . ora-dired-get-size)
               ("'" . eshell-this-dir)
               ("`" . shell-here)
               ("s-o" . dired-open-directory-in-thunar)))
  :init
  (require 'aza-dired-ext)
  (require 'dired-x) ; dired-jump is cool
  :config

  ;; error when outside dired config
  (use-package dired+
    :load-path "~/.emacs.d/elisp/diredp/"
    :config
    (diredp-toggle-find-file-reuse-dir 1))

  ;; dired - reuse current buffer by pressing 'a'
  (put 'dired-find-alternate-file 'disabled nil)

  ;; always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  (setq dired-auto-revert-buffer t)
  (setq delete-by-moving-to-trash t)

  ;; if there is a dired buffer displayed in the next window, use its
  ;; current subdir, instead of the current subdir of this dired buffer
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-AltGhF --group-directories-first")
  (add-hook 'dired-mode-hook #'dired-omit-mode)
  (setq dired-omit-files
        (format "\\(?:\\.%s\\'\\)\\|%s\\|\\`_minted"
                (regexp-opt
                 '("aux" "log" "pickle" "synctex.gz" "run.xml" "bcf" "am" "in" "blx.bib"
                   "vrb" "opt" "nav" "snm" "out"))
                (regexp-opt
                 '("compile_commands.json"
                   "__pycache__")))))

(use-package wdired
  :after dired
  :config
  (setq wdired-use-dired-vertical-movement 'sometimes))

(use-package dired-ranger
  :ensure t
  :bind (:map dired-mode-map
              ("W" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("Y" . dired-ranger-paste)))

(use-package dired-subtree
  :config
  (bind-keys :map dired-mode-map
             ("i" . dired-subtree-insert)
             (";" . dired-subtree-remove)))


(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("\\" . dired-narrow)))

(provide 'aza-dired)
