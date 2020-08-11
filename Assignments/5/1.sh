s=$1
t=$2
gcc -ftest-coverage -fprofile-arcs $s > /dev/null
read -r line < $t
./a.out $line 
gcov $s 
awk -F ":" '{print $2 $1}' "$s.gcov" > 1.csv
awk '{gsub("-","0");gsub("#####","0")}1' 1.csv > 2.csv
awk -F " "  '{print $1 , $2}' 2.csv > 1.csv


