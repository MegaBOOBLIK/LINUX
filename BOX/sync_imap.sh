#!/bin/bash

cat ./mailboxes | while read i 
do

echo "#############"
echo $i
echo

user=`echo $i | cut -d" " -f1`
passwd=`echo $i | cut -d" " -f2`
host1=192.168.1.103	#откуда копировать
host2=192.168.1.240	#куда копировать

echo $user
echo $passwd

imapsync --noauthmd5 --syncinternaldates --exclude ".&BCMENAQwBDsEUQQ9BD0ESwQ1-" \
--host1 $host1 --user1 $user@kodi.karelia.ru --password1 $passwd \
--host2 $host2 --user2 $user@kodi.karelia.ru --password2 $passwd

done
