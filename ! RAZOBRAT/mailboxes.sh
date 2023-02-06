#!/bin/bash

mail_dir=\/var\/vmail\/kodi.karelia.ru

dir=`ls /var/vmail/kodi.karelia.ru/`


echo "$dir" | while read i
do
echo $i	12345 >> ./mailboxes
done
