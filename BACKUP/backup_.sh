#!/bin/bash

server_name=`uname -n`
user=back
pass=save
today=`date +%y-%m-%d`
log=/var/log/backup.log
start_time=`date +%s`

echo >> $log
echo "############################################" >> $log
echo "Бекап начат $today в "`date +%H:%M` >> $log

if
tar -cpf /$today.tar /usr /var /home /etc /root
#sleep 180
    then
	echo "Затарено в "`date +%H:%M` >> $log
    else
	echo "Ошибка таренья "`date +%H:%M` >> $log
fi

ftp -n 192.168.1.100 <<EOF

quote user $user
quote pass $pass
mkdir backup/$server_name
mkdir backup/$server_name/$today
binary
send /$today.tar backup/$server_name/$today/$today.tar
quit

EOF

stop_time=`date +%s`
time=$(echo "scale=2; ($stop_time - $start_time)/60" | bc)
echo $time
echo "Бекап закончен $today в "`date +%H:%M`" и занял $time минут" >> $log

echo "vse good"
exit
