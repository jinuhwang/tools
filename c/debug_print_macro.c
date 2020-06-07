// from https://stackoverflow.com/questions/1941307/debug-print-macro-in-c
#ifdef DEBUG
# define DEBUG_PRINT(x) printf x
#else
# define DEBUG_PRINT(x) do {} while (0)
#endif
