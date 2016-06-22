import nimblas,sequtils

include private/types
include private/prettyprint
include private/operations

var m : array[2, array[2, float]] = [[2.0,1.0],[3.0,4.0]]

var mm : Matrix[2,2] = matrix(m)

var v : Vector[2] = vector([2.0,1.0])
var vv : Vector[2] = vector([2.0,1.0])
#[]
shallowCopy(vv,v.data)
var vvv: array[2, ptr float64]
for i,j in v.data:
    var tmp : float64
    shallowCopy tmp, j
    vvv[i] = addr tmp

echo vvv[0][]
]#

echo v*vv