#! /bin/bash

NOM=/home/samba/FILES/FOTO_SKLAD/PROBA/		# откуда берём файл
ARH=/home/samba/FILES/FOTO_SKLAD/ARHIV/		# архив НЕОБРАБОТАННЫХ jpeg_ов 
RED=/home/samba/FILES/1C_WORK/NOMENKLATURA/	# папка для 1С_ки

for File in `find $NOM -type f` ; do

if [ ${File##*.} == "JPG" ] || [ ${File##*.} == "jpg" ] || [ ${File##*.} == "JPEG" ] || [ ${File##*.} == "jpeg" ]; then # проверяем расширение
cp $File $ARH`basename ${File%.*}`.jpg;		# копируем исходник в архив
convert $File -resize x100 $RED`basename ${File%.*}`.jpg;
rm $File;
fi

if [ ${File##*.} == "GIF" ] || [ ${File##*.} == "gif" ]; then # проверяем расширение
convert $File $ARH`basename ${File%.*}`.jpg;		# копируем исходник в архив
convert $File -resize x100 $RED`basename ${File%.*}`.jpg;
rm $File;
fi

if [ ${File##*.} == "PNG" ] || [ ${File##*.} == "png" ]; then # проверяем расширение
convert $File -background white -flatten $ARH`basename ${File%.*}`.jpg;		# копируем исходник в архив
convert $File -background white -flatten -resize x100 $RED`basename ${File%.*}`.jpg;
rm $File;
fi

done 
