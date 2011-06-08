@ECHO OFF
CLS & COLOR 1F
TITLE Tools - Microsoft Security Essentials

REM change to same directory as script
CD /d %~dp0

REM Get shared vars, WINVER / WINBIT ...
CALL ..\scripts\vars.bat

::===========================================================================================================================

CLS & CALL ..\scripts\banner "Microsoft Security Essentials"

ECHO.
ECHO  * Installing...

IF [%WINBIT%]==[64] (
	mseinstall_x64.exe /s /runwgacheck /o
) ELSE (
	mseinstall_x86.exe /s /runwgacheck /o
)
ECHO  ! Complete.
ECHO.
ECHO  * Installing offline updates...

IF [%WINBIT%]==[32] mpam-fe.exe
IF [%WINBIT%]==[64] mpam-fex64.exe

ECHO  ! Complete.
ECHO    (Restart required to enable)
ECHO.
PAUSE & EXIT
