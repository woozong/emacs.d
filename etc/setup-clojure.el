;; setup clojure support
;; Packages needed: 
;;     clojure-mode
;;     clojure-test-mode
;;     cider
;;     cider-decompile
;;     cider-tracing
(with-package (clojure-mode
               clojure-test-mode
               cider
               cider-decompile
               cider-tracing
               clj-refactor)

  ;; attach to eldoc
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  ;; activate rainbow delimiters mode
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  ;; make sure clojure-mode uses paredit
  (add-hook 'clojure-mode-hook 'paredit-mode)
  ;;(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
  ;;(add-hook 'cider-repl-mode-hook (lambda () (paredit-mode 1)))

  ;; limit repl print-length for collections.. max 100 items
  (setq cider-repl-print-length 100)
  ;; prefix all repl-result output
  (setq cider-repl-result-prefix ";; => ")
  ;; Enable error buffer popping also in the REPL:
  (setq cider-repl-popup-stacktraces t)
  ;; Prevent the auto-display of the REPL buffer in a separate window after connection is established
  (setq cider-repl-pop-to-buffer-on-connect nil)
  ;; prefix interactive eval result output
  (setq cider-interactive-eval-result-prefix ";; => ")
  ;; Specify history file
  (setq cider-history-file "~/.emacs.d/nrepl-history")
  ;; auto-select the error buffer when it's displayed
  (setq cider-auto-select-error-buffer t)
  ;; show repl connection port
  (setq nrepl-buffer-name-show-port t)
  ;; Hide nrepl buffers when switching buffers (switch to by prefixing with space)
  (setq nrepl-hide-special-buffers t)
  ;; Indent and highlight more commands
  (put-clojure-indent 'match 'defun)

  (defadvice clojure-test-run-tests (before save-first activate)
    (save-buffer))

  (defadvice nrepl-load-current-buffer (before save-first activate)
    (save-buffer))

)

(provide 'setup-clojure)
