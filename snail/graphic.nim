import matrix

from math import degtorad,sin,cos

proc projection*(N:static[int],w,h:float):Matrix[N,N] =
  var resarr : array[N*N,float]
  doassert(N in {3,4})
  resarr[0] = 2/w
  resarr[N+1] = -2/h
  resarr[2*(N+1)] = 1
  when N == 4:
    resarr[12] = -1
    resarr[13] = 1
    resarr[14] = 1
    resarr[15] = 1
  result = resarr.toMatrix(N,N)

proc projection*(w,h:float):Matrix[4,4]{.inline} =
  projection(4,w,h)

proc translation*(N:static[int],x,y:float=0,z:float=0):Matrix[N,N] =
  doassert(N > 2 and N < 5, "be careful with implicit conversions from int to float")
 
  var resarr : array[N*N,float]
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


proc translation*(x,y:float=0,z:float=0):Matrix[4,4]{.inline} =
  translation(4,x,y,z)

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

proc rotation*(phi=0.0,theta:float=0):Matrix[4,4]{.inline} =
  rotation(4,phi,theta)

proc scaling*(N:static[int],w,h:float=0):Matrix[N,N] =
  doassert(N > 2 and N < 5, "be careful with implicit conversions from int to float")
 
  var resarr : array[N*N,float]
  resarr[0] = 1/w
  resarr[N+1] = 1/h
  resarr[2*(N+1)] = 0
  
  resarr[10] = 1
  resarr[15] = 1

  result = resarr.toMatrix(N,N)


proc scaling*(w,h:float=0):Matrix[4,4]{.inline} =
  scaling(4,w,h)

when isMainModule:
  var p:Matrix[4,4] = projection(2,2)

  var t = translation(3,2,2)
  var t2 = translation(2.0,2,2)
  echo p
  echo t
  echo t2
  echo rotation(90.0) 

