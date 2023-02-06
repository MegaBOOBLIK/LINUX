#!/bin/bash
# 2023-01-25 

# Номера через пробел
PHONE="89212230911"

# по умолчанию считается, что всё ОК
preresult=INET_ECTb

sending(){
 for p in $PHONE
 do
 echo $1 | gammu sendsms TEXT $p
 done
}

pingtest(){
 ping -c 5 8.8.8.8
 rezult=$?
}

while [ true ]; do
 #delay 1 min
 sleep 60

 pingtest
 #echo $rezult

 if [ "$preresult" = INET_ECTb -a "$rezult" != 0 ]
 # если предыдущий пинг был удачен, а текущий нет, то
 then
  preresult=INET_HET # запоминаем результат текущего пинга
  sending "$preresult"
 elif [ "$preresult" = INET_HET -a "$rezult" = 0 ]
 #если предыдущий пинг был неудачен, а текущий успешен, то
 then
  preresult=INET_ECTb # запоминаем результат текущего пинга
  sending "$preresult"
 fi
done
