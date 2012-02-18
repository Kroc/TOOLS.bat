@ECHO OFF
COLOR 4E
TITLE Tools - Update

:: configure update options
SET "UPDATE_WEEKLY=CF RK GM MS A! SD CC AV"
SET "UPDATE_MONTHLY=FL FF UK Z IT V N SP J"
SET "UPDATE_ALL=%UPDATE_WEEKLY% %UPDATE_MONTHLY%"

:menu
CLS & ECHO ^
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴� ^
� TOOLS � UPDATE                                                  � [Q] Quit  � ^
쳐컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴� ^
� [W]  All Weekly         � [M]  All Monthly                                  � ^
쳐컴컴컴컴컴컴컴컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴� ^
� [CF] ComboFix           � [FL] Flash Installers   �                         � ^
� [RK] RKill              � [FF] Firefox            �                         � ^
� [GM] GMER               �                         �                         � ^
� [MS] MS Securtity Ess.  �                         �                         � ^
� [A!] Avast!             �                         �                         � ^
� [SD] Spybot SD          �                         �                         � ^
� [CC] CCleaner           � [IT] iTunes             �                         � ^
� [AV] AVG Removers       � [V]  VLC                �                         � ^
�                         �                         �                         � ^
�                         � [UK] CrucialScanner     �                         � ^
�                         � [SP] Speccy             �                         � ^
�                         � [Z]  CPU-Z              �                         � ^
�                         �                         �                         � ^
�                         � [N]  Norton Removal     �                         � ^
�                         � [J] Java                �                         � ^
쳐컴컴컴컴컴컴컴컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴� ^
� [A] Download All        � [AP] Upate AutoPatcher                            � ^
읕컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

:: For "Downloading 1 of 6"
SET "COUNT=1"
SET "TOTAL=1"

SET "UPDATE_WHICH=NONE"

SET "M=NUL"
SET /P M=: 
If /I [%M%]==[NUL] GOTO :menu
IF /I [%M%]==[q] GOTO :end

IF /I [%M%]==[ap] START "" "..\updates\autopatcher\apup.exe" & GOTO :menu

IF /I [%M%]==[ms] SET "TOTAL=4"
IF /I [%M%]==[av] SET "TOTAL=4"
IF /I [%M%]==[cc] SET "TOTAL=2"
IF /I [%M%]==[sd] SET "TOTAL=2"
IF /I [%M%]==[fl] SET "TOTAL=6"
IF /I [%M%]==[ff] SET "TOTAL=4"
IF /I [%M%]==[it] SET "TOTAL=2"
IF /I [%M%]==[w]  SET "UPDATE_WHICH=%UPDATE_WEEKLY%"	& SET "TOTAL=19"
IF /I [%M%]==[m]  SET "UPDATE_WHICH=%UPDATE_MONTHLY%"	& SET "TOTAL=15"
IF /I [%M%]==[a]  SET "UPDATE_WHICH=%UPDATE_ALL%"	& SET "TOTAL=34"

IF "%UPDATE_WHICH%" NEQ "NONE" (
	FOR %%I IN (%UPDATE_WHICH%) DO CALL :update_%%I
	ECHO.
	PAUSE
) ELSE (
	CALL :update_%M%
)
GOTO :menu


:update_CF
:: ComboFix
CALL :download "ComboFix" ^
	"..\anti_spyware\removers\ComboFix.exe" ^
	"http://download.bleepingcomputer.com/sUBs/ComboFix.exe"
GOTO:EOF

:update_RK
:: RKill
CALL :download "RKill" ^
	"..\anti_spyware\removers\rkill.exe" ^
	"http://download.bleepingcomputer.com/grinler/rkill.exe"
GOTO:EOF

:update_GM
:: GMER
CALL :download "GMER" ^
	"..\anti_spyware\removers\gmer.zip" ^
	"http://www.gmer.net/gmer.zip"
