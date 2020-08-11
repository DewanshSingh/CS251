s="$1"
while IFS= read -r line; do
  if [[ $line == *.h* ]]
  then
    a=( $line )
    y=( ${a[2]} )
    if [[ ${y:(-1)} == '/'  ]]
    then
      y="${y%?}"
    fi
    touch ${a[0]}
    mkdir -p $y/include
    if [[ ${a[1]} == *Read* ]]
    then
      chmod u+r ${a[0]}
      else
      chmod u-r ${a[0]}
    fi
    if [[ ${a[1]} == *Write* ]]
    then
      chmod u+w ${a[0]}
      else
      chmod u-w ${a[0]}
    fi
    if [[ ${a[1]} == *Execute* ]]
    then
      chmod u+x ${a[0]}
      else
      chmod u-x ${a[0]}
    fi
    mv ${a[0]} $y/include
  elif [[ $line == *.a* ]]
  then
    a=( $line )
    y=( ${a[2]} )
    if [[ ${y:(-1)} == '/'  ]]
    then
      y="${y%?}"
    fi
    touch ${a[0]}
    mkdir -p $y/lib
    if [[ ${a[1]} == *Read* ]]
    then
      chmod u+r ${a[0]}
      else
      chmod u-r ${a[0]}
    fi
    if [[ ${a[1]} == *Write* ]]
    then
      chmod u+w ${a[0]}
      else
      chmod u-w ${a[0]}
    fi
    if [[ ${a[1]} == *Execute* ]]
    then
      chmod u+x ${a[0]}
      else
      chmod u-x ${a[0]}
    fi
    mv ${a[0]} $y/lib
  elif [[ $line == *.pdf* ]]
  then
    a=( $line )
    y=( ${a[2]} )
    if [[ ${y:(-1)} == '/'  ]]
    then
      y="${y%?}"
    fi
    touch ${a[0]}
    mkdir -p $y/doc
    if [[ ${a[1]} == *Read* ]]
    then
      chmod u+r ${a[0]}
      else
      chmod u-r ${a[0]}
    fi
    if [[ ${a[1]} == *Write* ]]
    then
      chmod u+w ${a[0]}
      else
      chmod u-w ${a[0]}
    fi
    if [[ ${a[1]} == *Execute* ]]
    then
      chmod u+x ${a[0]}
      else
      chmod u-x ${a[0]}
    fi
    mv ${a[0]} $y/doc
  else
    a=( $line )
    y=( ${a[2]} )
    if [[ ${y:(-1)} == '/'  ]]
    then
      y="${y%?}"
    fi
    touch ${a[0]}
    mkdir -p $y/bin
    if [[ ${a[1]} == *Read* ]]
    then
      chmod u+r ${a[0]}
      else
      chmod u-r ${a[0]}
    fi
    if [[ ${a[1]} == *Write* ]]
    then
      chmod u+w ${a[0]}
      else
      chmod u-w ${a[0]}
    fi
    if [[ ${a[1]} == *Execute* ]]
    then
      chmod u+x ${a[0]}
      else
      chmod u-x ${a[0]}
    fi
    mv ${a[0]} $y/bin
  fi
done < "$s"
