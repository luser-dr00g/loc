# loc
Simple shell scripts for stripping comments and counting lines of code:


## Usage
- If no filename is provided, loc/c will read from stdin
### Strip comments and blank lines from input and write SLOC lines to stdout
```
$ loc.sh [FILE(s)]
```


### Count lines of SLOC from input and write to stdout
```
$ locc.sh [FILE(s)]
```
To count sloc for a directory, use
```
$ find /path/to/dir/ -type f \( -name "*.EXT1" -o -name "*.EXT2" \) | xargs locc.sh
```
