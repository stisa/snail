# Package

version       = "0.1.0"
author        = "Stisa"
description   = "Simple Naive Algebra for Nim"
license       = "MIT"


# Dependencies

requires "nim >= 0.14.0"

task bench, "TODO":
  echo "TODO"

task test, "Run tests":
  # Tests inside modules
  exec("nim c -r --hints:off  snail/vector.nim")
  exec("nim c -r --hints:off snail/matrix.nim")
  exec("nim c -r --hints:off snail/linsys.nim")
  # Tests inside tests folder
  exec("nim c -r --hints:off tests/tlinsys.nim")

import ospaths

task docs, "Builds documentation and examples":
  mkDir("docs"/"snail")
  exec "nim doc2 -o:docs/index.html  snail.nim"
  for file in listfiles("snail"):
    echo "> "&file
    if splitfile(file).ext == ".nim":
      exec "nim doc2 -o:" & "docs" /../ file.changefileext("html") & " " & file