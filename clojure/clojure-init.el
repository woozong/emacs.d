;; clojure init file

;; make sure clojure-mode uses paredit
(add-hook 'clojure-mode-hook 'paredit-mode)
;; attach to eldoc
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;; show repl connection port
(setq nrepl-buffer-name-show-port t)
;; limit repl print-length for collections.. max 100 items
(setq cider-repl-print-length 100)
;; prefix all repl-result output
(setq cider-repl-result-prefix ";; => ")
;; prefix interactive eval result output
(setq cider-interactive-eval-result-prefix ";; => ")

;; activate rainbow delimiters mode
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

