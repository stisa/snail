import times,../nalg,linalg

var startTime,endTime: float
var m : Matrix[100,90] = randomMatrix2(100,90)
var w : Matrix[90,80] = randomMatrix2(90,80)

var m2 : Matrix64[100,90] = randomMatrix(100,90)
var w2 : Matrix64[90,80] = randomMatrix(90,80)

startTime = epochTime()
discard m2*w2
endTime = epochTime()   
echo "linalg required ", endTime - startTime

{.experimental.}
startTime = epochTime()
discard m*w
endTime = epochTime()   
echo "nalg required ", endTime - startTime
