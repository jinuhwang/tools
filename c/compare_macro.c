#define typeof(x) __typeof__(x)
#define MAX(a,b) \
    ({ typeof (a) _a = (a); typeof (b) _b = (b); \
        _a > _b ? _a : _b; })
#define MIN(a,b) \
    ({ typeof (a) _a = (a); typeof (b) _b = (b); \
        _a < _b ? _a : _b; })
