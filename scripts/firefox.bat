@ECHO OFF

REM change to same directory as script
CD /d %~dp0

REM Get shared vars, WINVER / WINBIT ...
CALL vars.bat

REM Set the program path based on the bit version.
IF [%WINBIT%]==[64] (
	SET "P=%PROGRAMFILES(x86)%\Mozilla Firefox"
) ELSE (
	SET "P=%PROGRAMFILES%\Mozilla Firefox"
)

REM Kill firefox to ensure the START commands will instal the extensions.
IF [%WINVER%]==[XP] (
	TSKILL Firefox
) ELSE (
	TASKKILL /F /IM Firefox.exe
)

:refresh
CLS & COLOR 1F
TITLE Firefox 
REM Show the user interface
CLS & CALL banner "Installing Firefox Extensions for All Users..."
REM Copy the XPI files to the extensions folder.

ECHO.
ECHO   Installing Addons...
ECHO.
ECHO * AdBlock Plus
COPY /Y "..\internet\AdBlockPlus.xpi" "%P%\extensions\{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}.xpi" > NUL
IF ERRORLEVEL 1 (
	ECHO ! Failed
) ELSE (
	ECHO ! Success
)
ECHO.
ECHO * Web Of Trust
COPY /Y "..\internet\WebOfTrust.xpi" "%P%\extensions\{a0d7ccb3-214d-498b-b4aa-0e8fda9a7bf7}.xpi" > NUL
IF ERRORLEVEL 1 (
	ECHO ! Failed
) ELSE (
	ECHO ! Success
)
ECHO.
ECHO * English-British Dictionary
MKDIR "%P%\extensions\en-GB@dictionaries.addons.mozilla.org"
COPY /Y "..\internet\en-GB@dictionaries.addons.mozilla.org\*.*" "%P%\extensions\en-GB@dictionaries.addons.mozilla.org\" > NUL
IF ERRORLEVEL 1 (
	ECHO ! Failed
) ELSE (
	ECHO ! Success
)
ECHO.

:exit
ECHO.
ECHO   All extensions have been installed.
ECHO.
PAUSE & GOTO:EOF