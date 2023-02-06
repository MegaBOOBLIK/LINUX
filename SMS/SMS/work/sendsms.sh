#!/bin/bash
place=/media/backup/SMS/* #Где...

find $place -type f | while read FILENAME
	do
#		body=`<$FILENAME`
#		nomer=`basename $FILENAME`
#		echo "$body" | gammu sendsms TEXT $nomer
		echo "`<$FILENAME`" | gammu sendsms TEXT `basename $FILENAME`

	done
