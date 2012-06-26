(defpackage :com.daveltd.darcs-status-tracker.system
  (:use :common-lisp :asdf))

(in-package #:com.daveltd.darcs-status-tracker.system)

(asdf:defsystem :com.daveltd.darcs-status-tracker
  :name "com.daveltd.darcs-status-tracker"
  :version "0.0.1"
  :author "David Lindes"
  :depends-on (:fiveam)
  :serial t
  :components ((:file "package")
               (:file "darcs-status-tracker")))
