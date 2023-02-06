@ECHO OFF
cls
set mydate=%date:~0,2%-%date:~3,2%-%date:~6,4%
set logfile=%mydate%_kassa.log
set i=195

:START
if %i% == 198 (
	echo - >>%logfile%
) else (
	ping 192.168.1.%i% -n 1 -w 20 >NUL
	if ERRORLEVEL 1 goto IPERROR
	goto IPOK
:IPERROR
	echo %time:~0,-6% %i% OFF>>%logfile%
	set /a i=1 + %i%
	goto START
:IPOK
	copy /y \\192.168.1.%i%\base\DB_Empty\MAIN.GDB C:\POSBases\MAIN%i%.GDB
	echo %time:~0,-6% %i% OK>>%logfile%
	set /a i=1 + %i%
	goto START
)
