#!/bin/bash

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)

YELLOW="\033[1;33m"
RED="\033[0;31m"
ENDCOLOR="\033[0m"
 
if [ $USER != root ]; then
  echo -e $RED"Ошибка: вы должны быть root"
  echo -e $YELLOW"Выходим..."$ENDCOLOR
  exit 0
fi
 
echo -e $YELLOW"Очищаем кэш apt..."$ENDCOLOR
aptitude clean
 
echo -e $YELLOW"Удаляем старые конфиги..."$ENDCOLOR
sudo aptitude purge $OLDCONF
 
echo -e $YELLOW"Удаляем старые ядра..."$ENDCOLOR
sudo aptitude purge $OLDKERNELS
 
echo -e $YELLOW"Опусташаем все корзины..."$ENDCOLOR
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null
 
echo -e $YELLOW"Скрипт закончил работу!"$ENDCOLOR
