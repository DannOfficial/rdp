@echo off

REM Delete Epic Games Launcher shortcut
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1

REM Set server description
net config server /srvcomment:"Windows Server 2019 By mohammadali" >> out.txt 2>&1

REM Disable auto-hide for the system tray
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F >> out.txt 2>&1

REM Set the wallpaper script to run at startup
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d D:\a\wallpaper.bat

REM Add a new user and add to administrators group
net user mohammadali mmd@123 /add >nul
net localgroup administrators mohammadali /add >nul
net user mohammadali /active:yes >nul

REM Delete a user named installer
net user installer /delete >nul

REM Enable and start the performance counters and the audio service
diskperf -Y >nul
sc config Audiosrv start= auto >nul
sc start Audiosrv >nul

REM Grant full access to specified directories for the new user
ICACLS C:\Windows\Temp /grant mohammadali:F >nul
ICACLS C:\Windows\installer /grant mohammadali:F >nul

REM Display installation success message
echo Successfully installed! If RDP is dead, rebuild again.

REM Retrieve and display the Ngrok IP address
tasklist | find /i "ngrok.exe" >Nul
if %errorlevel% == 0 (
    for /f "tokens=*" %%i in ('curl -s localhost:4040/api/tunnels ^| jq -r .tunnels[0].public_url') do set IP=%%i
    echo IP: %IP%
)

REM Display login credentials
echo Username: mohammadali
echo Password: mmd@123
echo You can login now

REM Wait for 10 seconds to complete all operations
ping -n 10 127.0.0.1 >nul
