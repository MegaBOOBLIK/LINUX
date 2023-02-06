#!/bin/bash

###---ПЕРЕМЕННЫЕ---###
MY_PATH=/home/main/scripts
NEED_DATE=`date +%F --date="1 days ago"`
TEMP_DIR=$MY_PATH/temp
FILE="index.php?a=IPSummary&date=$NEED_DATE"


###---САМ СКРИПТ---###

wget "http://router/mysar/$FILE"
echo "<html><body><center>" >> $MY_PATH/new_index.html
echo "<center><a href='http://router/mysar/$FILE'>ССЫЛКА НА САЙТ ОТЧЁТА</a></center>" >> $MY_PATH/new_index.html
cat ./$FILE | while read i
do
echo $i | grep "Set this view as the default" > /dev/null
b=$?
echo $i | grep "Latest user activity" > /dev/null
c=$?
echo $i | grep "images/up-arrow.gif" > /dev/null
d=$?
if [ "$d" == "0" ]; then continue; fi
echo $i | grep "images/down-arrow.gif" > /dev/null
e=$?
if [ "$e" == "0" ]; then continue; fi
if [ "$b" == "0" ]; then n=1; fi
if [ "$c" == "0" ]; then n=0; fi
if [ "$n" == "1" ]
then
echo ${i//\/mysar/http:\/\/router\/mysar} >> $MY_PATH/new_index.html
fi
done
echo "</center></body></html>" >> $MY_PATH/new_index.html

cat $MY_PATH/new_index.html | sendEmail -t it@kodi.karelia.ru -u "SQIUD REPORT (`date +%F\ %T`)"

rm $FILE
rm $MY_PATH/new_index.html
