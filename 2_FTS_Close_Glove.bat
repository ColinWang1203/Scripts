@echo off
if exist test.txt del test.txt /f /q
@echo ---------------------------------------------------------------
@echo Starting ......
@echo ---------------------------------------------------------------
adb root
adb remount > null
timeout /t 3 > null
adb shell "getprop | grep bright"  > test.txt 2>&1
find /i "[ro.config.device.def_screen_brightness]: [0]" test.txt >> log.txt
if "%errorlevel%" == "0" (
	adb shell input keyevent 26
    timeout /t 1 > null
) else (
	adb shell input keyevent 26
    timeout /t 1 > null
    adb shell input keyevent 26
    timeout /t 1 > null
)
adb shell "echo 0 > /sys/bus/i2c/devices/4-0038/fts_glove_mode"
timeout /t 1 > null
@echo ---------------------------------------------------------------
adb shell "cat /sys/bus/i2c/devices/4-0038/fts_glove_mode"
@echo ---------------------------------------------------------------
if exist test.txt del test.txt /f /q
pause