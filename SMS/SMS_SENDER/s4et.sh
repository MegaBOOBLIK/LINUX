#!/bin/bash

min_s4et=100

sleep 30 & s4et=`gammu getussd "#102#" | grep Service | cut -d: -f2 | cut -d" " -f4 | cut -d"." -f1`

#while [ -z $s4et ]
#do
#if [ ! -z $s4et ]; then break; fi
#sleep 30 & s4et=`gammu getussd "#102#" | grep Service | cut -d: -f2 | cut -d" " -f4 | cut -d"." -f1`
#done
echo $s4et
