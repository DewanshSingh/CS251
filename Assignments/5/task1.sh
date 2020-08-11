s="$1"
t="$2"
foo=$s
foo+=".gcov"
> result1.csv
> result11.csv
true="1";
first="1";
counter= 0
gcc -fprofile-arcs -ftest-coverage "$s"
while IFS= read -r line; do
  counter=$((counter+1))
  ./a.out $line
  gcov "$s"
  if [[ $true == "1"  ]]
  then
    awk -F ":" '{print $2}' "$foo" > result3.csv
    true="0";
  fi
  awk -F ":" '{print $1}' "$foo" > result1.csv
  awk '{gsub(/\-/,"0",$1)}1' result1.csv > result2.csv
  awk '{gsub(/\#####/,"0",$1)}1' result2.csv > result1.csv
  paste result3.csv result1.csv > result4.csv
  cat result4.csv > result3.csv
#line bias
  gcov -b "$s"
  prevline="0 0 0"
  > result13.csv
  > result12.csv
  while read line; do
    a=( $line )
    if [[ ${a[0]} == "branch" ]] && [[ ${a[1]} == "0" ]]
    then
      x=( ${a[3]} )
      x=${x%?}
      if [[ $first == "1"  ]]
      then
        b=( $prevline )
        y=( ${b[1]} )
        y=${y%?}
        echo "$y" "$x" >> result11.csv
      else
        echo "$x" >> result12.csv
      fi
    fi
    prevline=$line
  done < "$foo"
  paste result11.csv result12.csv > result13.csv
  cat result13.csv > result11.csv
  if [[ $first == "1"  ]]
  then
    first="0"
  fi
done < "$t"
gcov $s
awk -F " " '
{
    sum=0;
    for (i=2; i<=NF; i=i+1)
    {
        sum+=$i;
    }
    $1=$1","
    print $1sum;
}' result3.csv > result1.csv
tail --lines=+6 result1.csv > result3.csv
cat result3.csv > result1.csv
awk -F " " -v var="${counter}" '
{
    sum=0;
    for (i=2; i<=NF; i=i+1)
    {
        sum+=$i;
    }
    sum=sum/var
    $1=$1","
    print $1sum;
}' result11.csv > result2.csv
rm result3.csv
rm result4.csv
rm result12.csv
rm result11.csv
rm result13.csv
