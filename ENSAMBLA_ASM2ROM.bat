@echo off
setlocal

pushd "%~dp0"
"C:\Users\benja\Dropbox\BENJA\MSX\CARAMBALAN STUDIOS\DESARROLLO\CODIGO ASM DE RECURSO\sjasm.exe" -s NUCLEOBW2_1.asm
set "EXITCODE=%ERRORLEVEL%"
popd

if not "%EXITCODE%"=="0" (
    echo.
    echo Error al ensamblar NUCLEOBW2.asm
    pause
)

exit /b %EXITCODE%