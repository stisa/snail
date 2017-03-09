# Package

version       = "0.1.0"
author        = "Stisa"
description   = "Simple Naive Algebra for Nim"
license       = "MIT"


# Dependencies

requires "nim >= 0.14.0"

import ospaths

task bench, "TODO":
  echo "TODO"

task tests, "Run tests":
  withdir "tests":
    for file in listfiles("."):
      if splitfile(file).ext == ".nim":
        exec "nim c -r --verbosity:0 --hints:off " & file

task docs, "Builds documentation and examples":
  mkDir("docs"/"snail")
  exec "nim doc2 --verbosity:0 --hints:off -o:docs/index.html  snail.nim"
  for file in listfiles("snail"):
    echo "> "&file
    if splitfile(file).ext == ".nim":
      exec "nim doc2 --verbosity:0 --hints:off -o:" & "docs" /../ file.changefileext("html") & " " & file