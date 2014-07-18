;; Don't be so stingy on the memory, we have lots now. It's the distant future.
(setq gc-cons-threshold 20000000)

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; default major mode for new buffers
(setq-default major-mode 'text-mode)
;; Lines should be 80 characters wide, not 72
(setq fill-column 80)
;; 80 chars is a good width.
(set-default 'fill-column 80)
;; set up smooth-scrolling
(with-package smooth-scrolling
  (setq smooth-scroll-margin 3))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name (concat user-emacs-directory "backups")))))
;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Save a list of recent files visited. (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 100) ;; just 20 is too recent

;; Save minibuffer history
(savehist-mode 1)
(setq history-length 1000)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Transparently open compressed files
(auto-compression-mode t)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; y/n will do...
(defalias 'yes-or-no-p 'y-or-n-p)

;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t) 
(setq auto-revert-verbose nil)
; Show keystrokes in progress
(setq echo-keystrokes 0.1)
; Move files to trash when deleting
(setq delete-by-moving-to-trash t)
; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)
; Don't highlight matches with jump-char - it's distracting
(setq jump-char-lazy-highlight-face nil)
; Always display line & column numbers
(setq line-number-mode t)
(setq column-number-mode t)
;; Never insert tabs
(set-default 'indent-tabs-mode nil)
;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)
;; Don't break lines for me, please
(setq-default truncate-lines t)
;; Allow recursive minibuffers
(setq enable-recursive-minibuffers t)
;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)

;; Show active region
;(transient-mark-mode 1)
;(make-variable-buffer-local 'transient-mark-mode)
;(put 'transient-mark-mode 'permanent-local t)
;(setq-default transient-mark-mode t)

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

;; Easily navigate sillycased words
(global-subword-mode 1)

;; Represent undo-history as an actual tree (visualize with C-x u)
(setq undo-tree-mode-lighter "")
(require 'undo-tree)
(global-undo-tree-mode)

;; Add parts of each file's directory to the buffer name if not unique
(with-package* uniquify
  (setq uniquify-buffer-name-style 'forward))

;; A saner ediff
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
;; that you can always see what's happening.
(setq eval-expression-print-level nil)

;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      ad-do-it
      ad-do-it
      ad-do-it)
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

(provide 'generic-defaults)
