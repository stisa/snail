import times,../nalg
#import nimprof

var startTime,endTime: float
let A : Matrix[100,100] = randomMatrix(100,100)
var B : Matrix[100,100] = A
let b : Vector[100] = randomVec(100)
#let n : Vector[3000] = randomVec(3000)
#let v : Vector[3000] = randomVec(3000)
#let m2 : Matrix64[200,200] = randomMatrix(200,200)
#let w2 : Matrix64[200,200] = randomMatrix(200,200)

#startTime = epochTime()
#for i in 0..<100:
#discard m2*w2
#endTime = epochTime()   
#echo "linalg required ", endTime - startTime

#[]
{.experimental.}
startTime = epochTime()
#for i in 0..<100:
discard matMul2 (m, w)
endTime = epochTime()   
echo "nalg required ", endTime - startTime
]#

startTime = epochTime()
for i in 0..<100:
  discard solve(A,b)
endTime = epochTime()   
echo "nalg required ", endTime - startTime
startTime = epochTime()
for i in 0..<100:
  discard solveInplace(B,b)
endTime = epochTime()   
echo "nalg required ", endTime - startTime

#[
    900,900 x1000 -> 0.3s
]#
#[  
     100x90x88  -> 0.53 Row goes out of cache? 
    1000x90x88 -> 20.45

]#