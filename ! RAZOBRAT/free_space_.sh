#SHELL=/bin/bash
#PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

df -a -h -t ext3 | sendEmail -t it@kodi.karelia.ru -u "FREE SPACE `date +%F\ %T`"

