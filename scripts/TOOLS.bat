::===========================================================================================================================
::Tools script 

@ECHO OFF
CLS & COLOR 1F
TITLE Tools

REM change to root
CD /d %~dp0
CD ..

CALL scripts\splash " STARTING... "

REM Get shared vars, WINVER / WINBIT ...
CALL scripts\vars

::===========================================================================================================================
:menu
CLS & COLOR 1F
TITLE %~d0 Tools [Windows %WINVER%: %WINBIT%-bit]

REM which service packs are offered vary on version of Windows installed
SET "_SP_SLOT_1___________=                       "
SET "_SP_SLOT_2___________=                       "

IF [%WINVER%]==[7] (
	SET "_SP_SLOT_1___________=[SP1] Win7 SP1         "
	SET "_SP_SLOT_2___________=                       "
) ELSE IF [%WINVER%]==[VISTA] (
	SET "_SP_SLOT_1___________=[SP2] Vista SP2        "
	SET "_SP_SLOT_2___________=[SP1] Vista SP1        "
) ELSE IF [%WINVER%]==[XP] (
	SET "_SP_SLOT_1___________=[SP3] XP SP3           "
	SET "_SP_SLOT_2___________=[SP2] XP SP2           "
)

ECHO ^
�����������������������������������������������������������������������������Ŀ ^
� TOOLS                              � [US] Shutdown [UR] Restart � [Q] Quit  � ^
�����������������������������������������������������������������������������Ĵ ^
�                         �                         �                         � ^
� [MS] MSSE               � [FF] Firefox  [FX] XPIs � [FI] Foxit Reader       � ^
� [MU] MSSE Updates       � [GC] Google Chrome      �                         � ^
� [R]  Remove Antivirus.. � [IE] IE8 / IE9          � [RA] RealAlternative    � ^
�                         �                         � [QT] QTLite             � ^
� [H]  HiJackThis         � [10] Flash Player       � [IT] iTunes   [V] VLC   � ^
� [CF] ComboFix           � [SA] Site Advisor       �                         � ^
� [RK] RKill  [GM] GMER   �                         � [LO] LibreOffice 3.3    � ^
� [SD] Spybot [SI] Update � [CC] CCleaner [C] -run  � [TB] Thunderbird        � ^
�                         �                         �                         � ^
� %_SP_SLOT_1___________% � [IP] Reset TCP/IP       � [CU] MSI CleanUp Util.  � ^
� %_SP_SLOT_2___________% � [WN] WirelessNetView    � [AF] AutoPlay Fix       � ^
�                         �                         �                         � ^
� [AP] AutoPatcher        �������������������������Ĵ [TS] TreeSize [W] RAR   � ^
� [WU] Fix XP WinUpdate   �                         � [UK] Crucial  [Z] CPU-Z � ^
�      (Repair Install)   � [P]  Passwords...       � [SP] Speccy             � ^
�                         �                         �                         � ^
�����������������������������������������������������������������������������Ĵ ^
� [U] Download Updates...            �    [M] msconfig [A] appwiz [I] inetcpl � ^
�������������������������������������������������������������������������������


SET "M=NUL"
SET /P M=: 
If /I [%M%]==[NUL] GOTO :menu
IF /I [%M%]==[q] GOTO :final

:: Update TOOLS
IF /I [%M%]==[u] (
	CD scripts
	CALL Update.bat
	CD ..
	GOTO :menu
)

:: Anti Virus
::---------------------------------------------------------------------------------------------------------------------------
REM *** Remove ... ***
IF /I [%M%]==[r]  GOTO :remove
IF /I [%M%]==[ms] CALL :launch "anti_virus\msse.bat"				& GOTO :menu	REM * MSSE

REM * MSSE Updates
IF /I [%M%]==[mu] (
	IF [%WINVER%]==[XP] (
		anti_virus\mpam-fe.exe
	) ELSE (
		IF [%WINBIT%]==[64] anti_virus\mpam-fex64.exe
		IF [%WINBIT%]==[32] anti_virus\mpam-fe.exe
	)
	GOTO :menu
)


