#ifndef _libdodecad_h
#define _libdodecad_h

#if defined(LIBDODECAD_API_BUILD)
#  if defined(_WIN64)
#    define LIBDODECAD_API __declspec(dllexport)
#  elif defined(__ELF__)
#    define LIBDODECAD_API __attribute__ ((visibility ("default")))
#  else
#    define LIBDODECAD_API
# endif
#else
#  if defined(_WIN64)
#    define LIBDODECAD_API __declspec(dllimport)
#  else
#  define LIBDODECAD_API
#  endif
#endif

#include <sbcl_librarian_err.h>

extern LIBDODECAD_API lisp_err_t lisp_release_handle(void* handle);
extern LIBDODECAD_API lisp_err_t lisp_handle_eq(void* a, void* b, int *result);
extern LIBDODECAD_API lisp_err_t lisp_enable_debugger();
extern LIBDODECAD_API lisp_err_t lisp_disable_debugger();
extern LIBDODECAD_API lisp_err_t lisp_gc();
extern LIBDODECAD_API lisp_err_t lisp_funcall0_by_name(char* name, char* package_name);
extern LIBDODECAD_API lisp_err_t lisp_eval_string(char* expr);
/* types */
typedef enum { ERR_SUCCESS = 0, ERR_FAIL = 1, } err_t;
/* functions */
LIBDODECAD_API int init(char* core);

#endif
