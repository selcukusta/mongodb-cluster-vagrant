#!/bin/bash
echo "var cfg = {_id: \"rs_vagrant\", members: [" >> $4
echo "{_id:0, host:\"$1:27017\"}," >> $4
i=1
while [ $i -le $2 ]
do
  if [ $i -ne $2 ]
  then
    echo "{_id: $i, host: \"$3$i:27017\"}," >> $4
  else
    echo "{_id: $i, host: \"$3$i:27017\"}" >> $4
  fi
  ((i++))
done
echo "]};" >> $4
echo "rs.initiate(cfg);" >> $4