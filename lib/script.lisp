(require '#:asdf)

(asdf:load-system "dodecad")
(dodecad::print-matrix (dodecad::default-row))
(asdf:load-system "sbcl-librarian")

(asdf:load-system "libdodecad")

(in-package #:libdodecad)

(build-bindings libdodecad ".")
(build-python-bindings libdodecad ".")
(build-core-and-die libdodecad "." :compression cl:t)
