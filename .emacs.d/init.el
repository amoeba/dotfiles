(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; ui
(tool-bar-mode -11)
(setq inhibit-startup-screen t)

;;; packages
(use-package south-theme
  :vc (:url "https://github.com/SophieBosio/south"
       :rev :newest
       :branch "main"))

;;; font
(set-face-attribute 'default nil :font "JetBrains Mono-13")

;;; theme
(load-theme 'south t)

;;; misc
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; wip project setup
;; Use built-in project.el with custom markers
(use-package project
  :bind (("C-c p f" . project-find-file)
         ("C-c p b" . project-switch-to-buffer)
         ("C-c p p" . project-switch-project))
  :config
  ;; Add common project markers
  (setq project-vc-extra-root-markers
        '(".projectile" "pyproject.toml" "Cargo.toml" 
          "package.json" "go.mod" "Makefile"))
  (project-remember-projects-under "~/src/" t 2)
  )

;; Modern completion UI
(use-package vertico
  :ensure t
  :config (vertico-mode))

(use-package orderless
  :ensure t
  :custom (completion-styles '(orderless)))

;; Enhanced project integration
(use-package consult
  :ensure t
  :bind (("C-c f" . consult-find)      ; File finding with preview
         ("C-c g" . consult-ripgrep))) ; Content search
