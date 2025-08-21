@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

title BatPortScanner - Windows Port Scanner by Voltsparx

:: ANSI escape codes for colors
set "ESC="
set "RED=[91m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "BLUE=[94m"
set "MAGENTA=[95m"
set "CYAN=[96m"
set "WHITE=[97m"
set "BOLD=[1m"
set "RESET=[0m"

:: Display banner
echo %ESC%[36m╔══════════════════════════════════════════════════════════╗
echo %ESC%[36m║%ESC%[1;95m                BatPortScanner by Voltsparx%ESC%[0;36m              ║
echo %ESC%[36m║%ESC%[93m             Contact: voltsparx@gmail.com%ESC%[0;36m             ║
echo %ESC%[36m╚══════════════════════════════════════════════════════════╝
echo.

:: Check if target is provided
if "%~1"=="" (
    echo %RED%[ERROR]%RESET% No target specified
    echo.
    echo %YELLOW%Usage:%RESET% %~n0 target [start_port] [end_port]
    echo %YELLOW%Example:%RESET% %~n0 192.168.1.1 1 100
    echo %YELLOW%Example:%RESET% %~n0 example.com 80 443
    echo.
    goto :end
)

set TARGET=%~1
set START_PORT=%~2
set END_PORT=%~3

:: Set default ports if not specified
if "!START_PORT!"=="" set START_PORT=1
if "!END_PORT!"=="" set END_PORT=1024

:: Validate ports
if !START_PORT! lss 1 set START_PORT=1
if !END_PORT! gtr 65535 set END_PORT=65535
if !START_PORT! gtr !END_PORT! (
    echo %RED%[ERROR]%RESET% Start port cannot be greater than end port
    goto :end
)

echo %BLUE%[INFO]%RESET% Target: %CYAN%!TARGET!%RESET%
echo %BLUE%[INFO]%RESET% Port Range: %YELLOW%!START_PORT!%RESET% - %YELLOW%!END_PORT!%RESET%
echo %BLUE%[INFO]%RESET% Start Time: %WHITE%!date! !time!%RESET%
echo %CYAN%──────────────────────────────────────────────────────%RESET%
echo.

set /a TOTAL_PORTS=!END_PORT! - !START_PORT! + 1
set /a SCANNED=0
set /a OPEN_PORTS=0

echo %GREEN%🚀 Scanning ports...%RESET%
echo.

:: Protocol definitions
set "PORTS_21=FTP"
set "PORTS_22=SSH"
set "PORTS_23=Telnet"
set "PORTS_25=SMTP"
set "PORTS_53=DNS"
set "PORTS_80=HTTP"
set "PORTS_110=POP3"
set "PORTS_143=IMAP"
set "PORTS_443=HTTPS"
set "PORTS_465=SMTPS"
set "PORTS_587=SMTP-SUB"
set "PORTS_993=IMAPS"
set "PORTS_995=POP3S"
set "PORTS_1433=MSSQL"
set "PORTS_1521=Oracle"
set "PORTS_3306=MySQL"
set "PORTS_3389=RDP"
set "PORTS_5432=PostgreSQL"
set "PORTS_5900=VNC"

:: Main scanning loop
for /L %%P in (!START_PORT!, 1, !END_PORT!) do (
    set /a SCANNED+=1
    set PORT=%%P
    
    :: Progress indicator every 50 ports
    set /a "MOD=!SCANNED! %% 50"
    if !MOD! equ 0 (
        set /a "PERCENT=(!SCANNED! * 100) / !TOTAL_PORTS!"
        echo %BLUE%[PROGRESS]%RESET% !PERCENT!% (!SCANNED!/!TOTAL_PORTS! ports)
    )
    
    :: Try to connect to port
    powershell -Command "$tcp = New-Object Net.Sockets.TcpClient; $result = $tcp.BeginConnect('%TARGET%', !PORT!, $null, $null); $success = $result.AsyncWaitHandle.WaitOne(500, $false); if ($success) { $tcp.EndConnect($result); $tcp.Close(); exit 0 } else { exit 1 }" >nul 2>&1
    
    if !errorlevel! equ 0 (
        set /a OPEN_PORTS+=1
        set "PROTOCOL=Unknown"
        
        :: Check if we have protocol info for this port
        if defined PORTS_!PORT! (
            set "PROTOCOL=!PORTS_%%P!"
        )
        
        :: Color coding based on protocol type
        if "!PROTOCOL!"=="HTTP" set COLOR=%GREEN%
        if "!PROTOCOL!"=="HTTPS" set COLOR=%GREEN%%BOLD%
        if "!PROTOCOL!"=="FTP" set COLOR=%YELLOW%
        if "!PROTOCOL!"=="SSH" set COLOR=%MAGENTA%
        if "!PROTOCOL!"=="SMTP" set COLOR=%CYAN%
        if "!PROTOCOL!"=="DNS" set COLOR=%BLUE%
        if "!PROTOCOL!"=="RDP" set COLOR=%RED%
        if "!PROTOCOL!"=="VNC" set COLOR=%RED%
        if "!PROTOCOL!"=="MySQL" set COLOR=%MAGENTA%
        if "!PROTOCOL!"=="Unknown" set COLOR=%WHITE%
        
        echo %GREEN%✅ [OPEN]%RESET% Port %YELLOW%!PORT!%RESET% - !COLOR!!PROTOCOL!%RESET%
    )
)

:: Display results
echo.
echo %CYAN%══════════════════════════════════════════════════════════%RESET%
echo %BOLD%%MAGENTA%           SCAN RESULTS SUMMARY%RESET%
echo %CYAN%══════════════════════════════════════════════════════════%RESET%
echo.
echo %BLUE%⏱️  Duration:%RESET%   %YELLOW%Completed%RESET%
echo %BLUE%📊 Total Ports:%RESET% %CYAN%!TOTAL_PORTS!%RESET%
echo %BLUE%✅ Open Ports:%RESET%   %GREEN%!OPEN_PORTS!%RESET%
echo.
echo %BLUE%⏰ End Time:%RESET% %WHITE%!date! !time!%RESET%
echo %CYAN%══════════════════════════════════════════════════════════%RESET%

:: Legal disclaimer
echo.
echo %YELLOW%⚠️  LEGAL DISCLAIMER:%RESET%
echo %WHITE%This tool is for educational purposes only. Always obtain proper%RESET%
echo %WHITE%permission before scanning any network or system.%RESET%

:end
echo.
pause
exit /b 0