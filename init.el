;;; -*- lexical-binding: t; -*-

;; (package-initialize)

(setq gc-cons-threshold 100000000) ; 100 mb
(add-hook 'focus-out-hook 'garbage-collect)

;; Separate package directories according to Emacs version.
;; Bytecode compiled in different Emacs versions are not
;; guaranteed to work with another.
(setq package-user-dir
      (format "%selpa/%s/" user-emacs-directory emacs-major-version))

(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Disable in favor of `use-package'.
(setq package-enable-at-startup nil)

;; Package Repositories
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

;; Activate all packages (in particular autoloads).
(package-initialize)

;; Auto downloads packages from mepla
;; diminish is does not come with 'use-package' any
;; has to be installed manually
(require 'cl-lib)
(defvar my-packages
  '(diminish)
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  (cl-loop for p in my-packages
           when (not (package-installed-p p)) do (cl-return nil)
           finally (cl-return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; M-x list-packages U x to upgrade packages.
(setq package-list '(diminish))

;; Bootstrap `use-package'.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
  (require 'diminish) ; for :diminish
  (require 'bind-key) ; for :bind

;; Install package if not existing.
(setq use-package-always-ensure nil)

;; Check loading times with `use-package'.
(setq use-package-verbose t)

;; Fetch the list of packages when unavailable.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Install any missing packages.
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; Start daemon automatically.
(add-hook 'after-init-hook (lambda ()
                             (load "server") ;; server-running-p is not autoloaded.
                             (unless (server-running-p)
                               (server-start))))

;; Config
(use-package yzm-autocompletion :ensure nil)
(use-package yzm-keybindings :ensure nil)
(use-package yzm-mouse :ensure nil)
(use-package yzm-theme :ensure nil)
(use-package yzm-git :ensure nil)
(use-package yzm-slime :ensure nil)
(use-package yzm-evil :ensure nil)
(use-package yzm-documents :ensure nil)
;; Lang
(use-package yzm-elixir :ensure nil)
(use-package yzm-latex :ensure nil)
(use-package yzm-lisp :ensure nil)
(use-package yzm-lua :ensure nil)
(use-package yzm-web :ensure nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "b550fc3d6f0407185ace746913449f6ed5ddc4a9f0cf3be218af4fb3127c7877" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (evil-magit preview-latex auctex pdf-tools ni all-the-icons-dired slime malinka ws-butler rtags dummy-h-mode flycheck-pos-tip flycheck company-quickhelp company projectile smex ivy expand-region typescript-mode tide add-node-modules-path clang-format company-ycmd ycmd counsel solarized-theme use-package))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
