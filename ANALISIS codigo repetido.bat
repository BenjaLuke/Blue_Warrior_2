@echo off
setlocal

rem ============================================================
rem ESTADO DE ROM - BLUE WARRIOR 2
rem Lanza roman.py sobre BW2.rom, que debe estar en esta misma carpeta.
rem ============================================================

set "ROMAN_PY=C:\Users\benja\Dropbox\BENJA\MSX\CARAMBALAN STUDIOS\HERRAMIENTAS\CONTROL SOBRE BYTES DE LA ROM\roman.py"
set "ROM_FILE=%~dp0BW2.rom"

if not exist "%ROMAN_PY%" (
    echo ERROR: No se encuentra roman.py en:
    echo "%ROMAN_PY%"
    echo.
    pause
    exit /b 1
)

if not exist "%ROM_FILE%" (
    echo ERROR: No se encuentra BW2.rom en la carpeta del BAT:
    echo "%~dp0"
    echo.
    pause
    exit /b 1
)

echo Analizando ROM:
echo "%ROM_FILE%"
echo.

python "%ROMAN_PY%" -r 30 -g -p "%ROM_FILE%"

set "ERRORLEVEL_ROMAN=%ERRORLEVEL%"
echo.

if not "%ERRORLEVEL_ROMAN%"=="0" (
    echo El analisis ha terminado con errores. Codigo: %ERRORLEVEL_ROMAN%
) else (
    echo Analisis terminado correctamente.
)

echo.
pause
exit /b %ERRORLEVEL_ROMAN%