:: Anti Spyware
::---------------------------------------------------------------------------------------------------------------------------
IF /I [%M%]==[h]  CALL :launch "anti_spyware\Removers\HiJackThis.exe"		& GOTO :menu	REM * HiJackThis
IF /I [%M%]==[cf] CALL :temp   "anti_spyware\Removers\ComboFix.exe"		& GOTO :final	REM * ComboFix
IF /I [%M%]==[rk] CALL :temp   "anti_spyware\Removers\rkill.exe"		& GOTO :menu	REM * RKill
IF /I [%M%]==[gm] CALL :temp   "anti_spyware\Removers\gmer.exe"			& GOTO :menu	REM * GMER
IF /I [%M%]==[sd] CALL :launch "anti_spyware\spybotsd.exe"			& GOTO :menu	REM * SpybotSD
IF /I [%M%]==[si] CALL :launch "anti_spyware\spybotsd_includes.exe"		& GOTO :menu	REM * SpybotSD Inlcudes


:: Updates
::---------------------------------------------------------------------------------------------------------------------------
IF /I [%M%]==[sp1] (
IF [%WINVER%]==[7] IF [%WINBIT%]==[64] CALL :launch "updates\7\7-SP1-x64.exe"	& GOTO :menu	REM * Win7 SP1 x64
IF [%WINVER%]==[7] IF [%WINBIT%]==[32] CALL :launch "updates\7\7-SP1-x86.exe"	& GOTO :menu	REM * Win7 SP1 x86
IF [%WINVER%]==[VISTA] CALL :launch "updates\Vista\Vista-SP1.exe"		& GOTO :menu	REM * Vista SP1
)

IF /I [%M%]==[sp2] (
IF [%WINVER%]==[VISTA] CALL :launch "updates\Vista\Vista-SP2.exe"		& GOTO :menu	REM * Vista SP2
IF [%WINVER%]==[XP]    CALL :launch "updates\XP\XP-SP2.exe"			& GOTO :menu	REM * XP SP2
)

IF /I [%M%]==[sp3]     CALL :launch "updates\XP\XP-SP3.exe"			& GOTO :menu	REM * XP SP3

IF /I [%M%]==[ap] CALL :launch "updates\autopatcher\autopatcher.exe"		& GOTO :menu	REM * AutoPatcher

REM *** Fix WinUpdate ***
IF /I [%M%]==[wu] (
	CLS
	CALL scripts\banner "Re-registering Windows Update DLLs..."
	ECHO wuapi.dll		& regsvr32 /s wuapi.dll
	ECHO wuaueng.dll	& regsvr32 /s wuaueng.dll
	ECHO wuaueng1.dll	& regsvr32 /s wuaueng1.dll
	ECHO wucltui.dll	& regsvr32 /s wucltui.dll
	ECHO wups.dll		& regsvr32 /s wups.dll
	ECHO wups2.dll		& regsvr32 /s wups2.dll
	ECHO wuweb.dll		& regsvr32 /s wuweb.dll
	ECHO msxml3.dll		& regsvr32 /s msxml3.dll
	ECHO.
	PAUSE
	GOTO :menu
)


:: Internet
::---------------------------------------------------------------------------------------------------------------------------

IF /I [%M%]==[ff] CALL :firefox							& GOTO :menu	REM * Firefox
IF /I [%M%]==[fx] CALL :ffxex							& GOTO :menu	REM * Firefox AddOns

IF /I [%M%]==[gc] CALL :launch "internet\Google_Updater.exe"			& GOTO :menu	REM * Google Chrome

REM *** Internet Explorer 8 or 9 ***
IF /I [%M%]==[ie] (
	IF [%WINVER%]==[XP]			CALL :launch "internet\IE8-WindowsXP-x86-ENU.exe"
	IF [%WINVER%]==[VISTA]			CALL :launch "internet\IE9-WindowsVista-x86-enu.exe"
	IF [%WINVER%]==[7] IF [%WINBIT%]==[64]	CALL :launch "internet\IE9-Windows7-x64-enu.exe"
	IF [%WINVER%]==[7] IF [%WINBIT%]==[32]  CALL :launch "internet\IE9-Windows7-x86-enu.exe"
	GOTO :menu
)
REM *** Flash Player 10 ***
IF /I [%M%]==[10] CALL :flash							& GOTO :menu	REM * Flash Player

REM *** Reset TCP/IP ***
IF /I [%M%]==[ip] (
	CLS
	CALL scripts\banner "Resetting TCP/IP stack..."
	
	netsh winsock reset ip
	
	PAUSE
	GOTO :menu
)


:: Utilities
::---------------------------------------------------------------------------------------------------------------------------
IF /I [%M%]==[p]  GOTO :passwords

