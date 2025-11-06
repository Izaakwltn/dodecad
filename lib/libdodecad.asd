(asdf:defsystem #:libdodecad
  :description "Shared Library for DODECAD "
  :author "Your Name <mail@domain.com>"
  :defsystem-depends-on (#:sbcl-librarian)
  :depends-on (#:sbcl-librarian #:DODECAD)
  :serial t
  :components ((:file "package")
               (:file "bindings")))
