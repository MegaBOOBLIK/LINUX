#!/bin/sh
# В именах файлов ищем _ меняем на -


for i in *.JPG
do
        k=`echo ${i}|sed s/'_'/'-'/g`
        mv "${i}" ${k}
done

for i in *.jpg
do
        k=`echo ${i}|sed s/'_'/''/g`
        mv "${i}" ${k}
done

for i in *.jpeg
do
        k=`echo ${i}|sed s/'_'/''/g`
        mv "${i}" ${k}
done
