@echo off
echo Deleting unnecessary shortcuts...
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
echo Configuring system properties...
net config server /srvcomment:"Windows Server 2019 By mohammadali" > out.txt 2>&1
echo Setting system registry...
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d D:\a\wallpaper.bat > out.txt 2>&1
echo Adding user...
net user mohammadali mmd@123 /add >nul
net localgroup administrators mohammadali /add >nul
net user mohammadali /active:yes >nul
echo Removing installer user...
net user installer /delete
echo Configuring performance and services...
diskperf -Y >nul
sc config Audiosrv start= auto >nul
sc start Audiosrv >nul
echo Setting permissions...
ICACLS C:\Windows\Temp /grant mohammadali:F >nul
ICACLS C:\Windows\installer /grant mohammadali:F >nul
echo Checking NGROK status and retrieving IP...
tasklist | find /i "ngrok.exe" >Nul && curl -s http://localhost:4040/api/tunnels | jq -r .tunnels[0].public_url > ip.txt || echo "Failed to retrieve NGROK authtoken - check again your authtoken"
echo IP Address:
type ip.txt
echo Username: mohammadali
echo Password: mmd@123
echo You can login now
echo Waiting for all services to start...
ping -n 10 127.0.0.1 >nul
