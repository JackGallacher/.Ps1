@ECHO off
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /f 4.5

IF %errorlevel%==1 GOTO INSTALLNET45
IF %errorlevel%==0 GOTO WMFCHECK

:INSTALLNET45

\\fsnugget\psv4\installs\NDP452-KB2901907-x86-x64-AllOS-ENU.exe /q /norestart

:WMFCHECK

REG QUERY "HKLM\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine" /f 4.0

IF %errorlevel%==1 GOTO INSTALLWMF
IF %errorlevel%==0 GOTO EXIT

:INSTALLWMF

If /I "%processor_architecture%"=="x86" (GOTO 32bit) Else (GOTO 64bit)

:64bit
Start /wait wusa.exe "\\fsnugget\installs$\Windows6.1-KB2819745-x64-MultiPkg.msu" /quiet /norestart
Exit

:32bit
Start /wait wusa.exe "\\fsnugget\installs$\Windows6.1-KB2819745-x86-MultiPkg.msu" /quiet /norestart
Exit

:EXIT
Exit