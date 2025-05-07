@echo off
echo ***********************************
echo  Omogucavanje Anonymous Guest Access i Insecure Guest Logins
echo ***********************************
echo.

:: Omoguci insecure guest logins (za Pro verzije)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f

:: Iskljuci password protected sharing
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v everyoneincludesanonymous /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v NoLmHash /t REG_DWORD /d 0 /f

:: Omoguci Guest Access u Local Security Policy
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RestrictAnonymous /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RestrictNullSessAccess /t REG_DWORD /d 0 /f

:: Omoguci SMB1 protokol (ako je iskljucen)
dism /online /enable-feature /featurename:SMB1Protocol /norestart

:: Omoguci File & Printer Sharing u firewall-u
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

:: Proveri i omoguci Guest nalog
net user Guest /active:yes

:: Restartuj mrezne servise
echo Restartovanje mrežnih servisa...
net stop lanmanserver /y
net start lanmanserver
net stop lanmanworkstation /y
net start lanmanworkstation

:: Primeni promene u Group Policy-ju (za Pro verzije)
echo Azuriranje Group Policy postavki...
gpupdate /force

:: Resetuj mrežne konekcije
ipconfig /flushdns
ipconfig /registerdns
nbtstat -R
nbtstat -RR
netsh winsock reset
netsh int ip reset

echo.
echo *** Restartuj racunar da bi promene stupile na snagu! ***
pause
exit
