proc solveInplace*[N:static[int]](A:var Matrix[N,N],b:Vector[N]):Vector[N] =
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

proc solve*[N:static[int]](A: Matrix[N,N],b:Vector[N]):Vector[N] =
  ## Solve the system Ax=b for x. Does not modify A
  result = b
  var tempA = A
  
  for i in 0..<N: # Iterate over rows    
    let piv = tempA[i,i]
    tempA.divRowByFloat(i,piv) # Divide row by pivot
    result[i] = result[i]/piv # Divide known vector at row i too ( easier than extending the matrix ?)
    
    let pivrow = tempA.row(i) # Save the row to reuse it later
    
    for j in 0..<N: # Iterate over rows

      if j == i: continue # skip this if considering current pivoted row

      let tims = tempA[j,i] # Save the times we have to subtract to zero the column i
      tempA.subtractVecFromRow(j,pivrow,tims) # zero the column i in this row
      result[j] = result[j]-result[i]*tims # subtract the known i from known j ( still easier than extending the matrix )
