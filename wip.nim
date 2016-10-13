
import times,nalg #,linalg

#var startTime,endTime: float

proc subtractVecFromRow*[N:static[int]](A:var Matrix[N,N],row:int,vec:Vector[N],times:float=1.0)=
  for j in 0..<N: A[row,j] = A[row,j]-times*vec[j]


proc divRowByFloat*[N:static[int]](A:var Matrix[N,N],row:int,val:float)=
  for j in 0..<N: A[row,j] = A[row,j]/val

proc findRowWithMaxInCol*[N:static[int]](A: Matrix[N,N],col:int):int =
  var last_max = A[0,col]
  for i in 0..<N:

    if A[i,col]>last_max:
      last_max = A[i,col]
      result = i

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
    
    let pivrowId = tempA.findRowWithMaxInCol(i)
    tempA.swapRow(pivrowId,i)

    let tmp = result[pivrowId] 
    result[pivrowId] = result[i]
    result[i] = tmp

    echo tempA
    echo result

    let piv = tempA[i,i]
    tempA.divRowByFloat(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)
    
    let pivrow = tempA.row(i) # Save the row to reuse it later
    
    for j in 0..<N: # Iterate over rows to zero entries in column i

      if j == i: continue # skip this if considering current pivoted row

      let tims = tempA[j,i] # Save the times we have to subtract to zero the column i
      tempA.subtractVecFromRow(j,pivrow,tims) # zero the column i in this row
      result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )
  echo tempA
#[]
      /// ->Vecf64 ,return x^ ( [C] x^ = f^ ) 
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

var A = matrix2D([[0.0,5,6],[4.0,5,7],[9.0,2,3]])
var b = colVector(3,[11.0,16,15])

discard solve(A,b)
