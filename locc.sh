#! /bin/bash
#locc.sh - count lines after stripping blank lines and full-line comments

total=0
declare -a list

if [ $# -eq 0 ]
  then
    awk "!/^$/" | awk "!/^\/\//" | perl -n0e 's/\/\*.*?\*\///sg;print' | wc -l
  else
    for i in $@ ;
      do
        lines= $( awk "!/^$/ && !/^\/\//"  $i | perl -n0e 's/\/\*.*?\*\///sg;print' | wc -l )
        total= $(( $total + $lines ))
        list+= "$lines:$i "
      done
    wid=$( echo $total | wc -c )
    for i in $list ;
      do
        #echo $i
        n=$( echo $i | cut -d: -f1 )
        f=$( echo $i | cut -d: -f2 )
        printf "%${wid}s %s\n" "$n" "$f"
      done
    printf "%${wid}s Total\n" "$total"
fi

