#!/bin/bash
#25-07-2013
# пишы с Ы...
ADR=ya.ru

P=1
i=1

while [ "$P" != "0" ]
 do  
  printf $i" " \r;
  i=$(($i+1));
  ping $ADR -c1 > /dev/null;
  P=$?;
done

totem beep.mp3



