import matrix,vector

proc findRowWithMaxInCol*[N,M:static[int]](A: Matrix[N,M],col:int):int =
  assert(col<M)
  var last_max = A[0,col]
  for i in 0..<N:
    if A[i,col]>last_max:
      last_max = A[i,col]
      result = i

proc swapRow*[N,M:static[int]](A: var Matrix[N,M],frm,to:int) =
  # Swap row frm with row to
  assert(frm<N)
  assert(to<N)
  for i in 0..<M:
    let f = A[frm,i]
    A[frm,i] = A[to,i]
    A[to,i] = f

proc swapCol*[N,M:static[int]](A: var Matrix[N,M],frm,to:int) =
  # Swap col frm with col to
  assert(frm<M)
  assert(to<M)
  for i in 0..<N:
    let f = A[i,frm]
    A[i,frm] = A[i,to]
    A[i,to] = f

proc subtractRows*[N,M:static[int]](A:var Matrix[N,M],fm,wht:int,tims:float=1.0)=
  #Subtract wht from fm tims times
  for j in 0..<M: A[fm,j] = A[fm,j]-A[wht,j]*tims

proc subtractCols*[N,M:static[int]](A:var Matrix[N,M],fm,wht:int,tims:float=1.0)=
  #Subtract wht from fm tims times
  for j in 0..<N: A[j,fm] = A[j,fm]-A[j,wht]*tims

proc ppge*[N:static[int]](A: Matrix[N,N],b:ColVector[N]):ColVector[N] =
  ## Solve the system Ax=b for x. Does not modify A
  ## Uses Gaussian Elimination with partial pivoting
  var tempA = A
  when not defined js:
    deepCopy(result, b)  
    deepCopy(tempA,A)

  for i in 0..<N: # Iterate over rows
    if i!=N-1: # Don't swap on the last iteration, it's already row echelon
      let imx = tempA.findRowWithMaxInCol(i)
      tempA.swapRow(imx,i)
      
      # Swap the elements in the knonws vector
      let tmp = result[imx] 
      result[imx] = result[i]
      result[i] = tmp

    let piv = tempA[i,i]
    tempA.divRowBy(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)

    for j in 0..<N: # Iterate over rows

      if j != i:
        let tims = tempA[j,i] # Save the times we have to subtract to zero the column i
        tempA.subtractRows(j,i,tims) # zero the column i in this row
        result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )
