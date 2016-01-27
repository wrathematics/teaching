### Example
x=something
x = something # NO!

x="something else"

echo $x

x=`ls ~ | grep D`
echo $x




### Example
head -2 pop.csv founded.csv

grep -i nashville *.csv

less diamonds.csv




### Dropping Lines
sed -i /^$/d diamonds.csv | head

sort -u diamonds.csv | head

tail -n +2 diamonds.csv | head




### Convert CSV to TSV
sed 's/,/\t/g' diamonds.csv | head
sed 's/,/\t/g' diamonds.csv > diamonds.tsv

awk 'BEGIN {FS=","; OFS="\t"} {$1=$1; print}' diamonds.csv | head




### Dropping a Variable
cut -f 3 diamonds.tsv  | head
cut --complement -f 3 diamonds.tsv  | head

cut --complement -f 3 -d, diamonds.csv  | head

mv diamonds.csv diamonds.csv.old
cut --complement -f 3 -d, diamonds.csv.old > diamonds.csv
rm diamonds.csv.old




### Subsetting Diamonds
grep Premium diamonds.tsv | head

grep -v Premium diamonds.tsv | head

grep "Premium\|Very Good" diamonds.tsv | head




### Stacking Files with cat
cat pop.csv founded.csv > stacked.csv
cat stacked.csv




### Joining with join
join -t, pop.csv founded.csv > joined.csv




### Counts
wc diamonds.csv
wc -l diamonds.csv
wc -l diamonds.csv | sed 's/ .*//'




### Unique Observations
sort -u diamonds.csv | wc -l


tot=`wc -l diamonds.csv | sed 's/ .*//'`
unq=`sort -u diamonds.csv | wc -l`
echo $(($tot - $unq))




### Basic Variable Operations
awk -F '\t' '{ sum += $5 } END { print sum }' diamonds.tsv
awk -F ',' '{ sum += $5 } END { print sum }' diamonds.csv

awk -F '\t' '{ sum += $5 } END { print sum/NR }' diamonds.tsv
awk -F '\t' '{ sum += $4 } END { print sum/NR }' diamonds.tsv




### Making a Histogram
# histogram
tail -n +2 diamonds.csv | cut -d, -f 2 | sort | uniq -c > hist.txt
cat hist.txt
sort -rn hist.txt -o hist.txt
cat hist.txt


sed -i -e 's/^ *//g' -e 's/ /,/' hist.txt
cat hist.txt
sed -i '1 i\Count,Cut' hist.txt
cat hist.txt

