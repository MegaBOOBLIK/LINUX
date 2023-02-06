#!/bin/bash
cd /home/main/TERMO
log=/var/log/termo.log
fname=/home/main/TERMO/termo.rez
mydate=`date +%d.%m.%Y`
mytime=`date +%R`
tmax=25

numero1=89212230911
numero2=89116636336

treal=`digitemp_DS9097 -a -q -o "%.C"`

if [ "$treal" -ge "$tmax" ]
then
	echo -e "$mydate $mytime\n$treal GRADUSOV !!!">$fname
	echo "$mydate $mytime >>> $treal GRADUSOV">>$log

	scp $fname main@192.168.1.100:/media/backup/SMS/$numero1
	scp $fname main@192.168.1.100:/media/backup/SMS/$numero2
	rm $fname
else
	echo "OK"
fi
