(defvar my-backup-dir (expand-file-name "~/.ceback"))
(unless (file-exists-p my-backup-dir)
  (make-directory my-backup-dir t))

(setq backup-directory-alist `(("." . ,my-backup-dir))
      auto-save-file-name-transforms `((".*" ,(concat my-backup-dir "/") t))
      auto-save-list-file-prefix (concat my-backup-dir "/saves-"))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://www.mirrorservice.org/sites/melpa.org/packages/") t) ;; mirror for my region(russia)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; theme, i prefer doom-themes.
(unless (package-installed-p 'doom-themes)
  (package-install 'doom-themes))
(load-theme 'doom-vibrant t)
(doom-themes-org-config)

;; binds.
(global-set-key (kbd "C-c l") 'kill-current-buffer)
(global-set-key (kbd "C-o") 'find-file)

;; setup for rustic.
(use-package rustic
  :ensure t
  :config
  (setq rustic-lsp-client 'eglot)
  (setq rustic-format-on-save t))
