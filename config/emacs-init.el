;; -*- mode: elisp -*-

(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/elpa/use-package-20210201.1739")
  (require 'use-package))

(setq inhibit-splash-screen t)
(transient-mark-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE" "DEFERRED")))
(setq org-M-RET-may-split-line
      '((default . nil)))
(use-package plantuml-mode
  :init
    (setq plantuml-default-exec-mode 'jar)
    (setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
    (setq org-plantuml-jar-path (expand-file-name "/home/jz/.local/bin/plantuml.jar"))
    (setq org-startup-with-inline-images t)
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
    (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t))))
(org-babel-do-load-languages
 'org-babel-load-languages '(
			     (plantuml . t)
			     (shell . t)
			     (python . t)
			     (fsharp . t)
			     (dot . t)
			     (gnuplot . t)
			     (haskell . t)
			     (sql . t)
			     )
 )

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (plantuml . t)
   )
 )
(setq org-confirm-babel-evaluate nil)
(save-place-mode 1)
(require 'org-id)
(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
(defun eos/org-custom-id-get (&optional pom create prefix)
  "Get the CUSTOM_ID property of the entry at point-or-marker POM.
   If POM is nil, refer to the entry at point. If the entry does
   not have an CUSTOM_ID, the function returns nil. However, when
   CREATE is non nil, create a CUSTOM_ID if none is present
   already. PREFIX will be passed through to `org-id-new'. In any
   case, the CUSTOM_ID of the entry is returned."
  (interactive)
  (org-with-point-at pom
    (let ((id (org-entry-get nil "CUSTOM_ID")))
      (cond
       ((and id (stringp id) (string-match "\\S-" id))
        id)
       (create
        (setq id (org-id-new (concat prefix "h")))
        (org-entry-put pom "CUSTOM_ID" id)
        (org-id-add-location id (buffer-file-name (buffer-base-buffer)))
        id)))))

(defun eos/org-add-ids-to-headlines-in-file ()
  "Add CUSTOM_ID properties to all headlines in the
   current file which do not already have one."
  (interactive)
  (org-map-entries (lambda () (eos/org-custom-id-get (point) 'create))))
(add-to-list 'load-path "~/.emacs.d/lisp/")
;;; Initialize MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-solarized-light))
 '(custom-safe-themes
   '("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))
 '(helm-mode t)
 '(lsp-keymap-prefix "C-c C-l")
 '(org-agenda-prefix-format
   '((agenda . " %i %-16c%?-12t% s")
     (todo . " %i %-12:c")
     (tags . " %i %-12:c")
     (search . " %i %-12:c")))
 '(package-selected-packages
   '(org-journal editorconfig flymake-diagnostic-at-point yaml-mode lsp-ui rotate magit-lfs magit dashboard company-jedi company-fuzzy company-ycmd company-lsp auto-complete org-ref ess py-autopep8 helm-org org-bullets plantuml-mode use-package dired-subtree project exec-path-from-shell ob-fsharp lsp-mode helm org-drill-table org-drill color-theme-sanityinc-solarized ibuffer-projectile org-projectile projectile eglot-jl))
 '(warning-suppress-types '((org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq create-lockfiles nil)
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs-autosaves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs-saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(setq truncate-lines t)
(setq visible-bell t)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; The Ido package lets you switch between buffers and visit files and
;; directories with a minimum of keystrokes.
(require 'ido)
(ido-mode t)
(setq ido-separator "\n")

;; fix copy and past from clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(setq org-drill-add-random-noise-to-intervals-p t)
(require 'org-tempo)

(tempo-define-template "org-drill-1"
		       '("* Item :drill:\n<QUESTION>\n\n** Answer\n<ANSWER>")

               "<1"
               "Template for and org drill's simple topic")
(tempo-define-template "org-drill-2"
		       '("* Item :drill:\n:PROPERTIES:\n:DRILL_CARD_TYPE: twosided\n:END:\n\n<QUESTION>\n\n** Side A\n\n** Side B\n")

               "<2"
               "Template for an org drills' 2 sided card")
(tempo-define-template "org-drill-3"
		       '("* Item :drill:\n:PROPERTIES:\n:DRILL_CARD_TYPE: hide1cloze\n:END:\n\n<QUESTION>\n")

               "<3"
               "Template for an org drills' hide1cloze card")
(tempo-define-template "org-drill-4"
		       '("* Item :drill:\n")

               "<4"
               "Simples org dril template")

;; Prefer vertical split
(defun split-window-sensibly-prefer-horizontal (&optional window)
"Based on split-window-sensibly, but designed to prefer a horizontal split,
i.e. windows tiled side-by-side."
  (let ((window (or window (selected-window))))
    (or (and (window-splittable-p window t)
         ;; Split window horizontally
         (with-selected-window window
           (split-window-right)))
    (and (window-splittable-p window)
         ;; Split window vertically
         (with-selected-window window
           (split-window-below)))
    (and
         ;; If WINDOW is the only usable window on its frame (it is
         ;; the only one or, not being the only one, all the other
         ;; ones are dedicated) and is not the minibuffer window, try
         ;; to split it horizontally disregarding the value of
         ;; `split-height-threshold'.
         (let ((frame (window-frame window)))
           (or
            (eq window (frame-root-window frame))
            (catch 'done
              (walk-window-tree (lambda (w)
                                  (unless (or (eq w window)
                                              (window-dedicated-p w))
                                    (throw 'done nil)))
                                frame)
              t)))
     (not (window-minibuffer-p window))
     (let ((split-width-threshold 0))
       (when (window-splittable-p window t)
         (with-selected-window window
               (split-window-right))))))))

(defun split-window-really-sensibly (&optional window)
  (let ((window (or window (selected-window))))
    (if (> (window-total-width window) (* 2 (window-total-height window)))
        (with-selected-window window (split-window-sensibly-prefer-horizontal window))
      (with-selected-window window (split-window-sensibly window)))))

(setq
   split-height-threshold 4
   split-width-threshold 40
   split-window-preferred-function 'split-window-really-sensibly)
;; removes all training white space while saving
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; start helm-help mode (a version of M-x which shows documentaiton)
(global-set-key (kbd "M-x") 'helm-M-x)

;; better buffer navigation w/ help
(global-set-key (kbd "C-z") 'helm-buffers-list)
(helm-mode 1)

;; make some org commands available from anywhere (not only org mode)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      '(
	(
	 "t" "Todo" entry
	 (file "~/.emacs.d/refile.org") ;; assumption: I always refile when capturing
         "* TODO %?\n"
	)
        (
	 "m" "Meeting Summary" entry
	 (file "~/.emacs.d/refile.org") ;; assumption: I always refile when capturing
         "* [info][meeting-summary]
** Who joined?
** What was discussed?
** Next steps
")
      (
	 "p" "Meeting Summary - Portuguese" entry
	 (file "~/.emacs.d/refile.org") ;; assumption: I always refile when capturing
         "* [info][resumo-reunião]
** Quem participou?
** O que foi discutido?
** Próximos passos
")
      )

      org-jz-summary-files '( "~/Work/meeting-summaries.org" )

      ;; when re-filing offer limited number of options
      org-refile-targets
      '(
	(nil :maxlevel . 1)
	(org-agenda-files :maxlevel . 1)
	(org-jz-summary-files :maxlevel . 1)
	(("~/SideProjects/personal-todo.org") :maxlevel . 2)
	)

      ;; setup agenda files
      org-agenda-files '(
			 "~/Work/todo-lists/datarisk.org"
			 "~/SideProjects/personal-todo.org"
			 )

      org-default-notes-file "~/.emacs.d/notes.org"

      org-log-refile "time"

      org-outline-path-complete-in-steps nil

      org-refile-use-outline-path "file"
      )

;; view all org-mode TODOs that are not recurring, or not scheduled?
(setq org-agenda-custom-commands
      '(("c" . "My Custom Agendas")
        ("cu" "Unscheduled TODO"
         ((todo ""
                ((org-agenda-overriding-header "\nUnscheduled TODO")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
         nil
         nil))
      org-agenda-window-setup "only-window"
      )

(exec-path-from-shell-initialize)
(require 'ox-beamer)
(global-hl-line-mode)

(use-package dired-subtree :ensure t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(defun sof/dired-sort ()
  "Dired sort hook to list directories first."
  (save-excursion
   (let (buffer-read-only)
     (forward-line 2) ;; beyond dir. header
     (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))

(add-hook 'dired-after-readin-hook 'sof/dired-sort)

(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))

(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-{") 'insert-pair)
(global-set-key (kbd "M-\"") 'insert-pair)
(global-set-key (kbd "M-)") 'delete-pair)
(setq doc-view-continuous t)
(setq org-goto-interface 'outline-path-completion)
(defun org-update-all-buffer ()
  (interactive)
  (org-update-all-dblocks)
  (org-babel-execute-buffer)
  )

;; The following ~20 lines I stole from here:
;; https://github.com/jbranso/.emacs.d/blob/master/lisp/init-org.org#my-org-capure-templates
; These next two modes auto-indents org-buffers as you type! NO NEED
; FOR to press C-c q or fill-paragraph ever again!
(defun my/auto-call-fill-paragraph-for-org-mode ()
    "Call two modes to automatically call fill-paragraph for you."
    (visual-line-mode)
    (org-indent-mode))
(add-hook 'org-mode-hook 'my/auto-call-fill-paragraph-for-org-mode)
(add-hook 'org-mode-hook 'org-bullets-mode)
(setq
 org-ellipsis " ↴"
 org-return-follows-link t
 org-startup-with-inline-images t
 org-catch-invisible-edits 'show-and-error
 org-log-into-drawer t
 org-log-done 'time
 org-bullets-bullet-list '("◉" "◎" "♠" "○" "►" "◇")
 org-confirm-babel-evaluate nil
 )
;; define what files org opens
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))

(global-display-line-numbers-mode)

 (setq org-list-demote-modify-bullet
       '(("+" . "-") ("-" . "*") ("*" . "+"))
       org-list-indent-offset 2
       )

(defun org-set-line-checkbox (arg)
  (interactive "P")
  (let ((n (or arg 1)))
    (when (region-active-p)
      (setq n (count-lines (region-beginning)
                           (region-end)))
      (goto-char (region-beginning)))
    (dotimes (i n)
      (beginning-of-line)
      (insert "- [ ] ")
      (forward-line))
    (beginning-of-line)))
(setq inferior-fsharp-program "dotnet fsi --readline-")
(add-hook 'fsharp-mode-hook 'lsp)
(require 'ox-taskjuggler)

(setq org-taskjuggler-default-reports
'("textreport report \"Plan\" {
formats html
header '== %title =='
center -8<-
[#Plan Plan] | [#Resource_Allocation Resource Allocation]
----
=== Plan ===
<[report id=\"plan\"]>
----
=== Resource Allocation ===
<[report id=\"resourceGraph\"]>
->8-
}
# A traditional Gantt chart with a project overview.
taskreport plan \"\" {
headline \"Project Plan\"
columns bsi,
        name,
        start,
        end,
        effort,
        effortdone,
        effortleft,
        chart { width 1000 scale day }
loadunit days
hideresource 1
}
# A graph showing resource allocation. It identifies whether each
# resource is under- or over-allocated for.
resourcereport resourceGraph \"\" {
headline \"Resource Allocation Graph\"
columns no, name, effort, chart { width 1000 scale day }
loadunit days
hidetask ~(isleaf() & isleaf_())
sorttasks plan.start.up
}")
)
(global-auto-revert-mode 1)
(setq py-autopep8-options nil)

(require 'company-lsp)
(global-set-key (kbd "C-.") 'company-complete)
(push 'company-files company-backends)
(add-hook 'after-init-hook 'global-company-mode)


(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

;; (add-hook 'emacs-python-mode-hook
;;           (lambda ()
;; 	    (push 'company-ycmd company-backends)
;; 	    )
;; 	  )
; (require 'ycmd)
; (add-hook 'python-mode-hook 'ycmd-mode)
; (set-variable 'ycmd-server-command '("python" "-u" "/home/jz/.local/share/ycmd/ycmd"))
; (require 'company-ycmd)
; (company-ycmd-setup)

(require 'dashboard)
(dashboard-setup-startup-hook)
;; Or if you use use-package
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-items '((recents  . 10)
			  (projects . 10)
			  ))
  (dashboard-setup-startup-hook))

(global-set-key (kbd "C-M-g") 'magit-status)

(global-set-key [f1] 'eshell)

(add-hook 'lsp-mode-hook (lambda () (local-set-key [f12] 'lsp-find-definition)))
(add-hook 'lsp-mode-hook (lambda () (local-set-key [S-f12] 'lsp-ui-peek-find-references)))
(setq lsp-ui-sideline-show-hover t)

(require 'flymake)
(define-key flymake-mode-map (kbd "M-S-n") 'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "M-S-p") 'flymake-goto-prev-error)

(use-package flymake-diagnostic-at-point
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

(setq org-journal-dir "/home/jz/.emacs.d/journal/"
      org-journal-time-format "%I:%M %p ")
(require 'org-journal)

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
