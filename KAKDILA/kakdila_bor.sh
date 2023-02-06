#!/bin/bash

# Номера через пробел
PHONE="89212230911"
HOSTS="192.168.0.100 192.168.0.101 192.168.0.103 192.168.0.104 192.168.0.106 192.168.0.2 192.168.0.202 192.168.0.250 192.168.0.252"

MSG0=" HET Inet... =("
MSG1=" ECTb Inet!!!"
MSG2=" POWER LOST..."
MSG3=" DALI SVET!"

sending(){
  for p in $PHONE
  do
   NOW=$(date +%d-%m-%Y" "%H:%M)
   echo $NOW $1
   echo $1 | gammu sendsms TEXT $p
  done
}

# инициализация переменной результата, по умолчанию считается, что связь уже есть
result=connected
presult=on

# задержка в сеундах чтоб всё прогрузилось
#sleep 60

# бесконечный цикл
while [ true ]; do
echo "."
MSG=""

# пинг хоста с последующей проверкой на ошибки
errorscount="$(ping -c 3 ya.ru 2<&1| grep -icE 'unknown|expired|unreachable|time out')"

# если предыдущий пинг был удачен, а текущий нет, т.е. вывод содержит ошибки, то
if [ "$result" = connected -a "$errorscount" != 0 ]; then
 result=disconnected   # запоминаем результат текущего пинга
 sending "$MSG0"
fi

# если предыдущий пинг был неудачен, а текущий успешен, то
if [ "$result" = disconnected -a "$errorscount" = 0 ]; then
 result=connected   # запоминаем результат текущего пинга
 sending "$MSG1"
fi

# проверка питалова
if [ -f "/etc/apcupsd/power_lost" ]; then
 rm /etc/apcupsd/power_lost
 sending "$MSG3"
fi

# проверка хостов
for h in $HOSTS
do
 fping -u $h >& /dev/null
  if [ $? -ne 0 ]; then
   MSG=${MSG}${h}'- ';
  fi
done

if [ -z $MSG ]
then
    echo "ok"
else
    echo $MSG
    sending "$MSG"
fi

# задержка в секундах
echo "+"
sleep 350

done

exit 0
