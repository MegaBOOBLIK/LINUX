#!/bin/bash
#PHONE="89212230911 89212205626"

PORT="/dev/ttyUSB0"
fil="./elec_m2019.txt"
log="./elec_m2019.log"
RAZ=7

inout(){
    cat $PORT | sed -e s/^.ET0PE\(//g |sed -e /^$/d | sed -e s/^ET0PE\(//g | sed -e s/\)//g > $fil &
#    cat $PORT > $fil &

    sleep 3

    # посылаем запрос в порт
    #/?!.R1.ET0PE().7
    echo -en '\x2f\x3f\x21\x01\x52\x31\x02\x45\x54\x30\x50\x45\x28\x29\x03\x37' > $PORT

    sleep 7;
    echo $(< $fil);

#    for ((i=1; i<=$RAZ; i++)); do sleep 3; echo -en "$i "; echo $(< $fil); done
    killall cat
}

echo "$(date +%y-%m-%d\ %H:%M)" >> $log
cat /dev/null > $fil

# инициализация порта
stty -F $PORT 500:5:da7:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
sleep 3

# пока не получим 0.0 n раз делаем inout
while [[ $(grep -c "0.0" $fil) -lt 3 ]]; do inout; done

declare -a ARRAY
ARRAY=(`cat "$fil"`)
echo ${ARRAY[@]} >> $log

# Перезагрузка счетчика (сброс) /?!0xB0
echo -en '\x2f\x3f\x21\x01\x42\x30\x03\x75' > $PORT

#curl -s "http://localhost:8080/json.htm?type=command&param=udevice&idx=45&nvalue=0&svalue=${ARRAY[0]}"
#curl -s "http://localhost:8080/json.htm?type=command&param=udevice&idx=46&nvalue=0&svalue=${ARRAY[1]}"
#curl -s "http://localhost:8080/json.htm?type=command&param=udevice&idx=47&nvalue=0&svalue=${ARRAY[2]}"

#for p in $PHONE
#    do
#    echo -en "$(date +%y-%m-%d\ %H:%M)\r\nTOT `echo "scale=2; ${ARRAY[0]}/1"|bc`\r\nDAY `echo "scale=2; ${ARRAY[1]}/1"|bc`\r\nNIG `echo "scale=2; ${ARRAY[2]}/1"|bc`"| gammu sendsms TEXT $p
#    done

echo -en "$(date +%y-%m-%d\ %H:%M)\r\nTOT `echo "scale=2; ${ARRAY[0]}/1"|bc`\r\nDAY `echo "scale=2; ${ARRAY[1]}/1"|bc`\r\nNIG `echo "scale=2; ${ARRAY[2]}/1"|bc`"| mail -s "Power" megabooblik@gmail.com

exit 0
