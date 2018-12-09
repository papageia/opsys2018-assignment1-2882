#!/bin/bash
file="addresses"
i=1
while IFS='' read -r line || [[ -n $line ]]
do 
if [ ${line:0:1} != '#' ] 
then
  wget "$line" -q -O temp.txt
if [ ! -s temp.txt ]
then
  echo "$line FAILED"

elif [ ! -e address$i.txt ]
then
  echo "$line INIT"
  wget "$line" -q -O address$i.txt
else 
  if ! cmp -s address$i.txt temp.txt;
then
  echo "$line"
  wget "$line" -q -O address$i.txt
fi
fi
i=$((i+1))
fi
done < $file


