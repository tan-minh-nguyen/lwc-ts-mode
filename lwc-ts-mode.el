;;; lwc-ts-mode.el --- tree-sitter support for Lightning Web Components -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Free Software Foundation, Inc.

;; Author     : Tan Nguyen
;; Maintainer : Tan Nguyen
;; Created    : January 2024
;; Keywords   : lwc salesforce languages tree-sitter
;; Package-Requires: ((emacs "29.1"))
;; Version    : 1.0.0
;; URL        : https://github.com/nverno/lwc-ts-mode

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Major modes for editing Salesforce Lightning Web Components, powered by tree-sitter.
;;
;; This package provides two modes:
;; - `lwc-js-ts-mode': For LWC JavaScript component files
;; - `lwc-html-ts-mode': For LWC HTML template files
;;
;; Features:
;; - JavaScript tree-sitter syntax highlighting
;; - HTML tree-sitter syntax highlighting with LWC expressions
;; - LWC-specific features (decorators, template expressions)

;;; Code:

(require 'lwc-ts-common)
(require 'lwc-js-ts-mode)
(require 'lwc-html-ts-mode)

;;; LSP Setup

(defun lwc-mode-eglot-setup ()
  "Setup LWC LSP for Eglot."
  (when (and (boundp 'eglot-server-programs)
             (boundp 'lwc-ts-mode--lsp-path)
             (boundp 'lwc-ts-mode--eglot-config))
    (add-to-list 'eglot-server-programs
                 `(((lwc-html-ts-mode :language-id "lwc-html")
                    (lwc-js-ts-mode :language-id "lwc-javascript"))
                   (,lwc-ts-mode--lsp-path "--stdio" ,@lwc-ts-mode--eglot-config)))))

(provide 'lwc-ts-mode)
;;; lwc-ts-mode.el ends here