ERASE /Q /F "..\anti_spyware\removers\gmer.exe"
7za x -y -o"..\anti_spyware\removers\" "..\anti_spyware\removers\gmer.zip"
ERASE /Q /F "..\anti_spyware\removers\gmer.zip"
GOTO:EOF


:update_MS
CALL :download "Microsoft Security Essentials (32-Bit)" ^
	"..\anti_virus\mseinstall_x86.exe" ^
	"http://mse.dlservice.microsoft.com/download/A/3/8/A38FFBF2-1122-48B4-AF60-E44F6DC28BD8/enus/x86/mseinstall.exe"
CALL :download "Microsoft Security Essentials (64-Bit)" ^
	"..\anti_virus\mseinstall_x64.exe" ^
	"http://mse.dlservice.microsoft.com/download/A/3/8/A38FFBF2-1122-48B4-AF60-E44F6DC28BD8/enus/amd64/mseinstall.exe"
::Microsoft Security Essentials (Definitions)
CALL :download "Microsoft Security Essentials Update Definitions" ^
	"..\anti_virus\mpam-fe.exe" ^
	"http://go.microsoft.com/fwlink/?LinkID=87342"
::Microsoft Security Essentials (Definitions 64-Bit)
CALL :download "Microsoft Security Essentials Update Definitions (64-Bit)" ^
	"..\anti_virus\mpam-fex64.exe" ^
	"http://go.microsoft.com/fwlink/?LinkID=87341"
GOTO:EOF

:update_A!
CALL :download "Avast! (32-Bit)" ^
	"..\anti_virus\Avast.exe" ^
	"http://files.avast.com/iavs5x/setup_av_free.exe"
GOTO:EOF

:update_AV
:: AVGRemover Free (32-Bit)
CALL :download "AVGRemover Free (32-Bit)" ^
	"..\anti_virus\removers\avgremover.exe" ^
	"http://download.avg.com/filedir/util/avg_arm_sup_____.dir/avgremover.exe"
:: AVGRemover Free (64-bit)
CALL :download "AVGRemover Free (64-Bit)" ^
	"..\anti_virus\removers\avgremoverx64.exe" ^
	"http://download.avg.com/filedir/util/avg_arv_sup_____.dir/avgremoverx64.exe"
:: AVGRemover Full 2011 (32-bit)
CALL :download "AVGRemover Full 2011 (32-bit)" ^
	"..\anti_virus\removers\avg_remover_stf_x86_2011.exe" ^
	"http://www.avg.com/ww-en/download-tools" ^
	"http://download\.avg\.com/filedir/util/support/avg_remover_stf_x86_2011_\d+\.exe"
:: AVGRemover Full 2011 (64-bit)
CALL :download "AVGRemover Full 2011 (64-bit)" ^
	"..\anti_virus\removers\avg_remover_stf_x64_2011.exe" ^
	"http://www.avg.com/ww-en/download-tools" ^
	"http://download\.avg\.com/filedir/util/support/avg_remover_stf_x64_2011_\d+\.exe"
GOTO:EOF

:update_SD
:: Spybot Search Destroy
CALL :download "Spybot Search and Destroy" ^
	"..\anti_spyware\spybotsd.exe" ^
	"http://www.safer-networking.org/en/ownmirrors1/index.html" ^
	"http://www\.spybotupdates\.com/files/spybotsd\d{3}\.exe"
:: Spybot Includes
CALL :download "Spybot Offline Updates" ^
	"..\anti_spyware\spybotsd_includes.exe" ^
	"http://www.spybotupdates.biz/updates/files/spybotsd_includes.exe"
GOTO:EOF

:update_CC
:: CCleaner Clim
CALL :download "CCleaner (slim)" ^
	"..\utils\clean\CCleaner.exe" ^
	"http://www.piriform.com/ccleaner/download/slim/downloadfile"
:: CCleaner Portable
CALL :download "CCleaner (portable)" ^
	"..\utils\clean\ccleaner.zip" ^
	"http://www.piriform.com/ccleaner/download/portable/downloadfile"
