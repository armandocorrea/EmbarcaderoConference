@echo off
setlocal

set LOCAL_BUILD_PATH=bin\ECon24.exe
set DESTINATION_PATH=C:\release

if not exist "%DESTINATION_PATH%" (
    mkdir "%DESTINATION_PATH%"
)

xcopy /Y "%LOCAL_BUILD_PATH%" "%DESTINATION_PATH%\"

if %errorlevel% neq 0 (
    echo "Falha ao copiar o arquivo."
    exit /b %errorlevel%
)

echo "Arquivo transferido com sucesso para %DESTINATION_PATH%."

endlocal
exit /b 0