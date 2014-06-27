;; Add in custom config files
(add-to-list 'load-path "~/.emacs.d/config/")


;; source: http://nex-3.com/posts/45-efficient-window-switching-in-emacs#comments
(defvar real-keyboard-keys
  '(("M-<up>"        . "[1;9A")
	("M-<down>"      . "[1;9B")
	("M-<right>"     . "[1;9C")
	("M-<left>"      . "[1;9D")

	("M-shift-<up>"        . "[1;10A")
	("M-shift-<down>"      . "[1;10B")
	("M-shift-<right>"     . "[1;10C")
	("M-shift-<left>"      . "[1;10D")

	("C-<return>"    . "")
	("C-<delete>"    . "")
	("C-<up>"        . "\M-[1;5A")	; broken in xterm w. osx
	("C-<down>"      . "\M-[1;5B")
	("C-<right>"     . "\M-[1;5C")
	("C-<left>"      . "\M-[1;5D"))
  "An assoc list of pretty key strings
and their terminal equivalents.")

(defun key (desc)
  (or (and window-system (read-kbd-macro desc))
	  (or (cdr (assoc desc real-keyboard-keys))
		  (read-kbd-macro desc))))

(global-set-key (key "M-<left>") 'windmove-left)          ; move to left windnow
(global-set-key (key "M-<right>") 'windmove-right)        ; move to right window
(global-set-key (key "M-<up>") 'windmove-up)              ; move to upper window
(global-set-key (key "M-<down>") 'windmove-down)          ; move to lower window


(global-set-key "4" 'windmove-left)          ; move to left windnow [alt keybinding]
(global-set-key "6" 'windmove-right)        ; move to right window [alt keybinding]
(global-set-key "8" 'windmove-up)              ; move to upper window [alt keybinding]
(global-set-key "2" 'windmove-down)          ; move to lower window [alt keybinding]

(global-set-key (kbd "M-<left>") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "M-<right>") 'windmove-right)        ; move to right window
(global-set-key (kbd "M-<up>") 'windmove-up)              ; move to upper window
(global-set-key (kbd "M-<down>") 'windmove-down)          ; move to lower window

;; (global-set-key (key "M-shift-<left>") 'previous-buffer)          ; move to left windnow
;; (global-set-key (key "M-shift-<right>") 'next-buffer)        ; move to right window
;; (global-set-key (key "M-shift-<up>") 'windmove-up)              ; move to upper window
;; (global-set-key (key "M-shift-<down>") 'windmove-down)          ; move to lowner window

;; Keybinding for "recompile"
;; If a previous compile exists for the buffer, run it. If not, run M-x compile
(global-set-key [(control c) (c)] 'compile-again)
(setq compilation-last-buffer nil)
(defun compile-again (pfx)
 (interactive "p")
 (if (and (eq pfx 1)
		compilation-last-buffer)
	 (progn
	   (set-buffer compilation-last-buffer)
	   (revert-buffer t t))
   (call-interactively 'compile)))

;; Keybinding for "replace-string"
(global-set-key (kbd "\C-c r") 'replace-string)

;; Custom C-mode
(defun my-c-mode-hook ()
  (linum-mode 1)
  (which-function-mode 1)
  (flymake-mode 1)
  (setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../ ")
  (require 'c-eldoc)
  (load "c-eldoc"))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;; Webmode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; Associated customizations -- see http://web-mode.org/
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))
(add-hook 'web-mode-hook  'web-mode-hook)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-indent-style 2)
(setq web-mode-comment-style 2)
(set-face-attribute 'web-mode-css-rule-face nil :foreground "Pink3")
(define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
(add-to-list 'web-mode-snippets '("mydiv" "<div>" "</div>"))
(setq web-mode-disable-auto-pairing t)
(setq web-mode-disable-css-colorization t)
(setq web-mode-enable-block-faces t)
(setq web-mode-enable-heredoc-fontification t)


;; And set some global  options
(require 'flymake)
;; (require 'guess-offset)
;; (setq column-number-mode t)
(require 'install-elisp)
(require 'revive)
(require 'windows)
(require 'flymake-cursor)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; stuff for git
(require 'magit)

;; Python
(setq py-python-command "python3")

(defun my-python-hook ()
  (setq flycheck-highlighting-mode 'lines)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (autoload 'pylint "pylint")
  'pylint-add-menu-items
  'pylint-add-key-bindings
  (setq column-enforce-mode t))


;; (add-hook 'python-mode-hook 'pylint-add-menu-items)
;; (add-hook 'python-mode-hook 'pylint-add-key-bindings)
(add-hook 'python-mode-hook 'my-python-hook)
;; (add-hook 'python-mode-hook 'column-enforce-mode)
;; (setq elpy-rpc-python-command "/usr/bin/python3")



(package-initialize)
;; (elpy-enable)
;; (elpy-use-ipython)
;; (elpy-clean-modeline)

;; Latex
(require 'latex-pretty-symbols)
(eval-after-load 'latex '(latex/setup-keybinds))

(require 'ac-math)

(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
		(append '(ac-source-math-unicode
				  ac-source-math-latex
				  ac-source-latex-commands)
				ac-sources)))
(add-hook 'latex-mode-hook 'ac-latex-mode-setup)


(add-hook 'LaTeX-mode-hook (lambda () (flyspell-mode 1)))

;; Themes
(require 'solarized)
(load-theme 'solarized-dark t)


;; Package repos
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	'("marmalade" .
	  "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Tabs
;; (autoload 'smart-tabs-mode "smart-tabs-mode"
;;   "Intelligently indent with tabs, align with spaces!")
;; (autoload 'smart-tabs-mode-enable "smart-tabs-mode")
;; (autoload 'smart-tabs-advice "smart-tabs-mode")
;; (autoload 'smart-tabs-insinuate "smart-tabs-mode")

;; (smart-tabs-add-language-support sml sml-mode-hook
;;   ((sml-indent-line . sml-basic-offset)
;;    (sml-indent-region . sml-basic-offset)))

;; (smart-tabs-insinuate 'c 'c++ 'java 'sml)

;; Stupid indentation
(require 'stupid-indent-mode)


;; SML stuff
(defun my-sml-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq stupid-indent-mode t)
  (setq sml-electric-pipe-mode nil)
  (add-to-list 'compilation-error-regexp-alist
			   '("^\\([^[ ]*?\\):\\([[:digit:]]+\\).\\([[:digit:]]+\\)-[[:digit:]]+.[[:digit:]]+ "
				 1 2 3 nil 2)))


(require 'compile)
(add-hook 'sml-mode-hook 'my-sml-mode-hook)


;; Moving autosave files out of the current folder
(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

;; Actions to perform on loss of focus
(defun on-lose-focus ()
  (interactive)
  (save-buffer)
  (delete-trailing-whitespace))

(add-hook 'switch-frame 'on-lose-focus)


;; Java settings -- broken
;; (require 'eclim)
;; (require 'eclimd)
;; (custom-set-variables
;;  '(eclim-eclipse-dirs '("/opt/eclipse"))
;;  '(eclim-executable '("/opt/eclipse/eclim"))
;;  '(eclimd-executable '("opt/eclipse/eclimd")))

;; (defun my-java-mode-hook ()
;;   (eclim-mode 1))
;; (add-hook 'java-mode-hook 'my-java-mode-hook)


(require 'auto-complete-config)
(ac-config-default)
;; (require 'ac-emacs-eclim-source)
;; (require 'company)
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)
;; (add-hook 'after-init-hook 'global-company-mode)

;; Haxe
(require 'haxe-mode)

;; Typescript
;; https://github.com/aki2o/emacs-tss


;; If use bundled typescript.el,
(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(require 'tss)

;; Key binding
(setq tss-popup-help-key "C-:")
(setq tss-jump-to-definition-key "C->")

;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "tss")

;; Do setting recommemded configuration
(tss-config-default)

(defun my-typescript-mode-hook ()
  (setq company-mode nil))

(add-hook 'typescript-mode-hook 'my-typescript-mode-hook)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
