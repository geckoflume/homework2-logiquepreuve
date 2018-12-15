;; ADHOC Emacs major mode
;; By Frederic Herbreteau
;; Public domain
;; 
;; this mode is inspired from Scott Andrew Borton's emacs modes tutorial
;; available at http://two-wugs.net/emacs/mode-tutorial.html

(defvar adhoc-mode-hook nil)

;; file extensions (.wp and .hpf)

(add-to-list 'auto-mode-alist '("\\.\\(?:hpf\\|wp\\)" . adhoc-mode))

;; syntax highlight

(defconst adhoc-font-lock-keywords-1
  (list 
   '("\\<\\(:=\\|;\\|do\\|e\\(?:lse\\|nd\\(?:if\\|while\\)\\)\\|if\\|skip\\|then\\|while\\)\\>" . font-lock-keyword-face))
   "Keyword highlighting expressions for ADHOC mode")

(defconst adhoc-font-lock-keywords-2
  (append adhoc-font-lock-keywords-1
	  (list
	   '("\\<\\(%\\(?:\\(?:invariant\\|p\\(?:\\(?:ost\\|re\\)cond\\)\\|variant\\):\\)\\)\\>" . font-lock-builtin-face)))
  "Builtin highlighting for ADHOC mode")

(defconst adhoc-font-lock-keywords-3
  (append adhoc-font-lock-keywords-2
	  (list
	   '("\\(\{.+\}\\)" . font-lock-constant-face)
	   '("\\(\[[0-9]+\]\\)" . font-lock-function-name-face)))
  "Derived formulae highlighting for ADHOC mode")

(defvar adhoc-font-lock-keywords adhoc-font-lock-keywords-3
  "Default highlighting expressions for ADHOC mode")

;; indentation

(defun adhoc-indent-line ()
  "Indent current line as ADHOC code"
  (interactive)
  (beginning-of-line)
  (if (bobp) ; beggining of line ?
      (indent-line-to 0)
    (let ((not-indented t) cur-indent)
      (if (looking-at "^[ \t]*\\(e\\(?:lse\\|nd\\(?:if\\|while\\)\\)\\)") ; endwhile or endif or else ?
	  (progn
	    (save-excursion
	      (forward-line -1)
	      (setq cur-indent (- (current-indentation) default-tab-width)))
	    (if (< cur-indent 0)
		(setq cur-indent 0)))
	(save-excursion
	  (while not-indented
	    (forward-line -1) ; look at previous line
	    (if (looking-at "^[ \t]*end\\(?:if\\|while\\)") ; endwhile/endif ?
		(progn
		  (setq cur-indent (current-indentation))
		  (setq not-indented nil))
	      (if (looking-at "^[ \t]*\\(if\\|while\\|else\\)") ; while or if or else?
		  (progn
		    (setq cur-indent (+ (current-indentation) default-tab-width))
		    (setq not-indented nil))
		(if (bobp) ; indentation is ok
		    (setq not-indented nil)))))))
    (if cur-indent
	(indent-line-to cur-indent) ; loop breaker
      (indent-line-to 0)))))

;; Syntax table

(defvar adhoc-mode-syntax-table
  (let ((adhoc-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" adhoc-mode-syntax-table)
    (modify-syntax-entry ?' "w" adhoc-mode-syntax-table)
    (modify-syntax-entry ?/ ". 14" adhoc-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" adhoc-mode-syntax-table)
    (modify-syntax-entry ?: "w" adhoc-mode-syntax-table)
    (modify-syntax-entry ?% "w" adhoc-mode-syntax-table)
    (modify-syntax-entry ?\[ "(" adhoc-mode-syntax-table)
    (modify-syntax-entry ?\] ")" adhoc-mode-syntax-table)
    adhoc-mode-syntax-table)
  "Syntax table for adhoc-mode")

;; Entry function

(defun adhoc-mode ()
  "Major mode for editing While-programs and Haore logic derivations"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table adhoc-mode-syntax-table)
  (setq adhoc-mode-map (make-sparse-keymap))
  (set (make-local-variable 'font-lock-defaults) '(adhoc-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'adhoc-indent-line)
  (setq major-mode 'adhoc-mode)
  (setq mode-name "adhoc")
  (run-hooks 'adhoc-mode-hook))
  
(provide 'adhoc-mode)

