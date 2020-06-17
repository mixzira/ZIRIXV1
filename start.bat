@echo off

echo ===-------------------------------===
echo     vRPex Zirix 1.4
echo     Developed by: Ziraflix
echo     Discord: discord.gg/6p3M3Cz
echo     Contato: contato@ziraflix.com   
echo ===-------------------------------===

pause
start ..\build\FXServer.exe +exec zirix.cfg +set onesync_enableInfinity 1
exit