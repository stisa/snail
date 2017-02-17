import matrix

from math import degtorad,sin,cos

proc projection*(N:static[int],w,h:float):Matrix[N,N] =
  var resarr : array[N*N,float]
  doassert(N in {3,4})
  resarr[0] = 2/w
  resarr[N+1] = 2/h
  resarr[2*(N+1)] = 1
  when N == 4:
    resarr[15] = 1
  result = resarr.toMatrix(N,N)

proc translation*(N:static[int],x,y:float=0,z:float=0):Matrix[N,N] =
  var resarr : array[N*N,float]
  doassert(N in {3,4})
 
  resarr[0] = 1
  resarr[N+1] = 1
  resarr[2*(N+1)] = 1
  
  when N==3:
    resarr[6] = x
    resarr[7] = y
  elif N==4:
    resarr[12] = x
    resarr[13] = y
    resarr[14] = z
    resarr[15] = 1

  result = resarr.toMatrix(N,N)


proc rotation*(N:static[int],phi=0.0,theta:float=0):Matrix[N,N] =
  
  if ( phi == 0 ): return identity(N)
  
  doassert(N in {3,4})
  var resarr : array[N*N,float]
  let ra = degtorad(phi)
  let s = sin(ra)
  let c = cos(ra)

  resarr[0] = c
  resarr[1] = s
  resarr[N] = -s
  resarr[N+1] = c
  resarr[2*(N+1)] = 1
  when N == 4: resarr[3*(N+1)] = 1
  
  result = resarr.toMatrix(N,N)

when isMainModule:
  var p:Matrix[4,4] = projection(4,2,2)

  var t = translation(3,2,2)
  var t2 = translation(4,2,2,2)
  echo p
  echo t
  echo t2
  echo rotation(4,90.0) 

