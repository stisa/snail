import ../nalg

# This system will result in a division by zero with the naive algorithm
#0 5 6 = 11
#4 5 7 = 16
#9 2 3 = 15

var A = matrix2D([[0.0,5,6],[4.0,5,7],[9.0,2,3]])
var b = colVector(3,[11.0,16,15])

echo solve(A,b)