#!/bin/bash

###---------ПЕРЕМЕННЫЕ---------###

MY_PATH=/home/main/SMS
sms_text=$MY_PATH/config/text
MAXLEN=68 #Максимальная длинна СМС
base=clients #База, где лежат клиенты
table=info #Таблица с клиентами
MyUSER="sms" # USERNAME
MyPASS="12345" # PASSWORD
MyHOST="192.168.1.100" # Hostname
number=0
# Linux bin paths
MYSQL="$(which mysql)"
SQL_CON="$MYSQL -u $MyUSER -h $MyHOST -p$MyPASS"
sms_num=`cat $MY_PATH/config/sms.conf`
title=`cat $MY_PATH/config/title.conf`
text=`cat $sms_text`

###---------ФУНКЦИИ------------###

MY_rm_file () {
if [ -e $MY_PATH/$1 ]; then rm $MY_PATH/$1; fi
}

MY_menu () {
	clear
	echo "*** * * * * *    Здрасте, спамим потихоньку?    * * * * * ***"
	echo "Что будем делать?"
	echo "	1. Новая рассылка."
#	echo "	4. Посмотреть текст."
#	echo "	5. Исправить настройки рассылки."
	echo "	9. Продолжить рассылку со старыми настройками."
	echo ""
	read -p "Выбираем: " ch_menu
};


#В качестве параметра идёт выбор из меню
MY_text () {
	#Если просто посмотреть:
	if [ "$1" -eq "1" ]
		then
			text=`cat $sms_text`
			echo $text;
	fi

	#Если решили править:
	if [ "$1" -eq "2" ]
		then
		test_while=0
		while [ "$test_while" = "0" ]
		do
			echo "Введите текст СМС: "
			read new_text_sms
			len=${#new_text_sms}
			echo "Ваш текст: "$new_text_sms
			echo "Длинна сообщения = "$len" символов"
		#Проверка длинны сообщения
		if [ "$len" -gt "$MAXLEN" ]
			then
				echo "Длинна сообщения превышает максимальную"
				error=max_len_text
			else
				echo $new_text_sms > $MY_PATH/config/text
				echo "Продолжаем? (Y|N)"
				read answer
				case "$answer" in
					"Y" | "y" | "Д" | "д" )
					test_while=1
					;;
				esac
		fi
		done
	fi
};

MY_test () {
if [ "$1" -eq "1" ]
	then

#Сбор остаточной инфы
	test_send=0 #Пока равно нулю СМС не отправяться, после подтверждения будет равно 1
	text=`cat $sms_text`
	echo "В честь чего спам?";
	read title
	echo "Введите кол-во СМС:"
	read sms_num
fi
if [ "$1" -eq "2" ]
	then
text=`cat $sms_text`

#Вывод всей информации
	echo ""
	echo "##################################"
	echo "***    ###Подобьё бабки:###    ***"
	echo "На счету:           "$s4et;
	echo "В честь чего спам?  "$title;
	echo "Текст сообщения:  \""$text"\"";
	echo "Количество СМС:     "$sms_num;
	echo ""

#Запрашиваем подтверждение
	echo "Всё ли верно?"
	test_while=0
			echo $title > $MY_PATH/config/title.conf
			echo $sms_num > $MY_PATH/config/sms.conf
	while [ "$test_while" -ne "1" ]
	do
		read -p "(Y/N)" answer
		case "$answer" in
			"Y" | "y" | "Д" | "д" )
			echo "Начинаем отправку СМСок"
			test_while=1
			test_send=1
			end=0
			;;

			"N" | "n" | "Н" | "н" )
			echo "Исправляем всё сначала!!!"
			exit
#			test_while=1
#			end=1
			;;
		esac
	done
fi
}

