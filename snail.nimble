# Package

version       = "0.2.0"
author        = "Stisa"
description   = "Simple Naive Algebra for Nim"
license       = "MIT"

skipDirs = @["docs","tests"]
# Dependencies
requires "nim >= 0.17.0"

requires "nimblas" # Require it even if we may not use it, as nimble doesn't have optional deps for now.

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
  echo "DONE - serve /tests with some webserver and load index.html to run."

task docs, "Builds documentation":
  mkDir("docs"/"snail")
  exec "nim doc2 --verbosity:0 --hints:off -o:docs/index.html  snail.nim"
  for file in listfiles("snail"):
    if splitfile(file).ext == ".nim":
      exec "nim doc2 --verbosity:0 --hints:off -o:" & "docs" /../ file.changefileext("html") & " " & file
  echo "DONE - Look inside /docs, possibly serve it to a browser."

task prepublish,"Run tests, then build docs":
  exec "nimble tests"
  exec "nimble docs"