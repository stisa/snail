import ../snail

var A = matrix2D([[0.0,5,6],[4.0,5,7],[9.0,2,3]])
var b = colVector(3,[11.0,16,15])
#var x = colVector(3,[])
#assert($solve(A,b)==
assert( $solve(A,b) == "[+1.15|\n|+1.73|\n|+0.39]\n" )

proc log*(str:varargs[auto]) = {.emit: "console.log(`str`);".}
log A
log b
log solve(A,b)