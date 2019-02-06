;; Initialize the package system.
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

;; keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
;; update the package metadata is the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

(setq user-full-name "azzamsa"
      user-mail-address "azzam@azzamsa.com")

;;; loading my  configuration
(add-to-list 'load-path "~/.emacs.d/modules/")
(add-to-list 'load-path "~/.emacs.d/core/")
(add-to-list 'load-path "~/.emacs.d/aza-packages/")

;; Always load newest byte code
(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defconst azzamsa-savefile-dir (expand-file-name "savefile" user-emacs-directory))
(defconst azzamsa-eshell-dir (expand-file-name "eshell" azzamsa-savefile-dir))
(defconst azzamsa-core-dir (expand-file-name "core" user-emacs-directory))
(defconst azzamsa-modules-dir (expand-file-name "modules" user-emacs-directory))
(defconst aza-packages-dir (expand-file-name "aza-packages" user-emacs-directory))

;; create the savefile dir if it doesn't exist
(unless (file-exists-p azzamsa-savefile-dir)
  (make-directory azzamsa-savefile-dir))

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; no need double click to insert, Yey!
(delete-selection-mode +1)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Emacs modes typically provide a standard means to change the
;; indentation width -- eg. c-basic-offset: use that to adjust your
;; personal indentation width, while maintaining the style (and
;; meaning) of any files you load.
(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance

;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a keypress
(delete-selection-mode t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq create-lockfiles nil)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)
(diminish 'auto-revert-mode)

;; Don't prompt for running process
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (cl-letf (((symbol-function #'process-list) (lambda ())))
    ad-do-it))
(setq kill-buffer-query-functions nil)

;; Make it hard to kill emacs
(setq confirm-kill-emacs #'y-or-n-p)

(setq history-delete-duplicates t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

(setq initial-major-mode 'fundamental-mode)

;; (setq initial-scratch-message "\
;; ℝ𝕖𝕒𝕕𝕪 𝕥𝕠 𝕤𝕖𝕣𝕧𝕖 𝕪𝕠𝕦. 𝕄𝕒𝕤𝕥𝕖𝕣! ")
(setq initial-scratch-message "\

  ██╗   ██╗███████╗███████╗       ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ ██╗
  ╚██╗ ██╔╝██╔════╝██╔════╝       ████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗██║
   ╚████╔╝ █████╗  ███████╗       ██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝██║
    ╚██╔╝  ██╔══╝  ╚════██║       ██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗╚═╝
     ██║   ███████╗███████║▄█╗    ██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║██╗
     ╚═╝   ╚══════╝╚══════╝╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝

  ╦  ┌─┐┌┬┐  ┬─┐┌─┐┌─┐┌┬┐┬ ┬  ┌┬┐┌─┐  ┌─┐┌─┐┬─┐┬  ┬┌─┐  ┬ ┬┌─┐┬ ┬
  ║  ├─┤│││  ├┬┘├┤ ├─┤ ││└┬┘   │ │ │  └─┐├┤ ├┬┘└┐┌┘├┤   └┬┘│ ││ │
  ╩  ┴ ┴┴ ┴  ┴└─└─┘┴ ┴─┴┘ ┴    ┴ └─┘  └─┘└─┘┴└─ └┘ └─┘   ┴ └─┘└─┘o

")

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-verbose t)

(use-package use-package-ensure-system-package :ensure t)
(use-package delight :ensure t)

;; packages
(use-package hippie-expand
  :ensure nil
  :bind ("M-/" . hippie-expand)
  :config
  ;; hippie expand is dabbrev expand on steroids
  (setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill
                                           try-complete-file-name-partially
                                           try-complete-file-name
                                           try-expand-all-abbrevs
                                           try-expand-list
                                           try-expand-line
                                           try-complete-lisp-symbol-partially
                                           try-complete-lisp-symbol)))

(use-package projectile
  :delight " P"
  :bind ("s-p" . projectile-command-map)
  :init
  (setq projectile-completion-system 'helm)
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" azzamsa-savefile-dir))
  (setq projectile-cache-file
        (expand-file-name "projectile.cache" azzamsa-savefile-dir)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package smartparens
  :delight " Sp"
  :bind (:map smartparens-mode-map
              ("C-M-a" . sp-beginning-of-sexp)
              ("C-M-e" . sp-end-of-sexp))
  :preface
  (defun prelude-wrap-with (s)
    "Create a wrapper function for smartparens using S."
    `(lambda (&optional arg)
       (interactive "P")
       (sp-wrap-with-pair ,s)))
  :config
  (define-key smartparens-mode-map (kbd "M-(") (prelude-wrap-with "("))
  (require 'smartparens-config)
  (setq sp-autoskip-closing-pair 'always)
  (setq sp-hybrid-kill-entire-symbol nil)
  (show-smartparens-global-mode +1))

(use-package electric-pair
  :disabled
  :ensure nil
  :commands electric-pair-mode
  :init
  (electric-pair-mode 1))

(use-package abbrev
  :ensure nil
  :defer 3
  :delight " Ab"
  :config
  (setq abbrev-file-name
        (expand-file-name "abbrev.el" azzamsa-savefile-dir))
  (setq save-abbrevs 'silently)
  (setq-default abbrev-mode t))

(use-package company
  :defer 1
  :delight " ⚡"
  :config
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (global-company-mode +1))

(use-package company-quickhelp
  :after company
  :config
  (company-quickhelp-mode)
  (add-hook 'company-mode #'company-quickhelp-mode))

(use-package flycheck
  :defer t)

(use-package undo-tree
  :delight undo-tree-mode
  :bind ("C-x u" . undo-tree-visualize)
  :config
  (setq undo-tree-history-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-diff t)
  (global-undo-tree-mode))

(use-package flyspell
  :defer t
  :delight " ⛿"
  :config
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook 'flyspell-mode))

(use-package flyspell-correct-helm
  :after flyspell
  :bind (:map flyspell-mode-map
              ("C-;" . flyspell-correct-previous-word-generic)))

(use-package uniquify
  :ensure nil
  :defer 2
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  ;; rename after killing uniquified
  (setq uniquify-after-kill-buffer-p t)
  ;; don't muck with special buffers
  (setq uniquify-ignore-buffers-re "^\\*"))

(use-package super-save
  :defer 2
  :delight super-save-mode
  :config
  (add-to-list 'super-save-triggers 'ace-window)
  (add-to-list 'super-save-triggers 'helm)
  (super-save-mode +1))

(use-package rainbow-delimiters
  :defer 3
  :delight rainbow-delimiters-mode)

(use-package rainbow-mode
  :defer 3
  :delight rainbow-mode
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)))

(use-package git-timemachine :defer t)

(use-package windmove
  ;; use shift + arrow keys to switch between visible buffers
  :defer 3
  :config
  (windmove-default-keybindings))

(use-package savehist
  :defer 2
  :config
  (setq savehist-additional-variables
        ;; search entries
        '(search-ring regexp-search-ring)
        ;; save every minute
        savehist-autosave-interval 60
        ;; keep the home clean
        savehist-file (expand-file-name "savehist" azzamsa-savefile-dir))
  (savehist-mode +1))

(use-package saveplace
  ;; saveplace remembers your location in a file when saving files
  :defer 2
  :init (save-place-mode 1)
  :config
  (setq save-place-file (expand-file-name "saveplace" azzamsa-savefile-dir))
  ;; activate it for all buffers
  (setq-default save-place t))

(use-package recentf
  :defer 1
  :config
  (setq recentf-save-file (expand-file-name "recentf" azzamsa-savefile-dir)
        recentf-max-saved-items 500
        recentf-max-menu-items 15
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never)
  (setq recentf-exclude '("/\\.emacs\\.d/documents/brain/"
                          "/\\.emacs\\.d/documents/brain/"
                          "/thought/brain/"
                          "/\\.emacs\\.d/elpa/"
                          "/tmp/"
                          ".jpg" ".png" ".pdf" ".org_archive"
                          "/Email/memail/"))
  (recentf-mode +1))

(use-package crux
  :bind (("C-c w" . crux-swap-windows)
         ("C-a" . crux-move-beginning-of-line)
         ("M-o" . crux-smart-open-line)
         ("s-o" . crux-smart-open-line-above)
         ("C-c r" . crux-rename-buffer-and-file)
         ("C-^" . crux-top-join-line)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-c d" . crux-duplicate-current-line-or-region)
         ("C-c n" . crux-cleanup-buffer-or-region)
         ("C-c TAB" . crux-indent-rigidly-and-copy-to-clipboard)
         ([(shift return)] . crux-smart-open-line)
         ([remap move-beginning-of-line] . crux-move-beginning-of-line))
  :config
  ;; add the ability to cut the current line, without marking it (C-w)
  (require 'rect)
  (crux-with-region-or-line kill-region))

(use-package aza-scripts
  :ensure-system-package mpv
  :load-path "/aza-packages/"
  :bind (("C-c k" . aza-kill-other-buffers)
         ("C-c t" . aza-today)
         ("C-c i" . insert-filename-as-heading)))

;; temporarily highlight changes from yanking, etc
(use-package volatile-highlights
  :defer 3
  :delight volatile-highlights-mode
  :config
  (volatile-highlights-mode +1)
  :custom-face
  (vhl/default-face ((t (:background "#688060")))))

(use-package anzu
  :delight anzu-mode
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode))

(use-package easy-kill
  :demand t
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark))

(use-package move-text
  :defer 3
  :bind
  (([(meta shift up)] . move-text-up)
   ([(meta shift down)] . move-text-down)))

(use-package midnight
  ;; clean up obsolete buffers automatically
  :defer 3)

(use-package ace-window
  :bind ("s-b" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (global-set-key [remap other-window] 'ace-window)
  (setq aw-background nil)
  :custom-face
  (aw-leading-char-face
        ((t
          (:box
           (:line-width 3 :color "lemon chiffon" :style released-button)
           :height 2.0)))))

(use-package zop-to-char
  :bind (("M-z" . zop-up-to-char)
         ("M-Z" . zop-to-char)))

(use-package ediff
  :defer t
  :config
  ;; ediff - don't start another frame
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  ;; put windows side by side
  (setq ediff-split-window-function (quote split-window-horizontally)))

(use-package eyebrowse
  :disabled
  :defer t
  :init
  (setq eyebrowse-keymap-prefix (kbd "C-c M-e"))
  (global-unset-key (kbd "C-c C-w"))
  :bind ("C-\"" . eyebrowse-last-window-config)
  :config
  (eyebrowse-mode t)
  :custom
  (eyebrowse-switch-back-and-forth t)
  (eyebrowse-new-workspace t))

(use-package bookmark
  :config
  (setq bookmark-default-file (expand-file-name "bookmarks" azzamsa-savefile-dir)
        bookmark-save-flag 1))

(use-package desktop
  :defer 2
  :config
  (setq desktop-path (list azzamsa-savefile-dir))
  (setq desktop-dirname azzamsa-savefile-dir)
  (setq desktop-restore-eager 5)
  (setq adesktop-load-locked-desktop t)
  (desktop-save-mode +1))

(use-package desktop+
  ;; additional package to save term/shell buffers
  :after desktop
  )

(use-package avy
  :bind (("s-." . avy-goto-word-or-subword-1)
         ("s-," . avy-goto-char-timer))
  :config
  (global-set-key (kbd "M-g g") 'avy-goto-line)
  (setq avy-background t)
  (setq avy-style 'at-full))

(use-package spinner :defer t)

(use-package async
  :defer 3
  :config
  (async-bytecomp-package-mode t)

  (defun my/dired-async-message-function (text _face &rest args)
    "Log messages from dired-async to messages buffer."
    ;; For whatever reason, the default for this *doesn't* log it to
    ;; *Messages*.  Instead, it just displays the notification in the
    ;; mode line for 3 seconds, but if you type something it
    ;; immediately goes away.  So just log it to *Messages* like a sane
    ;; person instead:
    (message (format "Finished %s" (apply #'format text args))))
  ;; do dired actions asynchronously
  (dired-async-mode)
  :custom
  (dired-async-message-function #'my/dired-async-message-function))

(use-package with-editor
  :defer t)

(use-package auto-capitalize
  :defer 3
  :delight " Ac"
  :load-path "elisp/auto-capitalize"
  :config
  (add-hook 'text-mode-hook 'turn-on-auto-capitalize-mode))

(use-package alert
  :defer 3
  :custom (alert-default-style 'libnotify))

(use-package visual-line-mode
  :defer t
  :ensure nil
  :config
  (add-hook 'text-mode-hook #'visual-line-mode))

(use-package winner
  :defer 2
  :ensure nil
  :config
  (winner-mode 1))

(use-package paradox
  :defer t
  :config
  (paradox-enable)
  :custom
  (paradox-column-width-package 27)
  (paradox-column-width-version 13)
  (paradox-execute-asynchronously t)
  (paradox-hide-wiki-packages t)
  (paradox-github-token t))

(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-c C-d" . helpful-at-point)
         ("C-h F" . helpful-function)
         ("C-h C" . helpful-command)))

(use-package origami
  :bind (:map origami-mode-map
              ("C-: :" . origami-recursively-toggle-node)
              ("C-: a" . origami-toggle-all-nodes)
              ("C-: t" . origami-toggle-node)
              ("C-: o" . origami-show-only-node)
              ("C-: C-r" . origami-reset)))

(use-package whitespace
  :delight whitespace-mode
  :defer 3
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  ;; clean up handled by ws-butler
  ;;(add-hook 'before-save-hook #'whitespace-cleanup)
  :config
  ;; limit line length
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face tabs trailing lines-tail)))

(use-package ws-butler
  ;; clean only edited lines
  :defer 3
  :config
  (ws-butler-global-mode t))

(use-package multiple-cursors
  :defer 3
  :init
  (setq mc/list-file (expand-file-name ".mc-lists.el" azzamsa-savefile-dir))
  ;; these need to be defined here - if they're lazily loaded with
  ;; :bind they don't work.
  (global-set-key (kbd "C-c .") 'mc/mark-next-like-this)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-c ,") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(use-package request
  :defer t
  :config
  (setq request-storage-directory
        (expand-file-name "request/" azzamsa-savefile-dir)))

;;------------------------------------------------
;; Modules
;;------------------------------------------------
(require 'aza-themes)
(require 'aza-dired)
(require 'aza-helm)
(require 'aza-shell)
(require 'aza-hydra)

;; writing
(require 'aza-org)
(require 'aza-latex)
(require 'aza-markdown)

;;; programming modules
(require 'aza-common-lisp)
(require 'aza-emacs-lisp)
(require 'aza-java)
(require 'aza-python)
(require 'aza-web)
(require 'aza-rust)
(require 'aza-go)
(require 'aza-xml)
(require 'aza-php)

;;; emacs is home
(require 'aza-home)
(require 'aza-erc)
(require 'aza-mu4e)
(require 'aza-fun)

;; emacs fix
(require 'aza-emacs-fix)

;; emacs enhancements
(require 'aza-emacs-enhc)

;; my packages
(require 'aza-scripts)

;; unpublished configuration
(when (file-exists-p (expand-file-name "aza-local.el" azzamsa-modules-dir))
  (require 'aza-local))

;;------------------------------------------------
;; Core
;;------------------------------------------------
(require 'aza-ui)
(require 'aza-global-keybinding)
(require 'aza-programming)

;;------------------------------------------------
;; Misc
;;------------------------------------------------
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox-dev")

(setq url-cache-directory
      (expand-file-name "url/cache/" azzamsa-savefile-dir))
(setq url-configuration-directory
      (expand-file-name "url/configuration/" azzamsa-savefile-dir))

;; I hate that custom fruit
(setq custom-file (expand-file-name "custom.el" azzamsa-savefile-dir))
(setq tramp-persistency-file-name
      (expand-file-name "tramp-persistency.el" azzamsa-savefile-dir))

(when (file-exists-p custom-file)
  (load custom-file))

;; Run at full power please
(setq disabled-command-function 'ignore)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; diminish
(diminish 'visual-line-mode "Wr")
(diminish 'auto-fill-function "Fl")


;;; init.el ends here
