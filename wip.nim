# Compute PI in an inefficient way
import times,nalg,linalg

var startTime,endTime: float
#[var m : Matrix[10,9] = randomMatrix2(10,9)
var w : Matrix[9,8] = randomMatrix2(9,8)

var m2 : Matrix64[10,9] = randomMatrix(10,9)
var w2 : Matrix64[9,8] = randomMatrix(9,8)

var mw2 : Matrix64[10,8]
var mw : Matrix[10,8] 

startTime = epochTime()
mw2 = m2*w2
endTime = epochTime()   
echo "p required ", endTime - startTime

{.experimental.}
startTime = epochTime()
mw = m*w
endTime = epochTime()   
echo "np required ", endTime - startTime

echo mw2
echo "separation"
echo mw.data
]#
var fm : Matrix[5,5] = matrix2(5,5, [ 1.0 , 0.1 , 1.1 , 0.2 , 1.2 , 0.3 , 1.3 , 0.4 , 1.4 , 0.5 , 1.5 , 0.6 , 1.6 , 0.7 , 1.7 , 0.8 , 1.8 , 0.9 , 1.9 , 0.10 , 1.10 , 0.11 , 1.11 , 0.12 , 1.12]) 
var fw : Matrix[5,5] = matrix2(5,5, [ 1.0 , 0.1 , 1.1 , 0.2 , 1.2 , 0.3 , 1.3 , 0.4 , 1.4 , 0.5 , 1.5 , 0.6 , 1.6 , 0.7 , 1.7 , 0.8 , 1.8 , 0.9 , 1.9 , 0.10 , 1.10 , 0.11 , 1.11 , 0.12 , 1.12]) 

var fm2 : Matrix64[5,5] = matrix([[ 1.0 , 0.1 , 1.1 , 0.2 , 1.2 ],[ 0.3 , 1.3 , 0.4 , 1.4 , 0.5 ],[ 1.5 , 0.6 , 1.6 , 0.7 , 1.7 ],[ 0.8 , 1.8 , 0.9 , 1.9 , 0.10 ],[ 1.10 , 0.11 , 1.11 , 0.12 , 1.12]]) 
var fw2 : Matrix64[5,5] = matrix([[ 1.0 , 0.1 , 1.1 , 0.2 , 1.2 ],[ 0.3 , 1.3 , 0.4 , 1.4 , 0.5 ],[ 1.5 , 0.6 , 1.6 , 0.7 , 1.7 ],[ 0.8 , 1.8 , 0.9 , 1.9 , 0.10 ],[ 1.10 , 0.11 , 1.11 , 0.12 , 1.12]]) 

var mw2 : Matrix64[5,5]
var mw : Matrix[5,5] 


startTime = epochTime()
mw2 = fm2*fw2
endTime = epochTime()   
echo "p required ", endTime - startTime

{.experimental.}
startTime = epochTime()
mw = fm*fw
endTime = epochTime()   
echo "np required ", endTime - startTime

echo mw2
echo "separation"
echo mw.data
#[startTime = epochTime()
#for i in 0..1000:
discard randomMatrix(1000,500).row(13)
endTime = epochTime()
echo "v required ", endTime - startTime]#
