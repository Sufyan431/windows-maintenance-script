@echo off
title Windows Cleanup & Repair Toolkit

:: ===============================
:: MAIN MENU
:: ===============================
:main_menu
cls
echo.
echo ==========================================
echo    Windows Cleanup ^& Repair Toolkit
echo ==========================================
echo.
echo   [1]  Basic Cleanup       
echo   [2]  Advanced Repair     
echo   [3]  Networking          
echo   [4]  Exit
echo.
echo ==========================================
choice /C 1234 /M "Select a section to run"
if errorlevel 4 goto end
if errorlevel 3 goto networking_section
if errorlevel 2 goto advanced_section
if errorlevel 1 goto basic_section


:: ================================================
::             BASIC SECTION 
:: ================================================
:basic_section
cls
echo.
echo ##########################################
echo #       BASIC CLEANUP        #
echo ##########################################


:: -----------------------------------------------
:: STEP 1 - Temp Files
:: -----------------------------------------------
echo.
echo ==========================================
echo   STEP 1 : Temp Files
echo ==========================================
echo.

echo   CMD 1 : User Temp Files ^( %%temp%% ^)
choice /M "   Do you want to run this step"
if errorlevel 2 goto b1_cmd2
del /q /f /s %temp%\*
echo   Done.
echo.

:b1_cmd2
echo   CMD 2 : System Temp Files ^( C:\Windows\Temp ^)
choice /M "   Do you want to run this step"
if errorlevel 2 goto basic_step2
del /q /f /s C:\Windows\Temp\*
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 2 - Prefetch Files
:: -----------------------------------------------
:basic_step2
echo ==========================================
echo   STEP 2 : Prefetch Files
echo ==========================================
echo.

echo   CMD 1 : Prefetch Folder Clear ^( C:\Windows\Prefetch ^)
choice /M "   Do you want to run this step"
if errorlevel 2 goto basic_step3
del /q /f /s C:\Windows\Prefetch\*
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 3 - Recent Files
:: -----------------------------------------------
:basic_step3
echo ==========================================
echo   STEP 3 : Recent Files
echo ==========================================
echo.

echo   CMD 1 : Recent Files Clear
choice /M "   Do you want to run this step"
if errorlevel 2 goto b3_cmd2
del /q /f /s "%APPDATA%\Microsoft\Windows\Recent\*"
echo   Done.
echo.

:b3_cmd2
echo   CMD 2 : AutomaticDestinations Clear
choice /M "   Do you want to run this step"
if errorlevel 2 goto b3_cmd3
del /q /f /s "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*"
echo   Done.
echo.

:b3_cmd3
echo   CMD 3 : CustomDestinations Clear
choice /M "   Do you want to run this step"
if errorlevel 2 goto basic_step4
del /q /f /s "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*"
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 4 - Disk Cleanup
:: -----------------------------------------------
:basic_step4
echo ==========================================
echo   STEP 4 : Disk Cleanup
echo ==========================================
echo.

echo   CMD 1 : cleanmgr /sagerun:1
choice /M "   Do you want to run this step"
if errorlevel 2 goto basic_step5
cleanmgr /sagerun:1
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 5 - Browser Cache
:: -----------------------------------------------
:basic_step5
echo ==========================================
echo   STEP 5 : Browser Cache
echo ==========================================
echo.

echo   CMD 1 : Chrome Cache Clear
choice /M "   Do you want to run this step"
if errorlevel 2 goto b5_cmd2
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*"
echo   Done.
echo.

:b5_cmd2
echo   CMD 2 : Edge Cache Clear
choice /M "   Do you want to run this step"
if errorlevel 2 goto basic_step6
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*"
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 6 - DISM Health Restore
:: -----------------------------------------------
:basic_step6
echo ==========================================
echo   STEP 6 : DISM Health Restore
echo ==========================================
echo.

echo   CMD 1 : DISM /Online /Cleanup-Image /RestoreHealth
choice /M "   Do you want to run this step"
if errorlevel 2 goto basic_step7
DISM /Online /Cleanup-Image /RestoreHealth
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 7 - SFC Scan
:: -----------------------------------------------
:basic_step7
echo ==========================================
echo   STEP 7 : SFC Scan
echo ==========================================
echo.

echo   CMD 1 : sfc /scannow
choice /M "   Do you want to run this step"
if errorlevel 2 goto basic_complete
sfc /scannow
echo   Done.
echo.

:basic_complete
echo.
echo ==========================================
echo   BASIC - All Steps Completed!
echo ==========================================
echo.
choice /M "Do you want to restart your PC"
if errorlevel 2 goto main_menu
shutdown /r /t 5
goto end


:: ================================================
::           ADVANCED SECTION 
:: ================================================
:advanced_section
cls
echo.
echo ##########################################
echo #     ADVANCED REPAIR       #
echo ##########################################


:: -----------------------------------------------
:: STEP 8 - Windows Update Cache
:: -----------------------------------------------
echo.
echo ==========================================
echo   STEP 8 : Windows Update Cache
echo ==========================================
echo.

echo   CMD 1 : Stop wuauserv Service
choice /M "   Do you want to run this step"
if errorlevel 2 goto adv_s8_cmd2
net stop wuauserv
echo   Done.
echo.

:adv_s8_cmd2
echo   CMD 2 : Stop bits Service
choice /M "   Do you want to run this step"
if errorlevel 2 goto adv_s8_cmd3
net stop bits
echo   Done.
echo.

:adv_s8_cmd3
echo   CMD 3 : Rename SoftwareDistribution Folder
choice /M "   Do you want to run this step"
if errorlevel 2 goto adv_s8_cmd4
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
echo   Done.
echo.

