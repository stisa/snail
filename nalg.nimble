# Package

version       = "0.1.0"
author        = "Stisa"
description   = "Nim Naive Algebra"
license       = "MIT"


# Dependencies

requires "nim >= 0.14.0"

switch("-d:","openblas") # to be removed after developement

task bench, "TODO":
  echo "TODO"

task tests, "TODO":
  echo "TODO"
  