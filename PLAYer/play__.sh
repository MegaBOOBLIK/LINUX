#!/bin/bash

# Рабочие папки
mess=/home/main/MESSAGE
moff=/home/main/MESSOFF
list=/home/main/MUSIK
time0=1705

# Пауза между рекламами, В СЕКУНДАХ !!! 900 = 15мин
zad=10

### На этом ПК в тотеме 13 уровней громкости
voldo=14
volup=11

# Запускаем плеер !!!
totem $list/*.mp3 &

# Без задержки не работает =(
sleep 5

# Нормализуем громкость
n=1
while [ $n -lt $voldo ]
do
 totem --volume-down
 n=`expr $n + 1`
 echo $n
done

n=1
while [ $n -lt $volup ]
do
 totem --volume-up
 n=`expr $n + 1`
 echo $n
done

# PLAY
while true
do
 sleep $zad

 n=1
 while [ $n -lt $voldo ]
 do
  totem --volume-down
  sleep 0.1
  n=`expr $n + 1`
  echo $n
 done

 totem --play-pause

if [ `date +%H%M` -ge $time0 ]
then
 mess=$moff
 zad=5
fi

 mplayer -af volume=-5 "$mess/$(ls $mess | shuf -n1)"
 totem --play-pause

 n=1
 while [ $n -lt $volup ]
 do
  totem --volume-up
  sleep 0.1
  n=`expr $n + 1`
  echo $n
 done



done







