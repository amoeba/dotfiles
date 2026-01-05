
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; ui
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

;;; font
(set-face-attribute 'default nil :font "JetBrains Mono-13")

;;; projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (("C-c p" . projectile-command-map))
  :config
  (setq projectile-project-search-path '("~/src/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(projectile vertico pulsar orderless multiple-cursors expand-region consult)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
