# dodecad

### Simple tone-row encoding and manipulation in lisp

### Example

```cl
CL-USER> (asdf:load-system :dodecad)
T
CL-USER> (in-package #:dodecad)
#<PACKAGE "DODECAD">
DODECAD> (defvar *berg-violin-concerto* '(7 10 2 6 9 0 4 8 11 1 3 5))
*BERG-VIOLIN-CONCERTO*
DODECAD> (print-matrix *berg-violin-concerto*)
|  7 | 10 |  2 |  6 |  9 |  0 |  4 |  8 | 11 |  1 |  3 |  5 |
|  4 |  7 | 11 |  3 |  6 |  9 |  1 |  5 |  8 | 10 |  0 |  2 |
|  0 |  3 |  7 | 11 |  2 |  5 |  9 |  1 |  4 |  6 |  8 | 10 |
|  8 | 11 |  3 |  7 | 10 |  1 |  5 |  9 |  0 |  2 |  4 |  6 |
|  5 |  8 |  0 |  4 |  7 | 10 |  2 |  6 |  9 | 11 |  1 |  3 |
|  2 |  5 |  9 |  1 |  4 |  7 | 11 |  3 |  6 |  8 | 10 |  0 |
| 10 |  1 |  5 |  9 |  0 |  3 |  7 | 11 |  2 |  4 |  6 |  8 |
|  6 |  9 |  1 |  5 |  8 | 11 |  3 |  7 | 10 |  0 |  2 |  4 |
|  3 |  6 | 10 |  2 |  5 |  8 |  0 |  4 |  7 |  9 | 11 |  1 |
|  1 |  4 |  8 |  0 |  3 |  6 | 10 |  2 |  5 |  7 |  9 | 11 |
| 11 |  2 |  6 | 10 |  1 |  4 |  8 |  0 |  3 |  5 |  7 |  9 |
|  9 |  0 |  4 |  8 | 11 |  2 |  6 | 10 |  1 |  3 |  5 |  7 |
NIL
```