IF /I [%M%]==[cc] CALL :launch "utils\clean\ccleaner.exe"			& GOTO :menu	REM * CClenaer (Install)
IF /I [%M%]==[c] IF [%WINBIT%]==[64] CALL :launch "utils\clean\ccleaner\CCleaner.exe" & GOTO :menu	REM * Speccy (64-Bit)
IF /I [%M%]==[c] IF [%WINBIT%]==[32] CALL :launch "utils\clean\ccleaner\CCleaner64.exe" & GOTO :menu	REM * Speccy (32-Bit)
IF /I [%M%]==[cu] CALL :launch "utils\clean\msicuu2\msicuu.exe"			& GOTO :menu	REM * MSI CleanUp Utility
IF /I [%M%]==[af] CALL :launch "utils\AutoFix.exe"				& GOTO :menu	REM * AutoPlay Fix

IF /I [%M%]==[wn] CALL :launch "utils\info\wnview\WirelessNetView.exe"		& GOTO :menu	REM * WirelessKeyView

IF /I [%M%]==[fi] CALL :launch "end_user\FoxitReader_enu.msi"			& GOTO :menu	REM * Foxit Reader
IF /I [%M%]==[ra] CALL :launch "end_user\realaltlite.exe"			& GOTO :menu	REM * RealAlternative
IF /I [%M%]==[qt] CALL :launch "end_user\qtlite.exe"				& GOTO :menu	REM * QuickTime Lites
IF /I [%M%]==[v]  CALL :launch "end_user\vlc-win32.exe"				& GOTO :menu	REM * VLC

IF /I [%M%]==[tb] CALL :launch "end_user\Thunderbird Setup 3.0.4.exe"		& GOTO :menu	REM * Thunderbird

IF /I [%M%]==[lo] CALL :launch "end_user\LibreOffice 3.3\setup.exe"		& GOTO :menu	REM * LibreOffice

IF /I [%M%]==[ts] CALL :launch "utils\clean\TreeSizeFree.exe"			& GOTO :menu	REM * TreeSize
IF /I [%M%]==[w]  IF [%WINBIT%]==[64] CALL :launch "utils\winrar-x64-393.exe"	& GOTO :menu	REM * WinRAR (64-Bit)
IF /I [%M%]==[w]  IF [%WINBIT%]==[32] CALL :launch "utils\wrar393.exe"		& GOTO :menu	REM * WinRAR (32-Bit)
IF /I [%M%]==[z]  CALL :launch "utils\info\cpuz.exe"				& GOTO :menu	REM * CPU-Z

IF /I [%M%]==[uk] CALL :temp "utils\info\CrucialUKScan.exe"			& GOTO :menu	REM * CrucialScan

IF /I [%M%]==[sp] IF [%WINBIT%]==[64] CALL :launch "utils\clean\speccy\Speccy64.exe" & GOTO :menu	REM * Speccy (64-Bit)
IF /I [%M%]==[sp] IF [%WINBIT%]==[32] CALL :launch "utils\clean\speccy\Speccy.exe" & GOTO :menu	REM * Speccy (32-Bit)

IF /I [%M%]==[it] IF [%WINBIT%]==[64] CALL :launch "end_user\iTunes64Setup.exe"	& GOTO :menu	REM * iTunes (64-Bit)
IF /I [%M%]==[it] IF [%WINBIT%]==[32] CALL :launch "end_user\iTunesSetup.exe"	& GOTO :menu	REM * iTunes (32-Bit)

IF /I [%M%]==[m] START msconfig							& GOTO :menu	REM * msconfig
IF /I [%M%]==[a] START appwiz.cpl						& GOTO :menu	REM * appwiz.cpl
IF /I [%M%]==[i] START inetcpl.cpl						& GOTO :menu	REM * inetcpl.cpl

IF /I [%M%]==[us] (
	COLOR 4E & CALL scripts\splash "SHUTTING DOWN"
	shutdown -s -f -t 0
	PAUSE>NUL
	GOTO :final
)
IF /I [%M%]==[ur] (
	COLOR 4E & CALL scripts\splash "RESTARTING..."
	shutdown -r -f -t 0
	PAUSE>NUL
	GOTO :final
)


REM If entry is not known, try execute it via the shell
CALL :launch "%M%"
GOTO :menu


::===========================================================================================================================
:remove

