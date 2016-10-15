
import times,nalg #,linalg

#var startTime,endTime: float

proc subtractVecFromRow*[N:static[int]](A:var Matrix[N,N],row:int,vec:Vector[N],times:float=1.0)=
  for j in 0..<N: A[row,j] = A[row,j]-times*vec[j]

proc subtractRows*[N:static[int]](A:var Matrix[N,N],fm,wht:int,tims:float=1.0)=
  #Subtract wht from fm
  for j in 0..<N: A[fm,j] = A[fm,j]-A[wht,j]*tims


proc divRowByFloat*[N:static[int]](A:var Matrix[N,N],row:int,val:float)=
  for j in 0..<N: A[row,j] = A[row,j]/val

proc findRowWithMaxInCol*[N:static[int]](A: Matrix[N,N],col:int):int =
  var last_max = A[0,col]
  for i in 0..<N:

    if A[i,col]>last_max:
      last_max = A[i,col]
      result = i

proc findMaxInCol*[N:static[int]](A: Matrix[N,N],col:int):tuple[index:int,val:float] =
  result.val = A[0,col]
  for i in 0..<N:

    if A[i,col]>result.val:
      result.val = A[i,col]
      result.index = i

proc swapRow*[N:static[int]](A: var Matrix[N,N],frm,to:int) =
  # Swap row frm with row to
  for i in 0..<N:
    let f = A[frm,i]
    A[frm,i] = A[to,i]
    A[to,i] = f

proc solve*[N:static[int]](A: Matrix[N,N],b:Vector[N]):Vector[N] =
  ## Solve the system Ax=b for x. Does not modify A
  result = b
  var tempA = A
  
  for i in 0..<N: # Iterate over rows
    echo tempA
    echo result
    let mx = tempA.findMaxInCol(i)
    tempA.swapRow(mx.index,i)

    let tmp = result[mx.index] 
    result[mx.index] = result[i]
    result[i] = tmp

    
    let piv = tempA[i,i]
    tempA.divRowByFloat(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)
    
    for j in 0..<N: # Iterate over rows to zero entries in column i

      if j != i:
        let tims = tempA[j,i]
        echo "tims",tims
        tempA.subtractRows(j,i,tims) # zero the column i in this row
        result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )

#[]
      /// ->Vecf64 ,return x^ ( such that [C] x^ = f^ ) 
    pub fn pivoted_gauss_elim( c:Matrix, f:Vec<f64>) -> Vec<f64>{ // 
        let mut c = c;
        // Expand the matrix
        for (i,row) in c.0.iter_mut().enumerate() {
            row.push(f[i]);
        }
        
        for i in 0..c.0.len() {
            let m = c.max_in_column(i as u8);
            c.swap_row(m.1 as u8,i as u8);
            let pivot = c[(i,i)];
            c.divide_row(i as u8,pivot);
            
            for j in 0..c.0.len() {
                if i!=j {
                    c.subtract_rows(j,i);
                }
            }
        }
        // Return the last elements as a vector
        let mut r = vec![];
        for v in  c.0.iter_mut() {
            r.push(v.pop().unwrap());
        }
        r
    } // pivoted_gauss_elim]#

var A = matrix2D([[0.0,12,0],[4.0,0,0],[0.0,0,3]])
var b = colVector(3,[2.0,1,1])

echo "sol->",solve(A,b)
