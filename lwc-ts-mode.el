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

(defcustom lwc-ts-mode--lsp-bin "lwc-language-server"
  "Path to the LWC Language Server executable.
This should be either an absolute path or the name of an executable available in `exec-path'."
  :type 'string
  :group 'lwc)

(defcustom lwc-ts-mode--eglot-config '()
  "Configuration settings for LWC Language Server Protocol (LSP) initialization.
This list will be passed to Eglot for configuring the LSP client."
  :type 'list
  :group 'lwc)

;;; LSP Setup
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               (cons '((lwc-html-ts-mode :language-id "lwc-html")
                       (lwc-js-ts-mode :language-id "lwc-javascript"))
                     (lambda (&rest _)
                       `(,lwc-ts-mode--lsp-bin "--stdio" ,@lwc-ts-mode--eglot-config)))))

(provide 'lwc-ts-mode)
;;; lwc-ts-mode.el ends here
