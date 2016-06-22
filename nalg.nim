import nimblas,sequtils

include private/types
include private/prettyprint
include private/operations

var m : array[2, array[2, float]] = [[2.0,1.0],[3.0,4.0]]

var mm : Matrix[2,2] = matrix(m)

var v : Vector[2] = vector([2.0,1.0])

var vv = 0
#var vp = addr vv
var vp : array[2, ptr float64] 
#=map(v.data, proc(x:float64):ptr float64= addr x)
var rv : ref Vector[2] =v


echo vp[]