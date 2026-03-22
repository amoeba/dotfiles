;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;; ui
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :font "JetBrains Mono-13")

;;; projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (("C-c p" . projectile-command-map))
  :config
  (setq projectile-project-search-path '("~/src/"))
  (setq projectile-project-search-depth 3))

;; vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

;; corfu
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1))

;; marginalia
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

;; which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; magit
(use-package magit
  :ensure t)

tin
