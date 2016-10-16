{.floatChecks: on.}
var A = matrix2D([[0.0,5,6],[4.0,5,7],[9.0,2,3]])
var b = colVector(3,[11.0,16,15])
var x = solve(A,b)
echo "sol->",repr x

echo A*x
#echo b-A*x # Calculate remainder
