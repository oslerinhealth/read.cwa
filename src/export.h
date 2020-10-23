#include "main.h"
#include <R_ext/Rdynload.h>

void R_init_mypackage(DllInfo *info) {
  R_RegisterCCallable("cwaconvert", "convert_cwa_",  (DL_FUNC) &convert_cwa_);
}