TITLE Tools - Remove Anti Virus...
CLS & ECHO ^
�����������������������������������������������������������������������������Ŀ ^
� TOOLS � REMOVE ANTI VIRUS...                                    � [Q] Quit  � ^
�����������������������������������������������������������������������������Ĵ ^
�                         �                         �                         � ^
� [N] Norton Removal Tool � [AV] Avast (Safe Mode)  �  These reset registry   � ^
�                         �                         �  and file permissions   � ^
� [A] AVGRemover          � [FS] F-Secure           �  for AVG in case you    � ^
�     (auto-restarts)     �                         �  cannot un/install AVG  � ^
�                         � [K9] Kaspersky 9        �  because of permission  � ^
� [M] McAfee              �                         �  denied errors          � ^
�                         � [OC] OneCare            �                         � ^
�������������������������Ĵ                         �  [R9] Reset AVG 9       � ^
�                         � [P7] Panda 2007         �                         � ^
� [NAV] Norton AV 2000-2  �                         �  [R8] Reset AVG 8       � ^
�                         � [P8] Panda 2008         �                         � ^
� [NIS] Norton Internet   �                         �                         � ^
�       Security 2000-2   � [TR] (Trend) PC-Cillin  �                         � ^
�                         �                         �                         � ^
� [NON] NoNav (NAV Corp)  � [PC] Virgin PCGuard     �                         � ^
�                         �                         �                         � ^
�����������������������������������������������������������������������������Ĵ ^
�                                                                             � ^
�������������������������������������������������������������������������������

SET "M=NUL"
SET /P M=: 
If /I [%M%]==[NUL] GOTO :menu
IF /I [%M%]==[q] GOTO :final


REM * AVGRemover
IF /I [%M%]==[a]   IF [%WINBIT%]==[64] CALL :temp "anti_virus\Removers\avgremoverx64.exe"	& GOTO :menu
IF /I [%M%]==[a]   IF [%WINBIT%]==[32] CALL :temp "anti_virus\Removers\avgremover.exe"		& GOTO :menu

IF /I [%M%]==[n]   CALL :launch "anti_virus\Removers\Norton_Removal_Tool.exe"	& GOTO :menu	REM * Norton Removal Tool
IF /I [%M%]==[m]   CALL :launch "anti_virus\Removers\MCPR.exe"			& GOTO :menu	REM * McAfee Remover
IF /I [%M%]==[nav] CALL :launch "anti_virus\Removers\Rnav2003.exe"		& GOTO :menu	REM * NAV 2003
IF /I [%M%]==[nis] CALL :launch "anti_virus\Removers\rnis.exe"			& GOTO :menu	REM * NIS
IF /I [%M%]==[non] CALL :launch "anti_virus\Removers\NoNav 2.49.exe"		& GOTO :menu	REM * NAV Corp Ed.
IF /I [%M%]==[av]  CALL :launch "anti_virus\Removers\aswclear.exe"		& GOTO :menu	REM * Avast
IF /I [%M%]==[fs]  CALL :launch "anti_virus\Removers\F-Secure.exe"		& GOTO :menu	REM * F-Secure
IF /I [%M%]==[k9]  CALL :launch "anti_virus\Removers\KAVremover9.exe"		& GOTO :menu	REM * Kaspersky 9
IF /I [%M%]==[oc]  CALL :launch "anti_virus\Removers\OneCareCleanUp.exe"	& GOTO :menu	REM * OneCare
IF /I [%M%]==[p7]  CALL :temp   "anti_virus\Removers\Panda 2007.exe"		& GOTO :menu	REM * Panda 2007
IF /I [%M%]==[p8]  CALL :temp   "anti_virus\Removers\Panda 2008.exe"		& GOTO :menu	REM * Panda 2008
IF /I [%M%]==[tr]  CALL :launch "anti_virus\Removers\PC-Cillin.exe"		& GOTO :menu	REM * PC-Cillin
IF /I [%M%]==[pc]  CALL :launch "anti_virus\Removers\RpsUU.exe"			& GOTO :menu	REM * Virgin PC-Guard

IF /I [%M%]==[r9]  CALL :launch "anti_virus\Removers\reset_access_avg9_en.exe"	& GOTO :menu	REM * Reset AVG 9
IF /I [%M%]==[r8]  CALL :launch "anti_virus\Removers\reset_access_avg8_en.exe"	& GOTO :menu	REM * Reset AVG 8

GOTO :remove


::===========================================================================================================================
:passwords

