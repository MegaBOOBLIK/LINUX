#!/bin/bash

P=5

while [ "$P" != "0" ]
 do 
  ping www.ya.ru -c1 > /dev/null
  P=$?
  echo $P
done

echo GO-GO-GO!
totem beep.mp3



