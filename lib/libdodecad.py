import os
from ctypes import *
from ctypes.util import find_library
from pathlib import Path

import sbcl_librarian.wrapper
from sbcl_librarian.errors import lisp_err_t

try:
    libpath = Path(find_library('libdodecad')).resolve()
except TypeError as e:
    raise Exception('Unable to locate libdodecad') from e

libdodecad_dll = CDLL(str(libpath), mode=RTLD_GLOBAL)

libdodecad.init(str(libpath.parent / 'libdodecad.core').encode('utf-8'))


lisp_release_handle = libdodecad_dll.lisp_release_handle
lisp_release_handle.restype = lisp_err_t
lisp_release_handle.argtypes = [c_void_p]
lisp_release_handle = sbcl_librarian.wrapper.lift_fn("lisp_release_handle", lisp_release_handle)

lisp_handle_eq = libdodecad_dll.lisp_handle_eq
lisp_handle_eq.restype = lisp_err_t
lisp_handle_eq.argtypes = [c_void_p, c_void_p, POINTER(c_bool)]
lisp_handle_eq = sbcl_librarian.wrapper.lift_fn("lisp_handle_eq", lisp_handle_eq)

lisp_enable_debugger = libdodecad_dll.lisp_enable_debugger
lisp_enable_debugger.restype = lisp_err_t
lisp_enable_debugger.argtypes = []
lisp_enable_debugger = sbcl_librarian.wrapper.lift_fn("lisp_enable_debugger", lisp_enable_debugger)

lisp_disable_debugger = libdodecad_dll.lisp_disable_debugger
lisp_disable_debugger.restype = lisp_err_t
lisp_disable_debugger.argtypes = []
lisp_disable_debugger = sbcl_librarian.wrapper.lift_fn("lisp_disable_debugger", lisp_disable_debugger)

lisp_gc = libdodecad_dll.lisp_gc
lisp_gc.restype = lisp_err_t
lisp_gc.argtypes = []
lisp_gc = sbcl_librarian.wrapper.lift_fn("lisp_gc", lisp_gc)

lisp_funcall0_by_name = libdodecad_dll.lisp_funcall0_by_name
lisp_funcall0_by_name.restype = lisp_err_t
lisp_funcall0_by_name.argtypes = [c_char_p, c_char_p]
lisp_funcall0_by_name = sbcl_librarian.wrapper.lift_fn("lisp_funcall0_by_name", lisp_funcall0_by_name)

lisp_eval_string = libdodecad_dll.lisp_eval_string
lisp_eval_string.restype = lisp_err_t
lisp_eval_string.argtypes = [c_char_p]
lisp_eval_string = sbcl_librarian.wrapper.lift_fn("lisp_eval_string", lisp_eval_string)

class err_t(int):
    _map = {
        0: "ERR_SUCCESS",
        1: "ERR_FAIL",
    }




__all__ = ['lisp_release_handle', 'lisp_handle_eq', 'lisp_enable_debugger', 'lisp_disable_debugger', 'lisp_gc', 'lisp_funcall0_by_name', 'lisp_eval_string', 'err_t']

