ROOT_DIR := $(shell dirname $(shell pwd))

.PHONY: all clean

all: libsbcl.so libdodecad.dylib

libsbcl.so: $(SBCL_SRC)
	test ! -e $(SBCL_SRC)/src/runtime/libsbcl.so && cd $(SBCL_SRC) && ./make-shared-library.sh || true
	cp $(SBCL_SRC)/src/runtime/libsbcl.so ./

libdodecad.core libdodecad.c libdodecad.h libdodecad.py:
	CL_SOURCE_REGISTRY="$(ROOT_DIR)/..//" $(SBCL_SRC)/run-sbcl.sh --load $(HOME)/quicklisp/setup.lisp --script "script.lisp"

libdodecad.dylib: libdodecad.core libdodecad.c
	$(CC) -dynamiclib -o $@ libdodecad.c -L$(SBCL_SRC)/src/runtime -lsbcl
clean:
	rm -f libsbcl.so libdodecad.c libdodecad.h libdodecad.core libdodecad.py libdodecad.dylib

