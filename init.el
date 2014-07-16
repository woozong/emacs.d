;; woozong's own emacs init file
;; there (probably) be dragons here..
;;
;; stuff in here was shamelessly grabbed from various sources: 
;;   https://github.com/cjohansen/.emacs.d
;;

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Set up appearance
(require 'appearance)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(magit
     paredit
     clojure-mode
     clojure-test-mode
     cider
     cider-decompile
     cider-tracing
     smooth-scrolling
     markdown-mode
     css-eldoc
     smartparens
     ido-vertical-mode
     ido-at-point
     git-commit-mode
     gitconfig-mode
     gitignore-mode
     rainbow-delimiters
     guide-key
;     move-text
;     gist
;     htmlize
;     visual-regexp
;     flycheck
;     flx
;     flx-ido
;     yasnippet
;     simple-httpd
;     nodejs-repl
;     restclient
;     highlight-escape-sequences
;     whitespace-cleanup-mode
;     elisp-slime-nav
;     groovy-mode
;     prodigy
;     textile-mode
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; set up load paths for configuration paths and libraries
;(add-to-list 'load-path user-emacs-directory)
;(add-to-list 'load-path "~/.emacs.d/clojure/")
;(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Lets start with a smattering of sanity
(require 'sane-defaults)

;; guide-key
(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)

;; rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Setup extensions
(eval-after-load 'ido '(require 'setup-ido))
;(eval-after-load 'org '(require 'setup-org))
;(eval-after-load 'dired '(require 'setup-dired))
;(eval-after-load 'magit '(require 'setup-magit))
;(eval-after-load 'grep '(require 'setup-rgrep))
;(eval-after-load 'shell '(require 'setup-shell))
;(require 'setup-hippie)
;(require 'setup-yasnippet)
;(require 'setup-perspective)
;(require 'setup-ffip)
;(require 'setup-html-mode)
;(require 'setup-paredit)

;; set e-mail address
(setq user-mail-address "geertv@surfspot.be")

;; setup eldoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; Clojure
;(load-library "clojure-init")
;; Common Lisp
;(load-library "lisp-init")

