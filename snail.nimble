# Package

version       = "0.1.0"
author        = "Stisa"
description   = "Simple Naive Algebra for Nim"
license       = "MIT"


# Dependencies

requires "nim >= 0.14.0"

import ospaths,strutils

task bench, "TODO":
  echo "TODO"

task tests, "Runs tests":
  withdir "tests":
    for file in listfiles("."):
      if splitfile(file).ext == ".nim":
        exec "nim c -r --verbosity:0 --hints:off " & file

task jstests, "Builds js tests":
  withdir "tests":
    let jsrc = "<script src=\"$1\"></script>"
    var jslist = ""
    for file in listfiles("."):
      if splitfile(file).ext == ".nim":
        exec "nim js --verbosity:0 --hints:off -o:" & file.changefileext("js") & " " & file
        jslist.add(jsrc % [file.changefileext("js")])
    writefile("index.html", "<html><body>$1</body></html>" % [jslist])
    

task docs, "Builds documentation":
  mkDir("docs"/"snail")
  exec "nim doc2 --verbosity:0 --hints:off -o:docs/index.html  snail.nim"
  for file in listfiles("snail"):
    echo "> "&file
    if splitfile(file).ext == ".nim":
      exec "nim doc2 --verbosity:0 --hints:off -o:" & "docs" /../ file.changefileext("html") & " " & file