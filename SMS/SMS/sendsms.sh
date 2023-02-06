#!/bin/bash
log=/var/log/sendsms.log
place=/media/backup/SMS #Где...

find $place/* -type f | while read fname
	do
		echo `<$fname` - `basename $fname`  >>$log
		echo "`<$fname`" | gammu sendsms TEXT `basename $fname`>>$log
		rm $fname
	done
