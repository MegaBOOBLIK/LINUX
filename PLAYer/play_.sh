#!/bin/bash
# 19-02-2013

# Рабочие папки
mess=/home/media/MESSAGE
list=/home/media/PLAY_LIST

# Пауза между рекламами, В СЕКУНДАХ !!! 900 = 15мин
zad=600

### На этом ПК в тотеме 13 уровней громкости
voldo=15
volup=8

# Проверка в какком формате выводит день недели
#echo $list/`date +%a`m3u

# Запускаем плеер !!!
totem $list/`date +%a`m3u &

# Без задержки не работает =(
sleep 10

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