ERASE /Q /F "..\utils\clean\ccleaner\*.*"
7za x -y -o"..\utils\clean\ccleaner\" "..\utils\clean\ccleaner.zip"
ERASE /Q /F "..\utils\clean\ccleaner.zip"
GOTO:EOF

:: === MONTHLY UPDATES ======================================================================================================

:update_FL
:: Flash Installer (Firefox etc.)
CALL :download "Flash Installer (Firefox etc.) 32-Bit" ^
	"..\internet\install_flash_player_32bit.exe" ^
	http://download.macromedia.com/pub/flashplayer/current/install_flash_player_32bit.exe
CALL :download "Flash Installer (Firefox etc.) 64-Bit" ^
	"..\internet\install_flash_player_64bit.exe" ^
	http://download.macromedia.com/pub/flashplayer/current/install_flash_player_64bit.exe
:: Flash Installer (IE)
CALL :download "Flash Installer (IE) 32-Bit" ^
	"..\internet\install_flash_player_ax_32bit.exe" ^
	http://download.macromedia.com/pub/flashplayer/current/install_flash_player_ax_32bit.exe
CALL :download "Flash Installer (IE) 64-Bit" ^
	"..\internet\install_flash_player_ax_64bit.exe" ^
	http://download.macromedia.com/pub/flashplayer/current/install_flash_player_ax_64bit.exe
:: Flash Uninstaller
CALL :download "Flash Uninstaller (32-Bit)" ^
	"..\internet\uninstall_flash_player_32bit.exe" ^
	http://download.macromedia.com/pub/flashplayer/current/uninstall_flash_player_32bit.exe
CALL :download "Flash Uninstaller (64-Bit)" ^
	"..\internet\uninstall_flash_player_64bit.exe" ^
	http://download.macromedia.com/pub/flashplayer/current/uninstall_flash_player_64bit.exe
GOTO:EOF

:update_FF
:: Firefox
CALL :download "Firefox" ^
	"..\internet\Firefox_Setup.exe" ^
	"https://www.mozilla.org/en-US/firefox/all.html" ^
	"http://download\.mozilla\.org/\?product=firefox-.*?&(amp;)?os=win&(amp;)?lang=en-GB"
:: Firefox - AdBlock Plus
CALL :download "Firefox - AdBlock Plus" ^
	"..\internet\AdBlockPlus.xpi" ^
	"https://addons.mozilla.org/en-US/firefox/downloads/latest/1865/addon-1865-latest.xpi"
:: Firefox - British Engish Dictionary
CALL :download "Firefox - British English Dictionary" ^
	"..\internet\BritishEnglishDictionary.xpi" ^
	"https://addons.mozilla.org/en-US/firefox/downloads/latest/3366/addon-3366-latest.xpi"
ERASE /Q /F "..\internet\en-GB@dictionaries.addons.mozilla.org\*.*"
7za x -y -o"..\internet\en-GB@dictionaries.addons.mozilla.org\" "..\internet\BritishEnglishDictionary.xpi"

:: Firefox - Web of Trust
CALL :download "Firefox - Web of Trust" ^
	"..\internet\WebOfTrust.xpi" ^
	"https://addons.mozilla.org/en-US/firefox/downloads/latest/3456/addon-3456-latest.xpi"
GOTO:EOF

:update_UK
:: Crucial Scanner
CALL :download "Crucial Scanner" ^
	"..\utils\info\CrucialUKScan.exe" ^
	"http://images.crucial.com/drivers/CrucialUKScan.exe"
GOTO:EOF

:update_SA
:: SiteAdvisor
CALL :download "McAfee SiteAdvisor" ^
	"..\internet\saSetup.exe" ^
	"https://sadownload.mcafee.com/products/SA/Website/saSetup.exe"
GOTO:EOF

