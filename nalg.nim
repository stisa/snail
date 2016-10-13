import "random-0.5.3/random",sequtils

include private/types
include private/prettyprint
include private/arrayutils
include private/operations
include private/solver

when isMainModule:
  include tests/ops