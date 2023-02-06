#!/bin/bash

echo ! &

SOURCE=/media/WORK/111/222/333

TARGET=/home/main/!FOTO!

find $SOURCE -iname "*.jpg" | 
while read FILE ; do DIR=$(ls -lt "$FILE" | awk '{print $6}') ;
((file_age=(`date +%s` - `date -r "$FILE" +%s`)/60));
test -d $TARGET/$DIR || mkdir $TARGET/$DIR ;
cp -uv --preserve "$FILE" $TARGET/$DIR/ ;
#mv -uv "$FILE" $TARGET/$DIR/ ;
done
