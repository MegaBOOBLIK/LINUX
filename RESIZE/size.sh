#!/bin/bash

# ЭТОТ ПАРАМЕТР 1024 МОЖНО ИЗМЕНЯТЬ! НО ТОЛЬКО ЭГО!!!
siz=1024


dirr=SIZE_$siz

mkdir $dirr
for f in *.JPG; do
convert $f -resize $siz $dirr/${f%%JPG}jpg
echo "$f - OK"
done

