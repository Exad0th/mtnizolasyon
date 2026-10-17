@echo off
title MTN Izolasyon - .htaccess duzeltmesi
cd /d "%~dp0"
echo.
echo   [1/3] Batch calisti. Klasor: %CD%
if not exist "%~dp0htaccess-yukle.ps1" (
  echo   HATA: htaccess-yukle.ps1 bu klasorde yok.
  goto son
)
echo   [2/3] Betik bulundu.
echo   [3/3] Baslatiliyor...
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0htaccess-yukle.ps1"
echo.
echo   PowerShell cikis kodu: %ERRORLEVEL%
:son
echo.
echo   --- Bir tusa basin ---
pause >nul
