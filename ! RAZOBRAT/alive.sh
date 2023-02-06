#!/bin/bash

HOSTS="192.168.1.1 192.168.1.5 192.168.1.121 192.168.1.101"
REP=""

for h in $HOSTS
do
 fping -u $h >& /dev/null
 if [ $? -ne 0 ]; then
  REP=${REP}${h}'-DOWN ';
 fi
done

echo $REP;

