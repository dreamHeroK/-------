@echo off
chcp 936 >nul
setlocal
set "PROJECT_PATH=%~dp0"
set "PROJECT_PATH=%PROJECT_PATH:~0,-1%"

"%~dp0..\gge\Build\GGEBuild.exe" ggeserver "%PROJECT_PATH%"

if not exist "%~dp0compile\ggeserver.exe" (
    echo.
    echo [SKIP] compile\ggeserver.exe not found, build may have failed.
    goto :end
)

echo.
echo ==================== Replace ggeserver.exe ====================
taskkill /IM ggeserver.exe /F >nul 2>&1

set RETRY=0
:copy_retry
copy /y "%~dp0compile\ggeserver.exe" "%~dp0ggeserver.exe" >nul 2>&1
if not errorlevel 1 (
    echo [OK] ggeserver.exe replaced.
    goto :end
)
set /a RETRY+=1
if %RETRY% GEQ 5 (
    echo [FAIL] Could not replace ggeserver.exe after %RETRY% retries, check if it is locked.
    goto :end
)
ping -n 2 127.0.0.1 >nul
goto :copy_retry

:end
echo.
pause
