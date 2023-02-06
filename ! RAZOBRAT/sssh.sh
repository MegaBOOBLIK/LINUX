#!/bin/bash
# ЧТО ЗА ТАЧКА ЧУВАК...
clear
echo "ПИШИ КОНЕЦ iP"
while [ -z $adr ]
    do
    read adr
done
fadr=192.168.1.$adr
echo $fadr

ping -c 2 $fadr
echo "################################################################################"
arp -a $fadr
echo "################################################################################"
ssh $fadr
read -p "Press [Enter] to continue..."

