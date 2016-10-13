#TODO
proc `$`*[N,M:int](a: array[N, array[M, float]]): string =
  result = ""
  for v in a:
    result.add($v)

proc `$`*[N:int](a: array[N, float]): string =
    result = "["
    for v in a[0..(a.len()-2)]:
        result.add($v & ", ")
    result.add($a[a.len()-1]&"]\n")

proc `$`*[N:int](a: ref array[N, float]): string =
    if isNil(a):
        result = "nil"
    else:
        result = "["
        for v in 0..(high(N)-1):
            result.add($a[v] & ", ")
        result.add($a[high(N)]&"]\n")
        
proc `$`*[N:int](ar: array[N, tuple[a:float,b:float]]): string =
    result = "["
    for v in ar[0..(ar.len()-2)]:
        result.add($v & ", ")
    result.add($ar[ar.len()-1]&"]\n")

proc `$`*[N:static[int]] (v: Vector[N]): string =
    result = "["
    if isNil(v.data): result.add("nil]\n")
    else:
        for i,e in v.data[]:
            if(i==N-1): result.add($v.data[N-1]&"]\n")
            else:
                if v.isCol : result.add( $e & "|\n|")
                else: result.add($e & ", ")
        
    
        
proc `$`*[N,M:static[int]] (m: Matrix[N,M]): string =
    result = "temporary<--"& $m.data