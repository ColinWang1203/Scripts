@echo off

set SubFunction_result=
set /a retry=0
if exist log.txt del log.txt /f /q

fastboot devices > test.txt 2>&1
find /i "fastboot" test.txt >> log.txt
if "%errorlevel%" == "0" (
goto Found_Fastboot
)
:Try_Reboot
@echo ---------------------------------------------------------------
@echo    Try Rebooting ...
@echo ---------------------------------------------------------------

adb kill-server >> log.txt 2>&1
adb reboot bootloader >> log.txt 2>&1

@echo ---------------------------------------------------------------
@echo    Waiting for fastboot device ...
@echo ---------------------------------------------------------------

:Fastboot
fastboot devices > test.txt 2>&1
find /i "fastboot" test.txt >> log.txt
if "%errorlevel%" == "1" (
REM timeout /t 1 >> log.txt
goto Fastboot
)

:Found_Fastboot
@echo ---------------------------------------------------------------
@echo    Found fastboot device !
@echo ---------------------------------------------------------------

:Check_SKU
fastboot oem sku > test.txt 2>&1
find /i "Prgrammed SKU is 0" test.txt >> log.txt
if "%errorlevel%" == "0" (
@echo ---------------------------------------------------------------
@echo    ERROR: SKU is not programmed ...
@echo ---------------------------------------------------------------
goto Fail_result
)

:Check_Unlock
@echo ---------------------------------------------------------------
@echo Device Info :
fastboot oem device-info 2>&1 >> log.txt
@echo ---------------------------------------------------------------

fastboot oem device-info > test.txt 2>&1
find /i "Device unlocked: true" test.txt >> log.txt
if "%errorlevel%" == "0" (
goto is_unlocked
)

@echo ---------------------------------------------------------------
@echo    Device is not unlocked, unlocking ...
@echo ---------------------------------------------------------------
fastboot oem allow_unlock >> log.txt 2>&1

::Get Serail Number
fastboot devices > test.txt 2>&1
for /F "tokens=1,2" %%a in (test.txt) do if fastboot == %%b set serial_number=%%a
::Get CPU ID
fastboot getvar msmserialno > test.txt 2>&1
for /F "tokens=1,2" %%a in (test.txt) do if msmserialno: == %%a set cpu_id=%%b

fastboot oem unlock_password zebra_helios_emc > test.txt 2>&1
find /i "failed" test.txt >> log.txt
if "%errorlevel%" == "0" (
@echo ---------------------------------------------------------------
@echo    OTP unlock required, please issue a jira for the OTP file.
@echo ---------------------------------------------------------------
@echo 1. Create a JIRA issue using project "Secure Signing Requests(SIGN)"
@echo 2. Issue type = "Request"
@echo 3. Summary = fbkey %serial_number% %cpu_id% 100
@echo 4. fastboot flash otp otp_%cpu_id%.bin; fastboot oem unlock_all
@echo ---------------------------------------------------------------
goto Fail_result
)
fastboot flashing unlock >> log.txt 2>&1
REM timeout /t 60 >> log.txt
@echo ---------------------------------------------------------------
@echo    Long press "Vol_down + Power" after android logo shows up
@echo ---------------------------------------------------------------
goto Fastboot

:is_unlocked
@echo ---------------------------------------------------------------
@echo    Device is unlocked, start flashing ...
@echo ---------------------------------------------------------------

fastboot --set-active=a >> log.txt 2>&1

@echo ---------------------------------------------------------------
@echo    Select slot "a" to boot
@echo ---------------------------------------------------------------

call:flash_image abl_a abl.elf
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image abl_b abl.elf
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image bluetooth_a BTFM.bin
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image bluetooth_b BTFM.bin
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image devcfg_a devcfg.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image devcfg_b devcfg.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image dsp_a dspso.bin
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image dsp_b dspso.bin
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image cmnlib_a cmnlib.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image cmnlib_b cmnlib.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image cmnlib64_a cmnlib64.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image cmnlib64_b cmnlib64.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image hyp_a hyp.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image hyp_b hyp.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image keymaster_a km4.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image keymaster_b km4.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image storsec storsec.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image mdtp_a mdtp.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image mdtp_b mdtp.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image mdtpsecapp_a mdtpsecapp.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image mdtpsecapp_b mdtpsecapp.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image modem_a NON-HLOS_WLAN.bin
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image modem_b NON-HLOS_WLAN.bin
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image xbl_a xbl.elf
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image xbl_b xbl.elf
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image pmic_a pmic.elf
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image pmic_b pmic.elf
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image rpm_a rpm.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image rpm_b rpm.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image tz_a tz.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image tz_b tz.mbn
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image boot_a boot.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image boot_b boot.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image dtbo_a dt.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image dtbo_b dt.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image system_a system.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image system_b system.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image vendor_a vendor.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image vendor_b vendor.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image enterprise enterprise.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt
call:flash_image factory odm_defaultWLAN.img
  if not %SubFunction_result% == PASS goto Fail_result
REM timeout /t 1 >> log.txt

:Finish_Flashing
@echo ---------------------------------------------------------------
@echo    Erasing Userdata ...
@echo ---------------------------------------------------------------
fastboot erase userdata >> log.txt 2>&1
@echo ---------------------------------------------------------------
@echo    Rebooting ...
@echo ---------------------------------------------------------------
fastboot reboot >> log.txt 2>&1
goto Pass_result

:Fail_result
echo ==========================================================
echo --0000000000-------0000--------000000000000---00----------
echo --00--------------00--00------------00--------00----------
echo --00-------------00----00-----------00--------00----------
echo --00000000------00------00----------00--------00----------
echo --00-----------000000000000---------00--------00----------
echo --00-----------00--------00---------00--------00----------
echo --00-----------00--------00----000000000000---0000000000--
echo ==========================================================
pause
goto Flash_End

:Pass_result
echo ==========================================================
echo --00000000000-------0000--------00000000000----00000000000
echo --00-------00------00---00------00-------------00-------00
echo --00-------00-----00-----00-----00-------------00---------
echo --00000000000----00-------00----00000000000----00000000000
echo --00-------------00000000000-------------00-------------00
echo --00-------------00-------00----00-------00----00-------00
echo --00-------------00-------00----00000000000----00000000000
echo ==========================================================
REM timeout /t 2 >> log.txt
if exist test.txt del test.txt /f /q
if exist log.txt del log.txt /f /q
goto Flash_End


:flash_image
@echo ---------------------------------------------------------------
@echo    Flashing %2 file into %1 ...
@echo ---------------------------------------------------------------
fastboot flash %1 %2 > test.txt 2>&1
find /i "OKAY" test.txt >> log.txt
if "%errorlevel%" == "0" (
	set SubFunction_result=PASS
	set /a retry=0
) else (
	if "%retry%" == "3" (
	set SubFunction_result=FAIL
	) else (
	set /a retry=%retry%+1
	@echo Flash failed, start retry %retry%
	goto flash_image
	)
)
::for call
goto :EOF

:Flash_End
pause
