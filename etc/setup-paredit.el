;; My keybindings for paredit
(with-package paredit

  (require 'dash)

  (defun paredit-wrap-round-from-behind ()
    (interactive)
    (forward-sexp -1)
    (paredit-wrap-round)
    (insert " ")
    (forward-char -1))

  (defun paredit-wrap-square-from-behind ()
    (interactive)
    (forward-sexp -1)
    (paredit-wrap-square))

  (defun paredit-wrap-curly-from-behind ()
    (interactive)
    (forward-sexp -1)
    (paredit-wrap-curly))

  (defun paredit-kill-region-or-backward-word ()
    (interactive)
    (if (region-active-p)
        (kill-region (region-beginning) (region-end))
      (paredit-backward-kill-word)))

  (add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))

  (define-key paredit-mode-map (kbd "M-(") 'paredit-wrap-round)
  (define-key paredit-mode-map (kbd "M-)") 'paredit-wrap-round-from-behind)
  (define-key paredit-mode-map (kbd "M-s-8") 'paredit-wrap-square)
  (define-key paredit-mode-map (kbd "M-s-9") 'paredit-wrap-square-from-behind)
  (define-key paredit-mode-map (kbd "M-s-(") 'paredit-wrap-curly)
  (define-key paredit-mode-map (kbd "M-s-)") 'paredit-wrap-curly-from-behind)
  (define-key paredit-mode-map (kbd "C-w") 'paredit-kill-region-or-backward-word)
  (define-key paredit-mode-map (kbd "C-M-<backspace>") 'backward-kill-sexp)

  ;; making paredit work with delete-selection-mode
  (put 'paredit-forward-delete 'delete-selection 'supersede)
  (put 'paredit-backward-delete 'delete-selection 'supersede)
  (put 'paredit-newline 'delete-selection t))

(provide 'setup-paredit)
