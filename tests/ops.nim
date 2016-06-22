import ../nalg

var tv : Vector[2] = vector([2.0,1.0])
let tvv : Vector[2] = vector([2.0,1.0])
let ttvvv: Vector[2] = vector([4.0,2.0])
assert(tv*tvv == 5.0, "Regression: vector dot product")
#assert((tv.t).isCol == true, " Regression: vector transpose in place, got "& $tv.isCol)
assert( tv.l_1 == 3.0, " Regression: vector l_1")
#assert(tv+tvv == ttvvv, "Regression: adding two vector")
var va :Vector[2] = tv.*2.0
echo va