; darcs-status-tracker -- main source file for com.daveltd.darcs-status-tracker
;
; see README.md for more info on what this is all about.

(in-package :com.daveltd.darcs-status-tracker)

; if you want tests, evaluate the following:
(eval-when (:compile-toplevel :load-toplevel :execute)
           (pushnew :5am *features*)
           (require :asdf)
           (require :FiveAM))

; #+5am (use-package :5AM) ; TODO: better package management

#+5am (5am:def-suite parse-tests :description "Tests for parsing routines")
#+5am (5am:in-suite parse-tests)

(defun parse-outputs (&key html text lisp)
  ; TODO: anything actually useful, like opening output files (or objects)
  (list :html html :text text :lisp lisp))

; TODO: check for creation of files or something.
#+5am (5am:test test-parse-outputs
        "Testing parse-outputs routine for sanity"
        (5am:is (equal '(:html nil :text nil :lisp nil)
                       (parse-outputs)))
        (5am:is (equal '(:html "foo.html" :text NIL :lisp NIL)
                               (parse-outputs :html "foo.html")))
        (5am:is (equal '(:html NIL :text "foo.txt" :lisp NIL)
                               (parse-outputs :text "foo.txt")))
        (5am:is (equal '(:html NIL :text NIL :lisp "foo.lisp")
                               (parse-outputs :lisp "foo.lisp"))))

; turn path with optional host into '(path host)
(defun canonical-config (path &optional host)
  (if (listp path)
      (apply #'canonical-config path)
      (list path host)))

#+5am (5am:test test-canonical-config
        "Testing canonical-config"
        (5am:is (equal '("foo" nil)
                   (canonical-config "foo")))
        (5am:is (equal '("foo" "bar")
                   (canonical-config "foo" "bar"))))

; what I want as input:
; (parse-configs "/dir" "/dir2" ("/dir3" "host"))
; what I want to get back:
; (("/dir" nil) ("/dir2" nil) ("/dir3" "host"))
;
; well, but really, this doesn't need to be exposed directly, and it's
; fine if it just gets a single list, with the caller dealing with
; changing it from looking like the above to looking like:
; (parse-configs "/dir" "/dir2" '("/dir3" "host")))
(defun parse-configs (&rest configs)
  (loop for c in configs collecting (canonical-config c)))

#+5am (5am:test test-parse-configs
        "Testing the way parse-configs splits things up"
        (5am:is (equal '(("foo" nil) ("foo" "bar"))
                       (parse-configs "foo" '("foo" "bar")))))

; outputs would-be: &key html text lisp

;
(defun _darcs-status-tracker (outputs configs)
  ; (apply #'parse-outputs outputs)
  ; (format t "outputs: ~S, conf: ~S~%" outputs configs)

  (loop for config in configs
     do (let ((path (car config))
              (host (cadr config)))
          (if host
              (format t "running on ~a for ~a~%" host path)
              (format t "running locally for ~a~%" path)))))

; this allows us to have configs in a somewhat informal style, that
; just look like lisp-forms without need for quoting them.
(defmacro darcs-status-tracker ((&key html text lisp)
                                &rest configs)
  `(_darcs-status-tracker
    ',(parse-outputs :html html :text text :lisp lisp)
    ; TODO: why am I getting an error that configs is defined but never used?  Don't I use it right here??
    ',(apply #'parse-configs configs)))


