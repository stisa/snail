type
    Arr[N:static[int],T] = array[N,T]

# surprisingly, foldl works for arrays too
proc zip*[N,M, R,T](arr1 : Arr[N,R], arr2: Arr[M,T]): array[N,tuple[a: R, b: T]] = 
    assert(N>=M)# the first array has to be longer
    for i in 0 .. N-1: result[i] = (arr1[i], arr2[i])
 
proc zip*[N,M, R,T](arr1 : ref Arr[N,R], arr2: ref Arr[M,T]): array[N,tuple[a: R, b: T]] = 
    assert(N>=M)# the first array has to be longer
    for i, v in mpairs(result): v = (arr1[i],arr2[i])
    #for i in 0 .. N-1: result[i] = (arr1[i], arr2[i])

proc apply*[N:static[int],T](data: var Arr[N,T], op: proc (x: T): T {.closure.}) {.inline.} = 
    for i in mitems(data): i = op(i)

proc innerDotZipped*[N](arr : Arr[N,tuple[a: float, b: float]]): float = 
    for v in arr: result += v.a*v.b