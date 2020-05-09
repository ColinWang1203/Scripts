@echo off
adb pull dmesg > log.txt
cmd /c Code "log.txt"
exit