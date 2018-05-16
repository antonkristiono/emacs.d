(use-package virtualenvwrapper
  :ensure t
  :defer t
  :init
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

(use-package elpy
  :ensure t
  :bind ("C-l" . elpy-shell-clear-shell)
  :preface
  (defun elpy-shell-clear-shell ()
    "Clear the current shell buffer."
    (interactive)
    (with-current-buffer (process-buffer (elpy-shell-get-or-create-process))
      (comint-clear-buffer)))
  :config
  (use-package company-jedi
    :ensure t)
  (elpy-enable)
  (add-hook 'python-mode-hook
            (lambda ()
              (company-mode t)
              (company-jedi t))))

(provide 'aza-python)