TITLE Tools - Passwords...
CLS & ECHO ^
�����������������������������������������������������������������������������Ŀ ^
� TOOLS � PASSWORDS...                                            � [Q] Quit  � ^
�����������������������������������������������������������������������������Ĵ ^
�                         �                         �                         � ^
� [X] XPass               �                         �                         � ^
�                         �                         �                         � ^
� [PK] ProduKey           �                         �                         � ^
� [KF] KeyFinder          �                         �                         � ^
�                         �                         �                         � ^
� [WK] WirelessKeyView    �                         �                         � ^
�                         �                         �                         � ^
�������������������������Ĵ                         �                         � ^
�                         �                         �                         � ^
� [IE] IEPV               �                         �                         � ^
�                         �                         �                         � ^
� [MP] MailPV             �                         �                         � ^
�                         �                         �                         � ^
� [DP] Dialuppass         �                         �                         � ^
�                         �                         �                         � ^
�                         �                         �                         � ^
�����������������������������������������������������������������������������Ĵ ^
�                                                                             � ^
�������������������������������������������������������������������������������

SET "M=NUL"
SET /P M=: 
If /I [%M%]==[NUL] GOTO :menu
IF /I [%M%]==[q]   GOTO :final

IF /I [%M%]==[x]  CALL :launch "utils\pw\xpass\xpass.exe"				& GOTO :menu	REM * XPass

IF /I [%M%]==[pk] IF [%WINBIT%]==[64] CALL :launch "utils\pw\produkey\ProduKey64.exe"	& GOTO :menu	REM * ProduKey x64
IF /I [%M%]==[pk] IF [%WINBIT%]==[32] CALL :launch "utils\pw\produkey\ProduKey.exe"	& GOTO :menu	REM * ProduKey
IF /I [%M%]==[kf] CALL :launch "utils\pw\keyfinder.2.0.1\keyfinder.exe"			& GOTO :menu	REM * KeyFinder

IF /I [%M%]==[wk] CALL :launch "utils\pw\wkview\wirelesskeyview.exe"			& GOTO :menu	REM * WirelessKeyView

IF /I [%M%]==[ie] CALL :launch "utils\pw\iepv\iepv.exe"					& GOTO :menu	REM * IEPassView
IF /I [%M%]==[mp] CALL :launch "utils\pw\mailpv\mailpv.exe"				& GOTO :menu	REM * MailPV
IF /I [%M%]==[dp] CALL :launch "utils\pw\dialuppass\Dialuppass.exe"			& GOTO :menu	REM * Dialuppass

GOTO :passwords


:flash
CLS
CALL scripts\banner "Install Flash Player..."
ECHO  * Install Flash Player for Firefox etc.
internet\install_flash_player.exe -install
IF ERRORLEVEL 1 ECHO  ! Failed
ECHO.
ECHO  * Install Flash Player for IE
internet\install_flash_player_ax.exe -install
IF ERRORLEVEL 1 ECHO  ! Failed & PAUSE
GOTO:EOF


:firefox

CLS
CALL scripts\banner "Install Firefox..."
ECHO * Firefox Installer
ECHO   (Do not open Firefox at end of installation)
internet\Firefox_Setup.exe
ECHO.

SET /P N=  Install AddOns? [y] 
IF /I [%N%]==[y] (
	ECHO * Installing addons...
	CALL :ffxex
)

ECHO.
SET /P N=  Install Adobe Flash Player? [y] 
IF /I [%N%]==[y] (
	ECHO * Installing Flash...
	CALL :flash
)
GOTO :EOF

:ffxex
REM Firefox Extensions

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

REM Show the user interface
CLS & CALL scripts\banner "Installing Firefox Extensions for All Users..."
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

ECHO.
ECHO   All extensions have been installed.
ECHO.
PAUSE & GOTO:EOF


::===========================================================================================================================
::functions
::===========================================================================================================================
:get_temp_file
::provide a temporary file to use
SET "%~1=%TEMP%\tools-%RANDOM%-%TIME:~6,5%.tmp"
GOTO:EOF

::launch a program
:launch
START "" "%~1" %~2
GOTO:EOF

::launch an app by copying it to a temporary folder
:temp
CLS
CALL scripts\banner "Launching via temporary file..."
CALL :get_temp_file TEMP_FILE
COPY "%~1" "%TEMP_FILE%.exe"
START "" /D"%TEMP%" "%TEMP_FILE%.exe"
GOTO:EOF

::===========================================================================================================================
:final
CLS
COLOR