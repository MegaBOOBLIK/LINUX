@ECHO OFF
cls
set mydate=%date:~0,2%-%date:~3,2%-%date:~6,4%
set logfile=\\192.168.1.100\backup\POSBases\%mydate%_kassa%i%.log
set i=190

copy /y C:\Base\DB_Empty\MAIN.GDB \\192.168.1.100\backup\POSBases\MAIN%i%.GDB
echo %time:~0,-6% %i% OK>>%logfile%

