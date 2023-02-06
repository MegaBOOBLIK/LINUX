#!/bin/bash

# sudo mount -t smbfs -o username=vasja,password=pupkin //pupkin_v/Video /home/user/video

# Скрипт копирует файлы с камеры на диск, создавая папки 
# одноименные дате фотографии и помещая их туда.

SOURCE=/home/main/12345	# исходная папка (на камере)
TARGET=/home/main/12345	# папка для копирования

#find $SOURCE -iname "*.jpg" -or -iname "*.avi" -or -iname "*.mov" |
find $SOURCE -iname "*.jpg" |

while read FILE ; do DIR=$(ls -lt "$FILE" | awk '{print $6}') ;

((file_age=(`date +%s` - `date -r "$FILE" +%s`)/60));
echo $file_age;


test -d $TARGET/$DIR || mkdir $TARGET/$DIR ;
#cp -uv --preserve "$FILE" $TARGET/$DIR/ ;
mv -uv "$FILE" $TARGET/$DIR/ ;
done

