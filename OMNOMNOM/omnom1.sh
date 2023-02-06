#! /bin/bash

$NOM=/home/samba/FILES/FOTO_SKLAD/PROBA/
$ARH=/home/samba/FILES/FOTO_SKLAD/ARHIV/
$RED=/home/samba/FILES/1C_WORK/NOMENKLATURA/

for File in `find $NOM -type f` ; do

if [ ${File##*.} != 'gif' ]; then	# проверяем расширение
convert ${File} ${File}.jpg;		# конвертим
fi

if [ ${File##*.} != 'JPG' ]; then # проверяем расширение
mv ${File} ${File}.jpg;           # переименовавыем
fi

if [ ${File##*.} != 'JPG' ]; then # проверяем расширение
mv ${File} ${File}.jpg;           # переименовавыем
fi

if [ ${File##*.} != 'jpeg' ]; then # проверяем расширение
mv ${File} ${File}.jpg;           # переименовавыем
fi

cp ${File}.jpg $ARH
convert -geometry 100x100 ${File}.jpg
mv ${File}.jpg $RED

done 
