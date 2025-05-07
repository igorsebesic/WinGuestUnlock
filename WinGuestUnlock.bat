@echo off
echo ***********************************
echo  Anonymous Guest Access and Insecure Guest Logins
echo ***********************************
echo.

:: Enable insecure guest logins (Pro versions only)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f

:: Turn off password protected sharing
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v everyoneincludesanonymous /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v NoLmHash /t REG_DWORD /d 0 /f

:: Enable Guest Access u Local Security Policy
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RestrictAnonymous /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RestrictNullSessAccess /t REG_DWORD /d 0 /f

:: Enable SMB1 protocol (if disabled)
dism /online /enable-feature /featurename:SMB1Protocol /norestart

:: Enable File & Printer Sharing in firewall
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

:: Check and enable Guest account
net user Guest /active:yes

:: Restart network services
echo Restart network services...
net stop lanmanserver /y
net start lanmanserver
net stop lanmanworkstation /y
net start lanmanworkstation

::Group Policy Changes (Pro versions only)
echo Update Group Policy...
gpupdate /force

:: Reset network config
ipconfig /flushdns
ipconfig /registerdns
nbtstat -R
nbtstat -RR
netsh winsock reset
netsh int ip reset

echo.
echo *** Please restart your PC ***
pause
exit
