#!/bin/bash

#uzer=gds@kodi.karelia.ru
#paz=12345

#imapsync -host1 192.168.1.103 -user1 $uzer -pass 12345 -host2 192.168.1.3 -user2 $uzer -pass 12345

imapsync --noauthmd5 --syncinternaldates --nofoldersize --skipsize --nosyncacls \
--host1 192.168.1.103 --user1 $1@kodi.karelia.ru --password1 $2 \
--host2 192.168.1.3 --user2 $1@kodi.karelia.ru --password2 $2


