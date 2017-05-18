import ../snail/vector
import ../snail/matrix

import unittest

suite "Tests for snail/matrix":

  var m : Matrix[2,2] = matrix([[0.0,1],[1.0,0]])
  var w : Matrix[2,2] = [0.0,1,1,0].toMatrix(2,2)
  var r : Matrix[2,2] = [1.0,0,0,1].toMatrix(2,2)
  var cv: ColVector[2] = colVec([1.0,1])
  var rv: RowVector[2] = rowVec([1.0,1.0])

  test "Exact Equality":
    check(m===w)
  test "Equal up to 1.0e-6":
    check(m==w)
  test "Equal up to 1.0e-3":
    check(eq(m,w,10e-3))
  test "Dimensions":
    check(dims(m) == (2,2))
  test "Extracting rows and columns":
    check(m.row(1) == rowVec([1.0,0]))
    check(m.col(1) == colVec([1.0,0]))
  test "M*v and v*M":
    check(m*cv == cv)
    check(rv*m == rv)
  test "M*W":
    check(m*w == r)
  test "Row":
    check( m.row(0) == rowVec([0.0,1]) )
  test "Col":
    check( m.col(0) == colVec([0.0,1]) )
  test "Rows iterator":
    var i = 0
    for row in r.rows:
      check( row == r.row(i) )
      inc i
  test "Cols iterator":
    var i = 0
    for col in r.cols:
      check( col == r.col(i) )
      inc i
  test "Row assignment":
    var mm = matrix([[0.0,0.0],[12.0,12]])
    mm.row 0, rowVec([11.0,11])
    check mm == matrix([[11.0,11.0],[12.0,12]])
    mm.row 0, [1.0,1]
    check mm == matrix([[1.0,1.0],[12.0,12]])
    mm.row 0, @[2.0,2]
    check mm == matrix([[2.0,2.0],[12.0,12]])
  test "Col assignment":
    var mm = matrix([[0.0,0.0],[12.0,12]])
    mm.col 0, colVec([11.0,11])
    check mm == matrix([[11.0,0.0],[11.0,12]])
    mm.col 0, [1.0,1]
    check mm == matrix([[1.0,0.0],[1.0,12]])
    mm.col 0, @[2.0,2]
    check mm == matrix([[2.0,0.0],[2.0,12]])