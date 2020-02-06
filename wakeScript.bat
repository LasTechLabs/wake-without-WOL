@echo off

REM Checks remote file for "FLAG" which indicates whether it should sleep immediately or stay on.
FOR /f "tokens=*" %%a in ('curl -s FLAG.URL') do set FLAG=%%a

REM Checks power config to see whether the wakeuptimersON profile is active.
FOR /f "tokens=4" %%a in ('powercfg /getactivescheme') do set PMODE=%%a 

REM Sets power profile to wakeuptimersON if not already the case.

REM IF "%PMODE%" NEQ "POWERPLANGUID" (
REM 	powercfg /setactive POWERPLANGUID
REM )

REM If the flag indicates that it hasn't been asked to stay on, computer sleeps itself after checks.
IF "%flag%"=="0" (
	PsShutdown -d -t 0
)
