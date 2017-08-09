;;; ob-influxdb.el --- InfluxDB queries in org-mode babel -*- lexical-binding: t -*-

;; Copyright (C) 2017 Matthias Nuessler

;; Author: Matthias Nuessler <m.nuessler@web.de>
;; URL: http://github.com/mnuesslser/ob-influxdb
;; Version: 0.0.1
;; Package-Requires: ((s "1.9.0") (cl-lib "0.5"))
;; Keywords: languages, org, org-babel, influxdb

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; InfluxDB queries in org-mode babel.
;;

;;; Code:
(require 's)
(require 'ob)
(require 'cl-lib)

(defvar org-babel-default-header-args:influxdb
  `((:results . "raw"))
  "Default arguments for evaluating an influxdb block.")

(defun org-babel-execute:influxdb (body params)
  "Execute a block containing an InfluxDB query with org-babel."
  (message (concat "Executing InfluxDB query: " body))
  (with-temp-buffer
    (insert body)
    (shell-command-on-region
     (point-min)
     (point-max)
     (concat "influx -execute \"" body "\"")
     (current-buffer)
     t
     "*InfluxDB Result Buffer*"
     t)
    (buffer-string)))


(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("influxdb" . "ob-influxdb")))

(provide 'ob-influxdb)
;;; ob-influxdb.el ends here
