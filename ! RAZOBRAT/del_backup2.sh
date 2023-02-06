#!/bin/bash
size=10				#Размер удаляемых файлов
maxdays=3			#Количество хранимых папок
home=/media/backup/backup	#Где...

echo ""
echo `date +%c` "### запущен скрипт удаления старых бекапов ###"

#for i in `cat $home/backup/dir.ini`
for i in `ls -p1 $home | grep / | sed -e "s/\///g"`
do

dir=$home/$i
cd $dir

	echo "Чистим каталог" $dir 
	echo ""

	for i in `find ./* -type f ! -name '*'.sh '*'.txt`
	do 
	    if [ "`stat -c %s $i`" -le "$size" ]
		then 
			echo "Удаляем файл"$i", так как он имеет размер:" `stat -c %s $i`
			rm $i
	    fi
	done

#Теперь удалим все пустые папки, если они есть
find ./* -type d -maxdepth 2 -exec rmdir -p {\} \; -exec echo "Удаляем папку ".{\} \; 

#Построение дерева директории
path=`ls --ignore=*.sh  --ignore=*.ini --ignore=*.txt  | wc -l`

#Удаление ненужных бекапов
echo "Всего директорий "$path "- Должно остаться "$maxdays

#Удаление лишних папок
while [ $path -gt $maxdays ] 
do 
    olddir=`ls -t --ignore=*.sh  --ignore=*.ini --ignore=*.txt | tail -1`
    rm -r $olddir
    path=`ls --ignore=*.sh  --ignore=*.txt --ignore=*.ini | wc -l`
    echo "Удаляем папку" $olddir
done
echo ""
echo "В катологе осталось:"
	for i in `ls --ignore=*.txt --ignore=*.sh -t -1`
	do
        	echo $i = `du ./$i/ -m -c | grep $i | awk '{print $1}'` Mb
	done

done

echo "всё сделано в" `date +%c`
echo "`df -h /dev/sdb5`"
exit 0
