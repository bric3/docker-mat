#!/usr/bin/env zsh

# Removes generated files having the same name as hprof file
# But not the hprof file

setopt extendedglob
rm heap*~*.hprof(.)
#      ||       ^^^ Only plain files
#      ||^^^^^^^ files ending in ".hprof"
#      |\Except '~''
#      \For every file starting with 'heap'

#!/usr/bin/env bash
# shopt -s extglob
# rm heap*.!(hprof)
