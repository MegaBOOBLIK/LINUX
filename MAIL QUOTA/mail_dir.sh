#!/bin/bash

mail_dir=\/var\/vmail\/kodi.karelia.ru
qwf="/tmp/mail_dir.$$"
tmp_file=/tmp/mail_dir_tmp.$$
FROM="mail@kodi"
TO="it@kodi.karelia.ru"



echo "Date: `date`" >> $qwf
echo "From: $FROM" > $qwf
echo "To: $TO" >> $qwf
echo "Subject: Состояние ящиков." >> $qwf
echo "" >> $qwf
dir=`du -m --max-depth=1 --time $mail_dir | sort -rn | sed -e "s/\/var\/vmail\/kodi.karelia.ru\///g"`


rm -f $tmp_file
echo "$dir" | while read i
do
line=`echo $i | cut -d " " -f1`"  "`echo $i | cut -d " " -f4`"  "`echo $i | cut -d " " -f2`"  "`echo $i | cut -d " " -f3`
echo $line >> $tmp_file
done

(printf "Size(Mb) Name Date Time\n" ;cat $tmp_file) | column -t >> $qwf
rm -f $tmp_file

echo "" >> $qwf

#echo "Состояние файловой системы:" >> $qwf
#df -h | grep dev/sda >> $qwf

#cat $qwf | /usr/sbin/sendmail $TO

#rm -f $qwf

#du -m --max-depth=1 --time $mail_dir | sort -rn | sed -e "s///g"
#du -m --max-depth=1 $mail_dir | sort -rn
