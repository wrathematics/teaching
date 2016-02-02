#!/bin/bash

### Making a Histogram
# We didn't talk about this in class or in the handouts, but you can
# pass arguments to a shell script.  Here "$1" is the first argument,
# and $2 is the second (see below for details about what they are).

### Use
# First argument: csv data file
# Second argument: factor column
# Example:
# ./hist.sh diamonds.csv 2


# Extract variables and counts
tail -n +2 $1 | cut -d, -f $2 | sort | uniq -c > .__hist.txt
sort -rn .__hist.txt -o .__hist.txt
sed -i -e 's/^ *//g' -e 's/ /,/' -e 's/ /_/g' .__hist.txt

count=`cut -d, -f 1 .__hist.txt`
var=`cut -d, -f 2 .__hist.txt`
rm .__hist.txt

# Find character lengths (to make all the ascii bars line up later)
maxlen=0
for v in $var; do
  tmp=`echo $v | wc -c`
  lens=`echo $lens $tmp`
  if [ $tmp -gt $maxlen ]; then
    maxlen=$tmp
  fi
done

# Convert counts to percentages
tot=0
for ct in $count;do
  tot=$(($tot + $ct))
done

for ct in $count;do
  tmp=`echo "$ct $tot" | awk '{ print ($1 / $2) * 100}'`
  pct=`echo $pct $tmp`
done

pct=`printf "%.0f\n" $pct`


### BASH exclusive features!

# Construct arrays
var=($var)
pct=($pct)
lens=($lens)

# array len
n=${#pct[@]}

# print the bars
for i in `seq 0 $(($n-1))`;do
  echo -n "${var[$i]}  "
  
  j=${lens[$i]}
  while [ $j -le $maxlen ];do
    echo -n " "
    j=$(($j+1))
  done
  
  j=0
  while [ $j -lt ${pct[$i]} ];do
    echo -n "#"
    j=$(($j+1))
  done
  echo ""
done


