@ECHO OFF
CLS
set i=190
set mydate=%date:~0,2%-%date:~3,2%-%date:~6,4%
set logfile=\\192.168.1.100\backup\POSBases\%mydate%_kassa10.log

copy /y C:\Base\DB_Empty\MAIN.GDB \\192.168.1.100\backup\POSBases\MAIN%i%.GDB
echo %time:~0,-6% OK>>%logfile%

