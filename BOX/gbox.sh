#!/bin/bash

#mapsync --noauthmd5 --syncinternaldates --nofoldersize --skipsize --nosyncacls \
#-host1 192.168.1.103 --user1 $1@kodi.karelia.ru --password1 $2 \
#-host2 192.168.1.3 --user2 $1@kodi.karelia.ru --password2 $2
    
logfile="gbox.log"

host1=192.168.1.103
#host1 is Source

host2=192.168.1.3
#host2 is Dest

domain=kodi.karelia.ru
#domain is where email account is
#everything after @ symbol

###### Do not modify past here
#######################################

date=`date +%X_-_%x`
echo "" >> $logfile
echo "------------------------------------" >> $logfile
echo "IMAPSync started..  $date" >> $logfile
echo "" >> $logfile

{ while IFS=';' read  u1 p1; do 
    user=$u1"@"$domain    
    echo "Syncing User $user"
    date=`date +%X_-_%x`
    echo "Start Syncing User $u1"
    echo "Starting $u1 $date" >> $logfile

imapsync --noauthmd5 --nosyncacls --syncinternaldates --nofoldersize --skipsize --exclude ".&BCMENAQwBDsEUQQ9BD0ESwQ1-" \
--host1 $host1 --user1 "$user" --password1 "$p1" \
--host2 $host2 --user2 "$user" --password2 "$p1"

    date=`date +%X_-_%x`
    echo "User $user done"
    echo "Finished $user $date" >> $logfile
    echo "" >> $logfile
    done ; } < userlist.txt
date=`date +%X_-_%x`
echo "" >> $logfile
echo "IMAPSync Finished..  $date" >> $logfil
echo "------------------------------------" >> $logfile
