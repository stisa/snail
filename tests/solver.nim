import ../nalg

# This system will result in a division by zero with the naive algorithm
#0 5 6 = 11
#4 5 7 = 16
#9 2 3 = 15

var A = matrix2D([[0.0,5,6],[4.0,5,7],[9.0,2,3]])
var b = colVector(3,[11.0,16,15])
#var x = colVector(3,[])
#assert($solve(A,b)==
assert( $solve(A,b) == "[+1.15|\n|+1.73|\n|+0.39]\n" )