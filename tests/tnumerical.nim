import ../snail/numerical

import unittest,math

suite "Tests for snail/numerical":
  
  test "Chebyshev Lobatto points":
    let clp = chebyshevLobattoPoints(10)
    
    check clp[0] ~= 1.0
    check clp[1] ~= cos(Pi/9)
    check clp[2] ~= cos(2*Pi/9)
    check clp[3] ~= 0.5
    check clp[4] ~= sin(Pi/18)
    check clp[5] ~= -sin(Pi/18)
    check clp[6] ~= -0.5
    check clp[7] ~= -cos(2*Pi/9)
    check clp[8] ~= -cos(Pi/9)
    check clp[9] ~= -1.0
  test "Chebyshev points":
    let cp = chebyshevPoints(10)
    
    check cp[0] ~= cos(Pi/20)
    check cp[1] ~= cos(3*Pi/20)
    check cp[2] ~= 2.pow(-0.5)
    check cp[3] ~= sin(3*Pi/20)
    check cp[4] ~= sin(Pi/20)
    check cp[5] ~= -sin(Pi/20)
    check cp[6] ~= -sin(3*Pi/20)
    check cp[7] ~= -2.pow(-0.5)
    check cp[8] ~= -cos(3*Pi/20)
    check cp[9] ~= -cos(Pi/20)