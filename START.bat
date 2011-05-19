@ECHO OFF
CLS & COLOR 1F

TITLE Tools

REM change to same directory as script
CD /d %~dp0

CALL scripts\splash " ELEVATING.. "

REM Get shared vars, WINVER / WINBIT ...
CALL scripts\vars

REM Elevate to the main script
IF [%WINVER%]==[XP] (
	CALL scripts\TOOLS.bat
) ELSE (
	%HSTART% /SHELL /UAC scripts\TOOLS.bat
)
EXIT