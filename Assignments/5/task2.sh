s="$1"
gcc -Wall -pg "$s"
./a.out #876 1 1  508  401  271 0  401  400 1 0 0
gprof -b -q a.out gmon.out > analysis.txt
t="analysis.txt"
> out1.csv
> out2.csv
prevline="0 0 0 0 0 0 0 0"
test="["
head --lines=-4 $t > out1.csv
tail --lines=+8 out1.csv > out2.csv
> out1.csv
#true="1"
while read line; do
  first="1"
  a=( $line )
  if [[ ${a[0]} == *$test* ]]
  then
    return="0"
    prevline=$line
    while read line; do
      if [[ $line == *---* ]]
      then
        break
      fi
      return="1"
      if [[ $first == "1" ]]
      then
        #echo $prevline
        if [[ $prevline == *main* ]]
        then
          b=( $prevline )
          printf ${b[4]},${b[2]} >> out1.csv
          #true="0"
        else
          b=( $prevline )
          printf ${b[5]},${b[2]} >> out1.csv
        fi
        first="0"
      fi
      c=( $line )
      printf ,${c[3]},${c[0]} >> out1.csv
    done
    if [[ $return == "1" ]]
    then
      printf "\n" >> out1.csv
    fi
  fi
done < out2.csv
#rm out2.csv
