#!/bin/bash

server_name=`uname -n`
user=back
pass=save
today=`date +%y-%m-%d`
log=/var/log/backup.log
start_time=`date +%s`

#sleep 600

echo | tee -a $log
echo "############################################" | tee -a $log
echo "Бекап начат $today в "`date +%H:%M` | tee -a $log

tar -cpf /$today.tar /usr /var /home /etc /root --exclude=/var/spool --exclude=/var/run 2>/dev/null
	st=$?
	echo "Затарено в "`date +%H:%M`" вывод $st" | tee -a $log

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
echo "Бекап закончен $today в "`date +%H:%M`" и занял $time минут" | tee -a $log

tail -n 4 $log | sendmymail "Mail BACKUP"

rm /$today.tar

echo "vse good"
exit
