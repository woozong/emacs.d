;; woozong's emacs init file
;; there (probably) be dragons here..

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; turn off all the annoying stuff
(setq inhibit-splash-screen t
      inhibit-startup-message t)

;; Set path to dependencies:
;;     etc is my own stuff
;;     opt is stuff I downloaded from somewhere
(setq etc-dir (expand-file-name "etc" user-emacs-directory))
(setq opt-dir (expand-file-name "opt" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path etc-dir)
(add-to-list 'load-path opt-dir)

;; Add external projects to load path
(dolist (project (directory-files opt-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "emacs-custom.el" etc-dir))
(load custom-file)

;;; Packages
(require 'package)
(require 'package-helper)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-enable-at-startup nil)
;(setq package-blacklist '(batch-mode))
(package-initialize)

;; setup generic defaults
(require 'generic-defaults)

;; setup emacs appearance
(require 'appearance)

;; Install packages not needing configuration
(with-package (s))

;; setup ido
(require 'setup-ido)

;; setup paredit
(require 'setup-paredit)

;; setup clojure
(require 'setup-clojure)

;; Setup packages
;(require 'setup-package)

;; Install extensions if they're missing
;(defun init--install-packages ()
;  (packages-install
;   '(magit
;     paredit
;     smooth-scrolling
;     markdown-mode
;     css-eldoc
;     smartparens
;     ido-vertical-mode
;     ido-at-point
;     git-commit-mode
;     gitconfig-mode
;     gitignore-mode
;     rainbow-delimiters
;     guide-key
;     noctilux-theme
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
;     )))

;; guide-key
;(require 'guide-key)
;(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +"))
;(guide-key-mode 1)
;(setq guide-key/recursive-key-sequence-flag t)
;(setq guide-key/popup-window-position 'bottom)

;; Setup extensions
;(eval-after-load 'ido '(require 'setup-ido))
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
;(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
;(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
;(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; Clojure
;(load-library "clojure-init")
;; Common Lisp
;(load-library "lisp-init")

