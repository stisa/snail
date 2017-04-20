from math import cos, Pi
const Epsilon = 10e-6
proc eq*(x, y, epsilon: float = Epsilon): bool =
  ## Equality up to epsilon precision.
  abs(x-y)<epsilon

proc `~=`*(x, y, epsilon: float = Epsilon): bool {.inline} =
  ## ALias for `eq`
  eq(x,y,epsilon)

proc chebyshevPoint*(i, n: Natural): float {.inline.}=
  ## Calculate the i-th Chebyshev point out of n points.
  ## Belongs to the interval (−1,1).
  cos(0.5*(2*i.float+1)*Pi/n.float)

proc chebyshevLobattoPoint*(i, n: Natural): float {.inline.}=
  ## Calculate the i-th Chebyshev Lobatto point out of n points.
  ## Belongs to the interval [−1,1].
  cos( i.float*Pi / (n-1).float )

proc toInterval*(point, a, b: float): float =
  ## Map ``point`` into the interval a,b with a 
  ## linear transformation ``g(x) = S x + W``
  0.5*(a+b)+0.5*(b-a)*point

proc chebyshevPoints*(N:static[int]): array[N,float] =
  ## The Chebyshev points are the zeros of the Chebyshev 
  ## polynomial of the ﬁrst kind:
  ##    ``x(i) = cos( (2i−1)π/2n ) , i = 1..n``
  ## They belong to the interval (−1,1).
  for i,point in result.mpairs:
    point = chebyshevPoint(i,N)

proc chebyshevPoints*(a,b:float,N:static[int]): array[N,float] =
  for i,point in result.mpairs:
    point = chebyshevPoint(i,N).toInterval(a,b)

proc cPoints*(a, b: float, N:static[int]): array[N,float] =
  ## Shorthand for ``chebyshevPoints``
  chebyshevPoints(a,b,N)

proc chebyshevLobattoPoints*(N:static[int]): array[N,float] =
  ## The Chebyshev Lobatto points are the zeros of the polynomial
  ## ``x(i) = cos( (i−1)π / (n−1) ), i = 1..n``
  ## They belong to the interval [−1,1].
  for i,point in result.mpairs:
    point = chebyshevLobattoPoint(i,N)

proc chebyshevLobattoPoints*(a,b:float,N:static[int]): array[N,float] =
  for i,point in result.mpairs:
    point = chebyshevLobattoPoint(i,N).toInterval(a,b)

proc clPoints*(a, b: float, N:static[int]): array[N,float] =
  ## Shorthand for ``chebyshevLobattoPoints``
  chebyshevLobattoPoints(a,b,N)

when isMainModule:
  import math
  let clp = chebyshevLobattoPoints(10)
  let cp = chebyshevPoints(10)

  assert clp[0] ~= 1.0
  assert clp[1] ~= cos(Pi/9)
  assert clp[2] ~= cos(2*Pi/9)
  assert clp[3] ~= 0.5
  assert clp[4] ~= sin(Pi/18)
  assert clp[5] ~= -sin(Pi/18)
  assert clp[6] ~= -0.5
  assert clp[7] ~= -cos(2*Pi/9)
  assert clp[8] ~= -cos(Pi/9)
  assert clp[9] ~= -1.0

  assert cp[0] ~= cos(Pi/20)
  assert cp[1] ~= cos(3*Pi/20)
  assert cp[2] ~= 2.pow(-0.5)
  assert cp[3] ~= sin(3*Pi/20)
  assert cp[4] ~= sin(Pi/20)
  assert cp[5] ~= -sin(Pi/20)
  assert cp[6] ~= -sin(3*Pi/20)
  assert cp[7] ~= -2.pow(-0.5)
  assert cp[8] ~= -cos(3*Pi/20)
  assert cp[9] ~= -cos(Pi/20)