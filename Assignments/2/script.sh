ps aux | grep "/bin" > file1.csv
tr -s '[:blank:]' ',' <file1.csv> file2.csv
cut -d, -f2,11 file2.csv > file3.csv
awk '{gsub("/usr/bin/","");print}' file3.csv > file4.csv
ls -al /bin > file5.csv
tr -s '[:blank:]' ',' <file5.csv> file6.csv
ls -al /usr/bin > file7.csv
tr -s '[:blank:]' ',' <file7.csv> file8.csv
sed -i 1d file6.csv
sed -i 1d file8.csv
cut -d, -f1,2,9 file6.csv > file9.csv
cut -d, -f1,2,9 file8.csv > file10.csv
cat file9.csv >> file10.csv
join -t, --nocheck-order -1 2 -2 3 file4.csv file10.csv > file11.csv
cat file11.csv

