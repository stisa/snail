import ../snail/vector
import ../snail/matrix
import ../snail/linsys

import unittest

proc `\`[N:static[int]](m:Matrix[N,N],v:ColVector[N]):Vector[N] = ppge(m,v) # So we can match matlab syntax
suite "Tests for snail/linsys":

  var 
    A = matrix([[0.0,5,6],[4.0,5,7],[9.0,2,3]])
    b = colVec([11.0,16,15])
  test "Pretty printing and approximate sol":
    check( $(A\b) == "[+1.15|\n|+1.73|\n|+0.39]" )