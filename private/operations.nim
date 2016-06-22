# transpose in place. Should file a bug with nim: single ' not allowed as operator
proc `^`* [N:static[int]] (v: var Vector[N]): Vector[N] =
    if v.isCol: v.isCol=false else: v.isCol=true
    return v 