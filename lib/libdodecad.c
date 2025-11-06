#define LIBDODECAD_API_BUILD

#include "libdodecad.h"

#include <signal.h>
#ifndef _WIN32
#include <pthread.h>
#endif

LIBDODECAD_API lisp_err_t (*_lisp_release_handle)(void* handle);
lisp_err_t lisp_release_handle(void* handle) {
    if (!initialized) {
        return LISP_ERR_NOT_INITIALIZED;
    } else if (!fatal_sbcl_error_occurred && !setjmp(fatal_lisp_error_handler)) {
        void (*sigint_handler)(int) = signal(SIGINT, SIG_DFL);
#ifdef __linux__
        sigset_t mask1;
        sigemptyset(&mask1);
        sigaddset(&mask1, SIGSEGV);
        sigaddset(&mask1, SIGTRAP);

        pthread_sigmask(SIG_UNBLOCK, &mask1, 0);
#endif
        lisp_err_t result_code = _lisp_release_handle(handle);
#ifdef __APPLE__
        sigset_t mask2;
        sigemptyset(&mask2);
        sigaddset(&mask2, SIGINT);

        pthread_sigmask(SIG_UNBLOCK, &mask2, 0);
#endif
        signal(SIGINT, sigint_handler);
        return result_code;
    } else {
        return 3;
    }
}

LIBDODECAD_API lisp_err_t (*_lisp_handle_eq)(void* a, void* b, int *result);
lisp_err_t lisp_handle_eq(void* a, void* b, int *result) {
    if (!initialized) {
        return LISP_ERR_NOT_INITIALIZED;
    } else if (!fatal_sbcl_error_occurred && !setjmp(fatal_lisp_error_handler)) {
        void (*sigint_handler)(int) = signal(SIGINT, SIG_DFL);
#ifdef __linux__
        sigset_t mask1;
        sigemptyset(&mask1);
        sigaddset(&mask1, SIGSEGV);
        sigaddset(&mask1, SIGTRAP);

        pthread_sigmask(SIG_UNBLOCK, &mask1, 0);
#endif
        lisp_err_t result_code = _lisp_handle_eq(a, b, result);
#ifdef __APPLE__
        sigset_t mask2;
        sigemptyset(&mask2);
        sigaddset(&mask2, SIGINT);

        pthread_sigmask(SIG_UNBLOCK, &mask2, 0);
#endif
        signal(SIGINT, sigint_handler);
        return result_code;
    } else {
        return 3;
    }
}

LIBDODECAD_API lisp_err_t (*_lisp_enable_debugger)();
lisp_err_t lisp_enable_debugger() {
    if (!initialized) {
        return LISP_ERR_NOT_INITIALIZED;
    } else if (!fatal_sbcl_error_occurred && !setjmp(fatal_lisp_error_handler)) {
        void (*sigint_handler)(int) = signal(SIGINT, SIG_DFL);
#ifdef __linux__
        sigset_t mask1;
        sigemptyset(&mask1);
        sigaddset(&mask1, SIGSEGV);
        sigaddset(&mask1, SIGTRAP);

        pthread_sigmask(SIG_UNBLOCK, &mask1, 0);
#endif
        lisp_err_t result_code = _lisp_enable_debugger();
#ifdef __APPLE__
        sigset_t mask2;
        sigemptyset(&mask2);
        sigaddset(&mask2, SIGINT);

        pthread_sigmask(SIG_UNBLOCK, &mask2, 0);
#endif
        signal(SIGINT, sigint_handler);
        return result_code;
    } else {
        return 3;
    }
}

LIBDODECAD_API lisp_err_t (*_lisp_disable_debugger)();
lisp_err_t lisp_disable_debugger() {
    if (!initialized) {
        return LISP_ERR_NOT_INITIALIZED;
    } else if (!fatal_sbcl_error_occurred && !setjmp(fatal_lisp_error_handler)) {
        void (*sigint_handler)(int) = signal(SIGINT, SIG_DFL);
#ifdef __linux__
        sigset_t mask1;
        sigemptyset(&mask1);
        sigaddset(&mask1, SIGSEGV);
        sigaddset(&mask1, SIGTRAP);

        pthread_sigmask(SIG_UNBLOCK, &mask1, 0);
#endif
        lisp_err_t result_code = _lisp_disable_debugger();
#ifdef __APPLE__
        sigset_t mask2;
        sigemptyset(&mask2);
        sigaddset(&mask2, SIGINT);

        pthread_sigmask(SIG_UNBLOCK, &mask2, 0);
#endif
        signal(SIGINT, sigint_handler);
        return result_code;
    } else {
        return 3;
    }
}

