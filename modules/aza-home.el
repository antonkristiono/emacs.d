;;------------------------------------------------
;; Emacs is a home
;;------------------------------------------------

(use-package pomodoro
  :defer t
  :load-path "~/emacs-packages/pomodoro.el/"
  :commands pomodoro-start
  :config
  (setq pomodoro-show-number t)
  (setq pomodoro-long-break-time 20)
  (setq pomodoro-work-time 25)
  (setq pomodoro-break-time 5)
  (setq pomodoro-sound-player "/usr/bin/mpv")
  (setq pomodoro-break-start-sound
        "~/sounds/ding-rest-long.mp3")
  (setq pomodoro-work-start-sound
        "~/sounds/coin-work-long.mp3")
  (pomodoro-add-to-mode-line))

(use-package pdf-tools
  :defer t
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install))

(use-package mingus
  :ensure-system-package mpd
  :defer t)

(use-package org-brain
  :defer t
  :init
  (setq org-brain-path "~/.emacs.d/documents/brain")
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 30))

(use-package presentation
  :defer t)

(use-package keyfreq
  :defer 3
  :config
  (setq keyfreq-file (expand-file-name "emacs.keyfreq" aza-savefile-dir))
  (setq keyfreq-file-lock (expand-file-name "emacs.keyfreq.lock" aza-savefile-dir))
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(use-package pelican-mode
  :pin manual
  :commands pelican-mode
  :load-path "~/emacs-packages/pelican-mode/"
  :config
  (pelican-global-mode))

(use-package atomic-chrome
  :defer t
  :config
  (setq atomic-chrome-url-major-mode-alist
        '(("github\\.com" . gfm-mode)))
  (atomic-chrome-start-server))

(use-package emojify
  :hook
  ((markdown-mode . emojify-mode)
   (git-commit-mode . emojify-mode)
   (magit-status-mode . emojify-mode)
   (magit-log-mode . emojify-mode)
   (org-mode . emojify-mode))
  :config
  (setq emojify-emoji-styles '(github unicode))
  (setq emojify-emojis-dir
        (expand-file-name "emojify/"  aza-savefile-dir)))

(use-package chronos
  :pin manual
  :defer t
  :load-path "~/emacs-packages/chronos/"
  :config
  (setq chronos-shell-notify-program "mpv"
        chronos-shell-notify-parameters '("--really-quiet"
                                          "--af=scaletempo=speed=pitch"
                                          "--speed=0.65"
                                          "~/sounds/early-sunrise-yey.wav")
        chronos-text-to-speech-program "espeak-ng"
        chronos-text-to-speech-program-parameters '("-s 100"
                                                    "-v mb-id1")
        chronos-expiry-functions '(chronos-dunstify
                                   chronos-buffer-notify
                                   chronos-shell-notify
                                   chronos-text-to-speech-notify)))

(use-package define-word
  :defer t)

(use-package salah-time
  :defer t
  :load-path "~/emacs-packages/salah-time"
  :commands salah-time
  :config
  (setq salah-time-city "Malang"))

(use-package google-translate
  :defer t
  :commands google-translate-smooth-translate
  :init
  (require 'google-translate-smooth-ui)
  (setq google-translate-translation-directions-alist
        '(("en" . "id") ("id" . "en")))
  (setq google-translate-output-destination nil)
  (setq google-translate-pop-up-buffer-set-focus t)
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "id"))

(provide 'aza-home)
