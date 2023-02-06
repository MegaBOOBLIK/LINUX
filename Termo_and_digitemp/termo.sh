#!/bin/bash

log=/var/log/termo.log
PHONE="89212230911"

tmax=30

cd /home/main/Skripts

treal=`digitemp_DS9097 -a -q -o "%.C"`

if [ "$treal" -ge "$tmax" ]
 then
  echo `date +%d-%m-%Y` _ `date +%R` _ $treal>>$log
  for p in $PHONE
  do
   echo "WARNING "$treal" !!!" | gammu sendsms TEXT $p
  done
fi