LIBDODECAD_API lisp_err_t (*_lisp_gc)();
lisp_err_t lisp_gc() {
    if (!initialized) {
        return LISP_ERR_NOT_INITIALIZED;
    } else if (!fatal_sbcl_error_occurred && !setjmp(fatal_lisp_error_handler)) {
        void (*sigint_handler)(int) = signal(SIGINT, SIG_DFL);
#ifdef __linux__
        sigset_t mask1;
        sigemptyset(&mask1);
        sigaddset(&mask1, SIGSEGV);
        sigaddset(&mask1, SIGTRAP);

        pthread_sigmask(SIG_UNBLOCK, &mask1, 0);
#endif
        lisp_err_t result_code = _lisp_gc();
#ifdef __APPLE__
        sigset_t mask2;
        sigemptyset(&mask2);
        sigaddset(&mask2, SIGINT);

        pthread_sigmask(SIG_UNBLOCK, &mask2, 0);
#endif
        signal(SIGINT, sigint_handler);
        return result_code;
    } else {
        return 3;
    }
}

LIBDODECAD_API lisp_err_t (*_lisp_funcall0_by_name)(char* name, char* package_name);
lisp_err_t lisp_funcall0_by_name(char* name, char* package_name) {
    if (!initialized) {
        return LISP_ERR_NOT_INITIALIZED;
    } else if (!fatal_sbcl_error_occurred && !setjmp(fatal_lisp_error_handler)) {
        void (*sigint_handler)(int) = signal(SIGINT, SIG_DFL);
#ifdef __linux__
        sigset_t mask1;
        sigemptyset(&mask1);
        sigaddset(&mask1, SIGSEGV);
        sigaddset(&mask1, SIGTRAP);

        pthread_sigmask(SIG_UNBLOCK, &mask1, 0);
#endif
        lisp_err_t result_code = _lisp_funcall0_by_name(name, package_name);
#ifdef __APPLE__
        sigset_t mask2;
        sigemptyset(&mask2);
        sigaddset(&mask2, SIGINT);

        pthread_sigmask(SIG_UNBLOCK, &mask2, 0);
#endif
        signal(SIGINT, sigint_handler);
        return result_code;
    } else {
        return 3;
    }
}

LIBDODECAD_API lisp_err_t (*_lisp_eval_string)(char* expr);
lisp_err_t lisp_eval_string(char* expr) {
    if (!initialized) {
        return LISP_ERR_NOT_INITIALIZED;
    } else if (!fatal_sbcl_error_occurred && !setjmp(fatal_lisp_error_handler)) {
        void (*sigint_handler)(int) = signal(SIGINT, SIG_DFL);
#ifdef __linux__
        sigset_t mask1;
        sigemptyset(&mask1);
        sigaddset(&mask1, SIGSEGV);
        sigaddset(&mask1, SIGTRAP);

        pthread_sigmask(SIG_UNBLOCK, &mask1, 0);
#endif
        lisp_err_t result_code = _lisp_eval_string(expr);
#ifdef __APPLE__
        sigset_t mask2;
        sigemptyset(&mask2);
        sigaddset(&mask2, SIGINT);

        pthread_sigmask(SIG_UNBLOCK, &mask2, 0);
#endif
        signal(SIGINT, sigint_handler);
        return result_code;
    } else {
        return 3;
    }
}


extern int initialize_lisp(int argc, char **argv);

LIBDODECAD_API int init(char* core) {
  static int initialized = 0;
  char *init_args[] = {"", "--core", core, "--noinform", };
  if (initialized) return 1;
  if (initialize_lisp(4, init_args) != 0) return -1;
  initialized = 1;
  return 0; }