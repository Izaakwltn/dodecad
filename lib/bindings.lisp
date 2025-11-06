;;;; Library definition

(in-package #:libdodecad)

(define-enum-type error-type "err_t"
  ("ERR_SUCCESS" 0)
  ("ERR_FAIL" 1))

#+ig
(define-error-map error-map error-type 0
		  ((t (lambda (condition)
			(declare (ignore condition))
			(return-from error-map 1)))))

(define-api libdodecad-api (:function-prefix "callback_")
  (:literal "/* types */")
  (:type error-type)
  (:literal "/* functions */")
  (:function
   ;; put function bindings here, see sbcl-librarian/examples 
   ))

(define-aggregate-library libdodecad (:function-linkage (cl:string-upcase "libdodecad_API"))
  sbcl-librarian:handles sbcl-librarian:environment libdodecad-api)