:update_Z
:: CPU-Z
CALL :download "CPU-Z" ^
	"..\utils\info\cpuz.zip" ^
	"http://www.cpuid.com/cpuz.php" ^
	"http://www\.cpuid\.com/download/cpuz/cpuz_\d\d\d\.zip"
7za x -y -o"..\utils\info\" "..\utils\info\cpuz.zip" >NUL
Erase /F /Q "..\utils\info\cpuz_readme.txt"
Erase /F /Q "..\utils\info\cpuz.zip"
GOTO:EOF

:update_IT
:: iTunes
CALL :download "iTunes (32-Bit)" ^
	"..\end_user\iTunesSetup.exe" ^
	"https://swdlp.apple.com/cgi-bin/WebObjects/SoftwareDownloadApp.woa/wa/getProductData?localang=en_uk&grp_code=itunes" ^
	"http://.*?/iTunesSetup\.exe"
Call :download "iTunes (64-Bit)" ^
	"..\end_user\iTunes64Setup.exe" ^
	"http://support.apple.com/kb/DL1047" ^
	"http://.*?/iTunes64Setup\.exe"
GOTO:EOF

:update_V
:: VideoLan
CALL :download "VLC" ^
	"..\end_user\vlc-win32.exe" ^
	"http://www.free-codecs.com/VideoLAN_download.htm" ^
	"http://www\.free-codecs\.com/download_soft\.php?d=\d{4}&s=171"
GOTO:EOF

:update_N
::Norton Removal Tool
CALL :download "Norton Removal Tool" ^
	"..\anti_virus\removers\Norton_Removal_Tool.exe" ^
	"ftp://ftp.symantec.com/public/english_us_canada/removal_tools/Norton_Removal_Tool.exe"
GOTO:EOF

:update_SP
:: Speccy Portable
CALL :download "Speccy (portable)" ^
	"..\utils\info\speccy.zip" ^
	"http://www.piriform.com/speccy/download/portable/downloadfile"
ERASE /Q /F "..\utils\info\speccy\*.*"
7za x -y -o"..\utils\info\speccy\" "..\utils\info\speccy.zip"
ERASE /Q /F "..\utils\info\speccy.zip"
GOTO:EOF

:update_J
:: Java
CALL :download "Java" ^
	"..\internet\jre.exe" ^
	"http://javadl.sun.com/webapps/download/AutoDL?BundleId=48343"
GOTO:EOF

::===========================================================================================================================
::functions
::===========================================================================================================================
:download
:: arg1: title
:: arg2: save location
:: arg3: URL to download / search
:: arg4: optional regex to find and download (arg3 should be an HTML page instead)

:: display heads up
SET "align=%~1                                                                " & REM 64 chars
SET "C= %COUNT%"
SET "T= %TOTAL%"
CLS & ECHO ^
旼컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴� ^
� %C:~-2% of %T:~-2% � %align:~0,64% � ^
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

:: is arg4 provided; do we need to use the regex?
IF "_" NEQ "_%~4" (
	FOR /f "delims=" %%R IN ('CScript //NOLOGO geturl.vbs "%~3" "%~4"') DO (SET "URL=%%R")
) ELSE (
	SET "URL=%~3"
)

::get a temporary file to download to
CALL :get_temp_file TEMP_FILE

:: download the file to the temporary location
curl\curl.exe --insecure --location --output "%TEMP_FILE%" "%URL%"


::did the download fail for any reason?
IF %ERRORLEVEL% NEQ 0 (
	ECHO.
	ECHO -------------------------------------------------------------------------------
	ECHO An error occured
	ECHO.
	PAUSE
) ELSE (
	:: remove read-only attribute on target file
	ATTRIB -R "%~2" >NUL
	
	::copy the downloaded file over the destination file
	ECHO.
	COPY /Y "%TEMP_FILE%" "%~2" >NUL
)
SET /a COUNT+=1
GOTO:EOF


:get_temp_file
::provide a temporary file to use
SET "%~1=%TEMP%\tools-%RANDOM%-%TIME:~6,5%.tmp"
GOTO:EOF

:end
