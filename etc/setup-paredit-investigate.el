  ;; Change nasty paredit keybindings
  (defvar my-nasty-paredit-keybindings-remappings
    '(("M-s"         "s-s"         paredit-splice-sexp)
      ("M-<up>"      "s-<up>"      paredit-splice-sexp-killing-backward)
      ("M-<down>"    "s-<down>"    paredit-splice-sexp-killing-forward)
      ("C-<right>"   "s-<right>"   paredit-forward-slurp-sexp)
      ("C-<left>"    "s-<left>"    paredit-forward-barf-sexp)
      ("C-M-<left>"  "s-S-<left>"  paredit-backward-slurp-sexp)
      ("C-M-<right>" "s-S-<right>" paredit-backward-barf-sexp)))

  (define-key paredit-mode-map (kbd "s-r") 'paredit-raise-sexp)

  (--each my-nasty-paredit-keybindings-remappings
          (let ((original (car it))
                (replacement (cadr it))
                (command (car (last it))))
            (define-key paredit-mode-map (read-kbd-macro original) nil)
            (define-key paredit-mode-map (read-kbd-macro replacement) command)))

  ;; don't hijack \ please
  (define-key paredit-mode-map (kbd "\\") nil)

  ;; Enable `paredit-mode' in the minibuffer, during `eval-expression'.
  (defun conditionally-enable-paredit-mode ()
    (if (eq this-command 'eval-expression)
        (paredit-mode 1)))

  (add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode)

  ;; functions in smartparens that do not have an equivalent in paredit - take a look at them
  (when nil
    '(sp-beginning-of-sexp
      sp-end-of-sexp
      sp-next-sexp
      sp-previous-sexp
      sp-kill-sexp
      sp-unwrap-sexp
      sp-backward-unwrap-sexp
      sp-select-next-thing-exchange
      sp-select-next-thing
      sp-forward-symbol
      sp-backward-symbol))
