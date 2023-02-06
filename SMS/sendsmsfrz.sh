#!/bin/sh
#2023 FR

now=$(date +'%y-%m-%d %T')

log=/var/log/sendsms.log
place=/home/nimda/MSGtoSend #From

find $place/* -type f | while read fname

do
 echo $now >>$log
 echo `basename $fname` >>$log
 cat $fname >>$log
 echo '\r' >>$log
 cat $fname | gammu sendsms TEXT `basename $fname` -unicode >>$log
 echo '\r' >>$log
 rm $fname
done

