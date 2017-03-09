from strutils import formatFloat,FloatFormatMode
import ../snail/vector
import ../snail/matrix

import unittest

suite "Tests for snail/matrix":

  var m : Matrix[2,2] = matrix([[0.0,1],[1.0,0]])
  var w : Matrix[2,2] = [0.0,1,1,0].toMatrix(2,2)
  var r : Matrix[2,2] = [1.0,0,0,1].toMatrix(2,2)
  var cv: ColVector[2] = colVec([1.0,1])
  var rv: RowVector[2] = rowVec([1.0,1.0])

  test "Equality":
    check(m==w)
    check(dims(m) == (2,2))
  test "Extracting rows and columns":
    check(m.row(1) == rowVec([1.0,0]))
    check(m.col(1) == colVec([1.0,0]))
  test "M*v and v*M":
    check(m*cv==cv)
    check(rv*m==rv)
  test "M*W":
    check(m*w==r)

