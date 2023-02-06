#!/bin/bash

mydate=`date +%d.%m.%Y`
mytime=`date +%R`

echo "!!!!!!!!!!!!!!!!!!!!$mydate     $mytime">/dev/ttyS0
#echo -e "1111111111111111111">/dev/ttyS0

#echo "$mydate $mytime >>> $treal GRADUSOV">>$log

