#!/bin/bash
#log=/var/log/temp_clean.log

# ГДЕ?
dir=/home/samba/FILES/TEMP

# КОГДА?
days=7

find $dir/* -ctime +$days -exec ls -gh --time-style=+%x" "%X {} \;

find $dir/* -ctime +$days -exec rm -fr {} \;
