# transpose in place. Should file a bug with nim: single ' not allowed as operator
# TODO: fix discard, this should be inlineable?
proc `t`* [N:static[int]] (v: var Vector[N]): Vector[N] =
    if v.isCol: v.isCol=false else: v.isCol=true

# transpose, copying. Should file a bug with nim: single ' not allowed as operator
proc `t`* [N:static[int]] (v: Vector[N]): Vector[N] =
    result = v
    if result.isCol: result.isCol=false else: result.isCol=true

template fp [N:static[int]](v: Vector[N]): ptr float64  = 
    var vpf: array[N, float64]
    shallowCopy vpf, v.data
    cast[ptr float64](addr vpf[0])

template fp [N,M:static[int]](m: Matrix[N,M]): ptr float64  = 
    var mpf: array[N*M, float64]
    shallowCopy vpf, m.data
    cast[ptr float64](addr mpf[0])

# take the sum of the abs values of the elements of a vector v
proc l_1 [N:static[int]] (v: Vector[N]): auto =
    asum(N, v.fp, 1)

# Vector dot product
proc dot [N:static[int]] (v: Vector[N], w: Vector[N]): auto =
    dot(N, v.fp, 1, w.fp, 1)
# shorthand to^^
proc `*` [N:static[int]] (v: Vector[N], w: Vector[N]): auto {.inline.}= dot(v,w)
