import nimblas

include private/types
include private/prettyprint
include private/operations

var v :Vector[3] = Vector[3](data: [2.0,2.0,2.0], isCol:false) 

var m : Matrix[2,2] = Matrix[2,2]( data: [2.0,1.0,3.0,4.0])
m[1,1]= 5.0
echo m.row(0)[1]
echo m.col(0)
#echo m[0,0]

#SEEME: single column matrix accesors not working, out of bounds, need ifs?