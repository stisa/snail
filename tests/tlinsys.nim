import ../snail/vector
import ../snail/matrix
import ../snail/linsys

import unittest

proc `\`[N:static[int]](m:Matrix[N,N],v:ColVector[N]):Vector[N] = ppge(m,v) # So we can match matlab syntax
suite "Tests for snail/linsys":

  var 
    A = matrix([[0.0,5,6],[4.0,5,7],[9.0,2,3]])
    b = colVec([11.0,16,15])
  when not defined js:
    # I can't seem to make this true on the js target, something to do with how nim translates newlines I think
    test "Pretty printing":
      check( $(A\b) == "[+1.15|\n|+1.73|\n|+0.39]" )
  test "ppge: Approximate solution at 1.0e-6":
    check((A\b)== colVec([1.151515151515152, 1.72727272727273, 0.393939393939392]))