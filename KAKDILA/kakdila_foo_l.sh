#!/bin/bash

# Номера через пробел
PHONE="89212230911"

MSG0=" HET Inet... =("
MSG1=" ECTb Inet!!!"
MSG2=" POWER LOST..."
MSG3=" DALI SVET!"

sending(){
  for p in $PHONE
  do
   NOW=$(date +%d-%m-%Y" "%H:%M)
   echo $NOW $1
#   echo `date %d-%m-+%Y" "%H:%M`$1 | gammu sendsms TEXT $p
  done
}

# инициализация переменной результата, по умолчанию считается, что связь уже есть
result=connected
presult=on

# задержка в сеундах чтоб всё прогрузилось
#sleep 60

# бесконечный цикл
while [ true ]; do

if [ -f "/etc/passwd" ]; then echo "Файл существует"; fi

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
if on_ac_power; then 
 perrorscount=0 
 else 
 perrorscount=1
fi

# если предыдущая проверка была удачна, а текущая нет, то
if [ "$presult" = on -a "$perrorscount" != 0 ]; then
 presult=off   # запоминаем результат текущего пинга
 sending "$MSG2"
fi

if [ "$presult" = off -a "$perrorscount" != 1 ]; then
 presult=on   # запоминаем результат текущего пинга
 sending "$MSG3"
fi

# задержка в секундах
echo "."
sleep 3
#00
echo "."
done