:adv_s8_cmd4
echo   CMD 4 : Start wuauserv Service
choice /M "   Do you want to run this step"
if errorlevel 2 goto adv_s8_cmd5
net start wuauserv
echo   Done.
echo.

:adv_s8_cmd5
echo   CMD 5 : Start bits Service
choice /M "   Do you want to run this step"
if errorlevel 2 goto advanced_step9
net start bits
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 9 - chkdsk
:: -----------------------------------------------
:advanced_step9
echo ==========================================
echo   STEP 9 : Disk Check ^( chkdsk ^)
echo ==========================================
echo.

echo   CMD 1 : chkdsk C: /f /r /x
choice /M "   Do you want to run this step"
if errorlevel 2 goto advanced_step10
echo Y | chkdsk C: /f /r /x
echo   Done. Disk check will run on next reboot.
echo.


:: -----------------------------------------------
:: STEP 10 - Event Logs Clear
:: -----------------------------------------------
:advanced_step10
echo ==========================================
echo   STEP 10 : Event Logs Clear
echo ==========================================
echo.

echo   CMD 1 : Clear All Windows Event Logs
choice /M "   Do you want to run this step"
if errorlevel 2 goto advanced_complete
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (wevtutil.exe cl "%%G")
echo   Done.
echo.

:advanced_complete
echo.
echo ==========================================
echo   ADVANCED - All Steps Completed!
echo ==========================================
echo.
choice /M "Do you want to restart your PC"
if errorlevel 2 goto main_menu
shutdown /r /t 5
goto end


:: ================================================
::          NETWORKING SECTION (Steps 11-13)
:: ================================================
:networking_section
cls
echo.
echo ##########################################
echo #      NETWORKING  (Steps 11-13)        #
echo ##########################################


:: -----------------------------------------------
:: STEP 11 - DNS Flush
:: -----------------------------------------------
echo.
echo ==========================================
echo   STEP 11 : DNS Flush
echo ==========================================
echo.

echo   CMD 1 : ipconfig /flushdns
echo   Info  : This will flush your DNS cache and remove all stored DNS records.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s11_cmd2
ipconfig /flushdns
echo   Done.
echo.

:net_s11_cmd2
echo   CMD 2 : ipconfig /release
echo   Info  : This will release your current IP address from the network.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s11_cmd3
ipconfig /release
echo   Done.
echo.

:net_s11_cmd3
echo   CMD 3 : ipconfig /renew
echo   Info  : This will request a new IP address from the network.
choice /M "   Do you want to run this step"
if errorlevel 2 goto networking_step12
ipconfig /renew
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 12 - Network Stack Reset
:: -----------------------------------------------
:networking_step12
echo ==========================================
echo   STEP 12 : Network Stack Reset
echo ==========================================
echo.

echo   CMD 1 : netsh winsock reset
echo   Info  : This will reset Winsock catalog to fix corrupted network settings.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s12_cmd2
netsh winsock reset
echo   Done.
echo.

:net_s12_cmd2
echo   CMD 2 : netsh int ip reset
echo   Info  : This will reset TCP/IP stack to fix internet connectivity issues.
choice /M "   Do you want to run this step"
if errorlevel 2 goto networking_step13
netsh int ip reset
echo   Done.
echo.


:: -----------------------------------------------
:: STEP 13 - TCP Stack Reset
:: -----------------------------------------------
:networking_step13
echo ==========================================
echo   STEP 13 : TCP Stack Reset
echo ==========================================
echo.

echo   CMD 1 : netsh int tcp reset
echo   Info  : This will reset the TCP stack to resolve connection issues.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s13_cmd2
netsh int tcp reset
echo   Done.
echo.

:net_s13_cmd2
echo   CMD 2 : netsh int ipv4 reset
echo   Info  : This will reset IPv4 settings to default.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s13_cmd3
netsh int ipv4 reset
echo   Done.
echo.

:net_s13_cmd3
echo   CMD 3 : netsh int ipv6 reset
echo   Info  : This will reset IPv6 settings to default.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s13_cmd4
netsh int ipv6 reset
echo   Done.
echo.

:net_s13_cmd4
echo   CMD 4 : TCP Auto Tuning - Normal
echo   Info  : This will set TCP auto tuning to normal for better network performance.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s13_cmd5
netsh int tcp set global autotuninglevel=normal
echo   Done.
echo.

:net_s13_cmd5
echo   CMD 5 : TCP Chimney Offload - Disabled
echo   Info  : This will disable TCP chimney offload to fix network stability issues.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s13_cmd6
netsh int tcp set global chimney=disabled
echo   Done.
echo.

:net_s13_cmd6
echo   CMD 6 : ECN Capability - Disabled
echo   Info  : This will disable ECN to fix compatibility issues with some routers.
choice /M "   Do you want to run this step"
if errorlevel 2 goto net_s13_cmd7
netsh int tcp set global ecncapability=disabled
echo   Done.
echo.

:net_s13_cmd7
echo   CMD 7 : TCP Timestamps - Disabled
echo   Info  : This will disable TCP timestamps to improve network speed.
choice /M "   Do you want to run this step"
if errorlevel 2 goto networking_complete
netsh int tcp set global timestamps=disabled
echo   Done.
echo.

:networking_complete
echo.
echo ==========================================
echo   NETWORKING - All Steps Completed!
echo ==========================================
echo.
choice /M "Do you want to restart your PC"
if errorlevel 2 goto main_menu
shutdown /r /t 5
goto end


:: ===============================
:: EXIT
:: ===============================
:end
echo.
echo ==========================================
echo   Script Finished. Thank You!
echo ==========================================
pause
exit
