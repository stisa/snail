# Package

version       = "0.1.0"
author        = "Stisa"
description   = "Naive Algebra for Nim"
license       = "MIT"


# Dependencies

requires "nim >= 0.14.0"

task bench, "TODO":
  echo "TODO"

task tests, "TODO":
  echo "TODO"

task builddocs, "Builds documentation and examples":
  exec("nim js -o:tests/webtest.js  tests/webtest.nim")
  