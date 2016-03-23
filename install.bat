@echo off
cls
color 0B
rem 
rem  by kaiiori xda-developers
rem
echo  " ============================================ " 
echo  " |                                          | " 
echo  " |    *** Installer Support init.d    ***   | " 
echo  " |         by kaiiori xda-developers        | " 
echo  " |               Developers                 | " 
echo  " |                                          | " 
echo  " ============================================ " 
cd tool
adb kill-server
adb start-server
adb wait-for-device
echo Done device detected...
echo.

:menu
echo 1. Install busybox
echo 2. Install support init.d
echo 3. Reboot
echo 4. Exit

SET /P M=Enter your choice:
echo.
IF %M%==1 GOTO busybox
IF %M%==2 GOTO install
IF %M%==3 GOTO phone
IF %M%==4 GOTO end
pause

:busybox
adb push busybox /data/local/tmp/busybox
adb shell "chmod 0755 /data/local/tmp/busybox"

@echo;
timeout 1 > nul
adb shell "su -c 'mount -o remount,ro /system'"
@echo;
adb kill-server
echo.
echo Finished!
echo.
goto menu

:install
echo ===============================================
echo          Installing support init.d
echo ===============================================
adb push support.sh /data/local/tmp/support.sh
adb shell "chmod 0755 /data/local/tmp/support.sh"
adb shell "su -c 'mount -o remount,rw /system'"

@echo;
adb shell "su -c '/data/local/tmp/support.sh'"
timeout 1 > nul
adb shell "su -c 'mount -o remount,ro /system'"
@echo;
adb kill-server
echo.
echo Finished!
echo.
goto menu

:phone
adb reboot

:end
exit
