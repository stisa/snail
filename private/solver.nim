proc ngaussInplace*[N:static[int]](A:var Matrix[N,N],b:Vector[N]):Vector[N] =
  ## Solve the system Ax=b for x, using A to store partial results
  result = b
  
  for i in 0..<N: # Iterate over rows    
    let piv = A[i,i]
    A.divRowByFloat(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)
    
    let pivrow = A.row(i) # Save the row to reuse it later
    
    for j in 0..<N: # Iterate over rows

      if j == i: continue # skip this if considering current pivoted row

      let tims = A[j,i] # Save the times we have to subtract to zero the column i
      A.subtractVecFromRow(j,pivrow,tims) # zero the column i in this row
      result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )
  result.isCol = true
  
proc ngauss*[N:static[int]](A: Matrix[N,N],b:Vector[N]):Vector[N] =
  ## Solve the system Ax=b for x. Does not modify A
  # TODO: only allow colum vectors for knonws?
  deepCopy(result, b)
  var tempA = A
  deepCopy(tempA,A)
  
  for i in 0..<N: # Iterate over rows    
    let piv = tempA[i,i]
    tempA.divRowByFloat(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)
    
    let pivrow = tempA.row(i) # Save the row to reuse it later
    
    for j in 0..<N: # Iterate over rows

      if j == i: continue # skip this if considering current pivoted row

      let tims = tempA[j,i] # Save the times we have to subtract to zero the column i
      tempA.subtractVecFromRow(j,pivrow,tims) # zero the column i in row j
      result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )
  result.isCol = true

proc pgauss*[N:static[int]](A: Matrix[N,N],b:Vector[N]):Vector[N] =
  ## Solve the system Ax=b for x. Does not modify A
  ## Uses Gaussian Elimination with partial pivoting
  deepCopy(result, b)
  var tempA = A
  deepCopy(tempA,A)

  for i in 0..<N: # Iterate over rows
    if i!=N-1: # Don't swap on the last iteration, it's already row echelon
      let imx = tempA.findRowWithMaxInCol(i)
      tempA.swapRow(imx,i)
      
      let tmp = result[imx] 
      result[imx] = result[i]
      result[i] = tmp

    let piv = tempA[i,i]
    tempA.divRowByFloat(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)

    for j in 0..<N: # Iterate over rows

      if j != i:
        let tims = tempA[j,i] # Save the times we have to subtract to zero the column i
        tempA.subtractRows(j,i,tims) # zero the column i in this row
        result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )
  
  result.isCol = true


proc pgaussInplace*[N:static[int]](A: var Matrix[N,N],b:Vector[N]):Vector[N] =
  ## Solve the system Ax=b for x. Does not modify A
  ## Uses Gaussian Elimination with partial pivoting
  for i in 0..<N: # Iterate over rows
    if i!=N-1: # Don't swap on the last iteration, it's already row echelon
      let imx = A.findRowWithMaxInCol(i)
      A.swapRow(imx,i)
      
      let tmp = result[imx] 
      result[imx] = result[i]
      result[i] = tmp

    let piv = A[i,i]
    A.divRowByFloat(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)

    for j in 0..<N: # Iterate over rows

      if j != i:
        let tims = A[j,i] # Save the times we have to subtract to zero the column i
        A.subtractRows(j,i,tims) # zero the column i in this row
        result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )
  
  result.isCol = true

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

proc subtractRows*[N:static[int]](A:var Matrix[N,N],fm,wht:int,tims:float=1.0)=
  #Subtract wht from fm tims times
   for j in 0..<N: A[fm,j] = A[fm,j]-A[wht,j]*tims

proc solve*[N:static[int]](A: Matrix[N,N],b:Vector[N]):Vector[N] =
  ## Solve the system Ax=b for x. Does not modify A
  ## Uses Gaussian Elimination with partial pivoting
  deepCopy(result, b)
  var tempA = A
  deepCopy(tempA,A)

  for i in 0..<N: # Iterate over rows
    if i!=N-1: # Don't swap on the last iteration, it's already row echelon
      let imx = tempA.findRowWithMaxInCol(i)
      tempA.swapRow(imx,i)
      
      let tmp = result[imx] 
      result[imx] = result[i]
      result[i] = tmp

    let piv = tempA[i,i]
    tempA.divRowByFloat(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)

    for j in 0..<N: # Iterate over rows

      if j != i:
        let tims = tempA[j,i] # Save the times we have to subtract to zero the column i
        tempA.subtractRows(j,i,tims) # zero the column i in this row
        result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )
  
  result.isCol = true