MY_send () {
cd $MY_PATH

echo "SELECT count( * ) FROM $base.$table WHERE send LIKE 0 " > $MY_PATH/sql
	least_to_send=`$SQL_CON -N < $MY_PATH/sql`
	least=$(($least_to_send/2))
MY_rm_file sql

echo "select id,sot_tel,last_time from $base.$table where send = '0' LIMIT $least,$sms_num" > $MY_PATH/sql
$SQL_CON -N < $MY_PATH/sql | while read i
do
echo ""
id1=`echo $i | cut -d" " -f1`
tel=`echo $i | cut -d" " -f2`
last_time=`echo $i | cut -d" " -f3,4,5`
date=`date +%y.%m.%d`
new_last_time="$date $title" 
echo "Выполнено "$((100-((($sms_num-$number)*100)/$sms_num)))"%,"\
        "осталось "$(($sms_num-$number))" смс,"\
        "примерно "$(((($sms_num-$number)*10)/60))" мин."
MY_rm_file sql
echo $text | gammu --sendsms TEXT +7$tel -unicode > /dev/null
number=$(($number+1))
                        echo "UPDATE $base.$table SET pre_last_time = '$last_time', last_time = '$new_last_time', send = '2' WHERE id = '$id1'" > $MY_PATH/sql
                        $SQL_CON -N < $MY_PATH/sql
                MY_rm_file sql

done

MY_rm_file sel_sql
MY_rm_file temp_name
MY_rm_file temp_l_name

#s4et=`source $MY_PATH/s4et.sh`

###---ОТПРАВКА ОТЧЁТА НА МЫЛО---###

echo "--- "`date`" ---" >> $MY_PATH/body
echo "На карте осталось $s4et рублей" >> $MY_PATH/body
cat $MY_PATH/body | sendmymail "День строителя"

MY_rm_file body

};

MY_down_table () {
echo ""
echo "Для начала новой рассылки все контакты в базе данных будут"
echo "помечены как не получившие СМС. ПРОДОЛЖИТЬ?"
echo "ДЛЯ ПРЕРЫВАНИЯ НАЖМИ CTRL+C (не успел доделать)"
        test_while=0
        while [ "$test_while" -ne "1" ]
        do
                read -p "(Y/N)" answer
                case "$answer" in
                        "Y" | "y" | "Д" | "д" )
                        echo "Ну поехали"
                        test_while=1
                        test_send=1
                        ;;

                        "N" | "n" | "Н" | "н" )
                        echo "Исправляем всё сначала!!!"
			exit
                        ;;
                esac
        done

echo "UPDATE $base.$table SET send = '0'" > $MY_PATH/sql
	$SQL_CON -N < $MY_PATH/sql
                MY_rm_file sql
};

MY_beep () {
beep=0;
while [[ "$beep" = "0" || "$beep" = "" ]]
do
	MY_send
	beep=0
	count_n=0
		echo "SELECT count( * ) FROM $base.$table WHERE send LIKE 2 " > $MY_PATH/sql
			HAVE_SEND=`$SQL_CON -N < $MY_PATH/sql`
		MY_rm_file sql
                echo "SELECT count( * ) FROM $base.$table WHERE send LIKE 0 " > $MY_PATH/sql
                        LAST_SEND=`$SQL_CON -N < $MY_PATH/sql`
                MY_rm_file sql


	echo "######################################################"
	echo ""
	echo "Отправлено "$HAVE_SEND" СМС"
	echo "Осталось"$LAST_SEND" СМС"
	echo "Для завершения работы нажмите 1";
	echo "Для продолжения рассылки смените СИМку и нажмите ENTER";
	while [[ "$beep" -ne "1"  &&  "$beep" != "" && "$count_n" != "30" ]];
	do
#		500  4000
	beep -l 500 -f 4000;
	read -t 1 beep
	count_n=$(($count_n+1))
	done;
done
};


###---------САМ СКРИПТ---------###
ch_menu=0
while [[ "$ch_menu" -ne "1" && "$ch_menu" -ne "5" && "$ch_menu" -ne "9" ]]
do
MY_menu
#s4et=`source $MY_PATH/s4et.sh`
done

	case "$ch_menu" in
		"1" )
		MY_text 2
		MY_test 1
		MY_test 2
		MY_down_table
		MY_beep
		;;
		"9" )
		test_while=0
		while [[ "$test_while" = "0" ]]
		do
		MY_test 2
		if [[ "$end" = "1" ]]
		then MY_test 1
		test_while=0
		MY_text 2
		test_while=0
		fi
		done
		MY_beep
		;;
	esac

#MY_beep
#MY_text
#MY_send
#MY_down_table
#echo "Таблица скинута на 0"
#echo $menu
