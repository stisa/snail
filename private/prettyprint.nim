
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


proc `$`*[N:static[int]] (v: Vector[N]): string =
    result = "["
    for e in v.data[0..(N-2)]:
        if v.isCol :
            result.add( $e & "|\n|")
        else:
            result.add($e & ", ")
    result.add($v.data[N-1]&"]\n")

proc `$`*[N,M:static[int]] (m: Matrix[N,M]): string =
    result = "temporary<--"& $m.data