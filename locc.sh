#! /bin/bash
#locc.sh - count lines after stripping blank lines and full-line comments

total=0
declare -a list
awkpat='!/^$/ && !/^\/\//' 
perlpat='s/\/\*.*?\*\///sg;print'

if [ $# -eq 0 ]; then
    awk $awkpat | perl -n0e $perlpat | wc -l
else
    for i in $@ ; do
        lines=$(awk "$awkpat" $i | perl -n0e "$perlpat" | wc -l)
        total=$(( $total + $lines ))
        list+="$lines:$i "
    done
    wid=$( echo $total | wc -c )
    for i in $list ; do
        n=$( echo $i | cut -d: -f1 )
        f=$( echo $i | cut -d: -f2 )
        printf "%${wid}s %s\n" "$n" "$f"
    done
    printf "%${wid}s Total\n" "$total"
fi
