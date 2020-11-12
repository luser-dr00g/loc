#! /bin/bash
#locc.sh - count lines after stripping blank lines and full-line comments

total=0
declare -a list
awkpat='!/^$/ && !/^\/\//' 
perlpat='s/\/\*.*?\*\///sg;print'

printsum() {
    wid=$( echo $total | wc -c )
    for i in $list ; do
        n=$( echo $i | cut -d: -f1 )
        f=$( echo $i | cut -d: -f2 )
        printf "%${wid}s %s\n" "$n" "$f"
    done
    printf "%${wid}s Total\n" "$total"
}

countsloc() {
    lines=$(awk "$awkpat" $1 | perl -n0e "$perlpat" | wc -l)
    total=$(( $total + $lines ))
    list+="$lines:$1 "
}

if [ $# -eq 0 ]; then # no input, read from stdin
    awk "$awkpat" | perl -n0e "$perlpat" | wc -l
    exit
elif [ -d $1 ]; then # input is a directory, run locc on each file
    for i in ${@:2} ; do
        for f in $(find $1 -type f -name $i); do countsloc $f ; done
    done
else # input is a list of files read from stdin
    for i in $@ ; do countsloc $i ; done
fi
printsum
