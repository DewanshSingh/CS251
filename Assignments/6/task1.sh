s="$1"
t="$2"
foo=$s
foo+=".gcov"
echo "branchline","bias","testcase"> result1.csv
true="1";
first="1";
declare -i counter=0
tchar="t"
gcc -fprofile-arcs -ftest-coverage "$s"
while IFS= read -r line; do
  counter=$((counter+1))
  tchar+="$counter"
  ./a.out $line
#line bias
  gcov -b "$s"
  prevline="0 0 0"
  # > result13.csv
  # > result12.csv
  while read line; do
    a=( $line )
    if [[ ${a[0]} == "branch" ]] && [[ ${a[1]} == "0" ]]
    then
      x=( ${a[3]} )
      x=${x%?}
      # if [[ $first == "1"  ]]
      # then
      #   b=( $prevline )
      #   y=( ${b[1]} )
      #   y=${y%?}
      #   echo "$y" "$x" >> result11.csv
      #else
        b=( $prevline )
        y=( ${b[1]} )
        y=${y%?}
        echo "$y","$x","$tchar" >> result1.csv
      #fi
    fi
    prevline=$line
  done < "$foo"
  #paste result11.csv result12.csv > result13.csv
  #cat result13.csv > result11.csv
  # if [[ $first == "1"  ]]
  # then
  #   first="0"
  # fi
  tchar="t"
  if [[ $counter == 5 ]]
  then
    break
  fi
done < "$t"

dir=$(pwd)

touch 1.R
echo "setwd(\"$dir\")
q=read.csv(\"result1.csv\")
library(ggplot2)
d <- data.frame(q)
p = ggplot(data = d, aes(fill=branchline,x = branchline, y = bias)) + geom_bar(stat='identity')+ facet_grid(~testcase, scale='free_x') +theme_minimal()
p" > 1.R
R CMD BATCH 1.R
mv Rplots.pdf Rplots1.pdf

echo "setwd(\"$dir\")
q=read.csv(\"result1.csv\")
library(ggplot2)
d <- data.frame(q)
p = ggplot(data = d, aes(color=testcase,x = branchline, y = bias)) + geom_line() + theme_minimal()
p" > 2.R
R CMD BATCH 2.R
mv Rplots.pdf Rplots2.pdf



# awk -F " " -v var="${counter}" '
# {
#     sum=0;
#     for (i=2; i<=NF; i=i+1)
#     {
#         sum+=$i;
#     }
#     $1=$1","
#     print $1sum;
# }' result11.csv > result2.csv
