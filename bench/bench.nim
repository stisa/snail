import times,../nalg,linalg
import nimprof

var startTime,endTime: float
let m : Matrix[200,190] = randomMatrix2(200,190)
let w : Matrix[190,188] = randomMatrix2(190,188)

#let n : Vector[3000] = randomVec(3000)
#let v : Vector[3000] = randomVec(3000)
#var m2 : Matrix64[1000,900] = randomMatrix(1000,900)
#var w2 : Matrix64[900,800] = randomMatrix(900,800)

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

{.experimental.}
startTime = epochTime()
#for i in 0..<100:
discard matMul (m, w)
endTime = epochTime()   
echo "nalg required ", endTime - startTime


#[
{.experimental.}
startTime = epochTime()
for i in 0..<1000:
    discard n*v
#for i in 0..<10000:
#    discard w.col(14)
endTime = epochTime()   
echo "nalg required ", endTime - startTime
startTime = epochTime()
for i in 0..<1000:
    discard dot(n,v)
#for i in 0..<10000:
#    discard w.col(14)
endTime = epochTime()   
echo "nalg required ", endTime - startTime ]#
#[
    900,900 x1000 -> 0.3s
]#
#[  
     100x90x88  -> 0.53 Row goes out of cache? 
    1000x90x88 -> 20.45

]#