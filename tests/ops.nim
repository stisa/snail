var A = matrix2D([[0.0,12,0],[4.0,0,0],[0.0,0,3]])
var b = colVector(3,[2.0,1,1])

echo "sol->",solve(A,b)
