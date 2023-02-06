#!/bin/bash

log=/var/log/sendsms.log

place=/media/backup/SMS
place2=/home/main/Dropbox/SMS

# Кладём сюда файлик,
# имя файла - номер телефона,
# вида 8921ХХХХХХХ !!! без расширения.
# Внутри файла текст СМС, 69 символов.

find $place/* -type f | while read fname
 do
  echo `date +%d-%m-%Y` _ `date +%R` _ `basename $fname` _ `<$fname`>>$log
  echo "`<$fname`" | gammu sendsms TEXT `basename $fname`>>$log
  rm $fname
 done


find $place2/* -type f | while read fname
 do
  echo `date +%d-%m-%Y` _ `date +%R` _ `basename $fname` _ `<$fname`>>$log
  echo "`<$fname`" | gammu sendsms TEXT `basename $fname`>>$log
  rm $fname
 done
