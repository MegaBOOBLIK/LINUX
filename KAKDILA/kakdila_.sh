#!/bin/bash
# Номера через пробел
PHONE="89212230911"

sending(){
  for p in $PHONE
  do
#   NOW=$(date +%d-%m-%Y" "%H:%M)
   echo $1 | gammu sendsms TEXT $p
  done
}

# инициализация переменных результата
# по умолчанию считается, что всё ОК
result=INET_ECTb
presult=CBET_ECTb

# задержка в сеундах чтоб всё прогрузилось при первом старте пк
sleep 60

# бесконечный цикл
while [ true ]; do

# пинг хоста с последующей проверкой на ошибки
errorscount="$(ping -c 3 ya.ru 2<&1| grep -icE 'unknown|expired|unreachable|time out')"

# если предыдущий пинг был удачен, а текущий нет, то
if [ "$result" = INET_ECTb -a "$errorscount" != 0 ]; then
 result=INET_HET # запоминаем результат текущего пинга
 sending "$result"
fi

# если предыдущий пинг был неудачен, а текущий успешен, то
if [ "$result" = INET_HET -a "$errorscount" = 0 ]; then
 result=INET_ECTb # запоминаем результат текущего пинга
 sending "$result"
fi

# проверка питалова
if on_ac_power; then
 perrorscount=0
 else
 perrorscount=1
fi

# если предыдущая проверка была удачна, а текущая нет, то
if [ "$presult" = CBET_ECTb -a "$perrorscount" != 0 ]; then
 presult=CBETA_HET # запоминаем результат текущего пинга
 sending "$presult"
fi

# если предыдущая проверка была неудачна, а текущая успешна, то
if [ "$presult" = CBETA_HET -a "$perrorscount" != 1 ]; then
 presult=CBET_ECTb # запоминаем результат текущего пинга
 sending "$presult"
fi

# задержка в секундах 300 = 5 min
sleep 300
done
