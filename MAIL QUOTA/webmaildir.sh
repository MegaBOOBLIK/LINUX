#!/bin/bash

mail_dir=\/var\/vmail\/kodi.karelia.ru
qwf="/tmp/mail_dir.$$"
tmp_file=/tmp/mail_dir_tmp.$$
ftp_url=192.168.1.100
user=back
pass=save
quota1=190
quota2=180

echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
 <title>KODI</title>
 <meta name="copyright" Content="Powered by DmitryG">
 <meta name="keywords" content="">
 <meta name="description" content="">
 <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">

 <link rel="shortcut icon" href="plain/favicon1.ico" />

 <link href="plain/styles.css" rel="stylesheet" type="text/css">
 <!--[if IE 6]>
  <script type="text/javascript" src="/plain/fixpng.js"></script>
 <![endif]-->
</head>

<body>
<div class="page">

<div class="mainMenu">
<div class="rightSide">

<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td class="item"><a href="mail_dir.html">ОБЪЁМ ПОЧТЫ<div></div></a></td>
  <td class="item"><a href="//192.168.1.103/webmail/">WEB KODI MAIL<div></div></a></td>
  <td class="item"><a href="clients">SMS<div></div></a></td>
       
  <td class="item"><a href="//192.168.1.104:4433/"><H2></H2><div></div></a></td>
  <td class="item"><a href=""><H2></H2><div></div></a></td>
  <td class="item"><a href=""><H2></H2><div></div></a></td>
  <td class="item"><a href=""><H2></H2><div></div></a></td>
  <td class="item"><a href=""><H2></H2><div></div></a></td>
		 
		 
  <td class="item"><a href="other.php">BFBC2<H2></H2><div></div></a></td>
  <td class="right"><div></div></td>
 </tr>
</table>

</div></div>

<table width=908 cellpadding="0" cellspacing="0" border="0">
 <tr>
  <td width="193" valign="top" rowspan="2">
   <div class="logo">
    <a href="index.php"><img src="img/logo.jpg" width="193" height="194" alt=""></a>
   </div>
  </td>
  <td width="16" rowspan="2">
   <img src="img/t.gif" width="16" height="1" alt="" class="h">
  </td>
  <td width="699" class="content">
  <BR><BR>
  <CENTER><H2>СОСТОЯНИЕ ПОЧТОВЫХ ЯЩИКОВ</H2></CENTER>
  <BR>
  <font color=red>Красный - ваша почта не работает</font><br> 
  <font color=gold>Жёлтый - ваша почта скоро не будет работать</font>
  <BR><BR>
  ' >> $qwf 

dir=`du -m --max-depth=1 --time $mail_dir | sort -rn | sed -e "s/\/var\/vmail\/kodi.karelia.ru\///g"`

rm -f $tmp_file

echo "<table width=100% border=1 align=center>"  >> $qwf

echo "<tr>
       <td align=”center” width=10%><CENTER><B>Объём (Мб)</td>
       <td align=”center” width=40%><CENTER><B>* @kodi.karelia.ru</td>
       <td align=”center” width=30%><CENTER><B>Дата</td>
       <td align=”center” width=20%><CENTER><B>Время</B></CENTER></td>
      </tr>" >> $qwf

echo "$dir" | while read i
do
size=`echo $i | cut -d " " -f1`
name=`echo $i | cut -d " " -f4`
if [ "$size" -ge "$quota2" ] && [ "$name" != "/var/vmail/kodi.karelia.ru" ]
then
	bg="bgcolor=gold"

	if [ "$size" -ge "$quota1" ]
	then
		bg="bgcolor=red"
	fi
fi
line="<tr $bg><td>"$size"</td><td>"$name"</td><td>"`echo $i | cut -d " " -f2`"</td><td>"`echo $i | cut -d " " -f3`"</td></tr>"
echo $line >> $qwf
bg=""
done

echo "</table>" >> $qwf

#echo ftp
ftp -n $ftp_url <<EOF

quote user $user
quote pass $pass
binary
send $qwf /mail/mail_dir
quit

EOF

#echo ftp2

rm -f $qwf

#du -m --max-depth=1 --time $mail_dir | sort -rn | sed -e "s///g"
#du -m --max-depth=1 $mail_dir | sort -rn
