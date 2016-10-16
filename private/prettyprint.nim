#TODO
import strutils

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
        let fstring = if e>=0: '+'&formatFloat(e,ffDecimal,2) 
                        else: formatFloat(e,ffDecimal,2)
        if(i==N-1): result.add(fstring&"]\n")
        else:
          if v.isCol : result.add( fstring & "|\n|")
          else: result.add(fstring & ", ")
    
    
        
proc `$`*[N,M:static[int]] (m: Matrix[N,M]): string =
    #result = "temporary<--"& $m.data
    result = "["
    if isNil(m.data): result.add("nil]\n")
    else:
      for i in 0..<N:
        for j in 0..<M:
          let fstring = if m[i,j]>=0: '+'&formatFloat(m[i,j],ffDecimal,2) 
                        else: formatFloat(m[i,j],ffDecimal,2)
          if(j==M-1) and (i!=N-1): result.add(fstring&"|\n|")
          elif(j==M-1) and (i==N-1): result.add(fstring&"]\n")
          else:
            result.add(fstring & ", ")