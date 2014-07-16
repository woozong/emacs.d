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
;     move-text
;     gist
;     htmlize
;     visual-regexp
;     flycheck
;     flx
;     flx-ido
     css-eldoc
;     yasnippet
     smartparens
     ido-vertical-mode
     ido-at-point
;     simple-httpd
;     guide-key
;     nodejs-repl
;     restclient
;     highlight-escape-sequences
;     whitespace-cleanup-mode
;     elisp-slime-nav
     git-commit-mode
     gitconfig-mode
     gitignore-mode
;     groovy-mode
;     prodigy
;;     textile-mode
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


;; set e-mail address
(setq user-mail-address "geertv@surfspot.be")

;; default major mode for new buffers
(setq-default major-mode 'text-mode)

;; ok, we want to be in utf-8
(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; set up package repository
(require 'package)
(add-to-list 'package-archives
             '(;; "marmalade" . "http://marmalade-repo.org/packages/"
               "MELPA"        . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; packages to install
(setq package-list 
      '(paredit
        rainbow-delimiters
))

(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; set up smooth-scrolling
(require 'smooth-scrolling)
(setq smooth-scroll-margin 3)

;; setup eldoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; rainbow delimiters
(require 'rainbow-delimiters)

;; Clojure
(load-library "clojure-init")
;; Common Lisp
(load-library "lisp-init")

