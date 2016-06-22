# transpose in place. Should file a bug with nim: single ' not allowed as operator
proc `t`* [N:static[int]] (v: var Vector[N]): Vector[N] =
    if v.isCol: v.isCol=false else: v.isCol=true
    return v 

# transpose, copying. Should file a bug with nim: single ' not allowed as operator
proc `t`* [N:static[int]] (v: Vector[N]): Vector[N] =
    result = v
    if result.isCol: result.isCol=false else: result.isCol=true

template fp(v: ref Vector): array[ v.N, ptr float64] = v.data.mapIt(addr(it))

proc abss [N:static[int]] (v: Vector[N]): float64 =
    result = asum(N, v.fp, 1)