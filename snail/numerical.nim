from math import cos, Pi
from sequtils import toSeq,foldl

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

proc clPointsSeq*(a,b:float,n:Natural): seq[float] =
  result = newSeq[float](n)
  for i,point in result.mpairs:
    point = chebyshevLobattoPoint(i,n).toInterval(a,b)

proc chebyshevLobattoPoints*(a,b:float,N:static[int]): array[N,float] =
  for i,point in result.mpairs:
    point = chebyshevLobattoPoint(i,N).toInterval(a,b)

proc clPoints*(a, b: float, N:static[int]): array[N,float] =
  ## Shorthand for ``chebyshevLobattoPoints``
  chebyshevLobattoPoints(a,b,N)


iterator linspace*(starts,ends:float,points:Natural=100):float =
    let 
        divisions: float = (points-1).float
        step = (ends-starts)/divisions
    var i : float = starts
    while abs(ends-i)>Epsilon:
        yield i
        i+=step
    yield i
        

proc middle*(s:openArray[float]):float =
  s[(s.len-1) div 2]

proc linspace*(starts,ends:float,points:Natural=100):seq[float] =
  result = newSeq[float](points)
  var i = 0
  for p in linspace(starts,ends,points):
    result[i] = p
    inc i
      

#[
  proc rootBisection(f:proc(x:float):float, x:seq[float]=linspace(-1,1,100),
  kmax: int = 100,tol:float = Epsilon):float =
  #g = 9.81;
  #f = @(x) (g./(2 .*x.^2)).*(sinh(x)-sin(x)) -1;
  #x = linspace(-1,1,100); 
  #plot(x,f(x));
    var
      a = 0.5
      b = 1.0
      i=1    
    result = (a+b)/2
    var
      alpha = f(result)
    while result != 0 and abs(alpha)>tol and i<kmax:
      if (f(a)*f(result) < 0):
        b = result
        result = (a+b)/2;
      elif (f(b)*f(result))<0:
        a = result
        result = (a+b)/2
      alpha = f(result)
      i = i+1;

  proc rootFixedPoint(f:proc(x:float):float,df:proc(x:float):float, x:seq[float]=linspace(-1,1,100), 
    kmax: int = 100,tol:float = 1.0e-6):float =
    let f0 = middle(x)
    var
      x0 = 0.5
      k = 1
    
    result = f(x0)
    while abs(result-x0)>tol and kmax>k:
      x0 = result
      result = f(x0)
      k = k+1
]#
proc rootNewton*(f: proc(x: float): float, df: proc(x: float): float, 
  x: seq[float] = linspace(-1, 1, 100), 
  kmax: int = 100, tol: float = Epsilon): float =
  ## Naive Newton Method to find the root of a function `f`, given `f` and its derivative `df`.
  ## `x` is the interval in which to look for the root, `kmax` is the max number of iterations
  ## and `tol` is the maximux difference between the root and the result.
  var 
    k=0
    x0 = 0.5*(x[^1]+x[0])
  result = x0 - f(x0)/df(x0)
  k=k+1

  while( abs(x0-result) > tol*abs(result) and k <=  kmax):
    x0=result
    result = x0 - f(x0)/df(x0)
    k=k+1
  if k>kmax: raiseAssert("Exceeded max number of iterations")

proc integrateTrapez*(f:proc(x:float):float, domain:Slice[float]):float =
  ## Perform integration over `domain` of `f` with Cavalieri's Formula
  ## i.e. (b-a)(f(a)+f(b))/2
  (domain.b-domain.a)*(f(domain.a)+f(domain.b))/2

proc integrateCompTrapez*(f:proc(x:float):float, domain:Slice[float], n:Natural = 100):float =
  ## Perform integration over `domain` of `f` with Composite Cavalieri's Formula
  ## i.e. (b-a)/n [ f(a)/2 + sum( f(a+k(b-a)/n)) + f(b)/2]
  for k in 0..<n:
    result += f(domain.a+k.float*(domain.b-domain.a)/n.float) 
  result = ((domain.b-domain.a)/n.float)*( (f(domain.a)/2)+(f(domain.b)/2)+result )

proc integrateSimpson*(f:proc(x:float):float, domain:Slice[float]):float =
  ## Perform integration over `domain` of `f` with Cavalieri's Formula
  (domain.b-domain.a)/6*(f(domain.a)+4*f((domain.a+domain.b)/2)+f(domain.b))

proc integrateCompSimpson*(f:proc(x:float):float, domain:Slice[float], n:Natural=100): float =
  ## Perform integration over `domain` of `f` with Composite Simpson's Formula
  let h = (domain.b-domain.a)/n.float
  for i in countup(1,(n div 2)-1):
    result += f(domain.a+h*(i*2).float)
  let accum = 2*result
  result = 0.0
  for i in countup(1,(n div 2)):
    result += f(domain.a+h*(2*i-1).float)
  result = h/3*(f(domain.a)+(4*result)+accum+f(domain.b))

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
  let 
    f = proc(x:float):float =
      pow(x,2)-1
    df = proc(x:float):float =
      2*x
  assert rootNewton(f,df,linspace(-1,0)) ~= -1.0
  assert rootNewton(f,df,linspace(0,1)) ~= 1.0
