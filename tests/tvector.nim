import ../snail/vector

import unittest

suite "Tests for snail/vector":

  var r : RowVector[3] = rowVec([1.0,2,3])
  var c : ColVector[3] = colVec([1.0,2,3])
  var a : Vector[3] = colVec([1.0,2,3])
  test "Vector can be Col or Row":
    check( a is ColVector == true )
    check( r is RowVector == true )
  test "Row + Column not allowed":
    check( compiles(r+c) == false )
  test "Array access":
    check( r[2] == 3.0 )
    c[1] = 4.0
    check( c[1] == 4.0 )

  test "Dot product":
    check( r*c == 18.0 )

  test "Transposing":
    var rtc = r.t
    rtc[0] = 5.0
    check( rtc is ColVector == true and r is RowVector == true)#, "Transposing a row vector gives a col vector. The original row vector is not modified" )
    check( rtc[0] == 5.0 and r[0] == 1.0)#, "Modifying the transposed vector does not afftect the original")

  test "Norm":
    var rtc = r.t
    rtc[0] = 5.0
    check( norm(r) == 3.0 )
    check( norm(rtc) == 5.0 )

  test "Operations":
    a = colVec([1.0,2,3])
    check(3.0*a == colVec([3.0,6,9]))
    check(a+a == colVec([2.0,4,6]))
    check(a-a == colVec([0.0,0,0]))
    check(a .* a == colVec([1.0,4.0,9.0]))
    check(a ./ a == colVec([1.0,1.0,1.0]))
#[
  when defined js:
  echo r.*r
  echo a
  echo c
  echo rtc
]#