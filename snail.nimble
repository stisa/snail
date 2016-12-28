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
  
task builddocs, "Builds documentation and examples":
  #exec("nim js -o:tests/webtest.js  tests/webtest.nim")
  exec("nim doc2 -o:docs/index.html  snail.nim")
  exec("nim doc2 -o:docs/snail/vector.html  snail/vector.nim")
  exec("nim doc2 -o:docs/snail/matrix.html  snail/matrix.nim")
  exec("nim doc2 -o:docs/snail/linsys.html  snail/linsys.nim")
  