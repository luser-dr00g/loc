#! /bin/sh
#loc.sh - strip blank lines and full line comments

if [ $# -eq 0 ]; then
    awk "!/^$/" | awk "!/^\/\//" | perl -n0e 's/\/\*.*?\*\///sg;print'
else
    for i in $@ ; do
        awk "!/^$/ && !/^\/\//"  $i | perl -n0e 's/\/\*.*?\*\///sg;print' 
    done
fi
