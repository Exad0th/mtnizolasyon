@echo off
title MTN Izolasyon - FTP Yukleme
cd /d "%~dp0"
echo.
echo   ================================================
echo    MTN Izolasyon - FTP Yukleme
echo   ================================================
echo.
echo   [1/5] Batch dosyasi calisti.
echo   [2/5] Bulunulan klasor: %CD%
echo.

if not exist "%~dp0ftp-yukle.ps1" (
  echo   HATA: ftp-yukle.ps1 bu klasorde YOK.
  echo   Iki dosya da ayni klasorde olmali.
  goto son
)
echo   [3/5] ftp-yukle.ps1 bulundu.

where powershell.exe >nul 2>&1
if errorlevel 1 (
  echo   HATA: powershell.exe bulunamadi.
  echo   Windows PowerShell kurulu degil ya da PATH disinda.
  goto son
)
echo   [4/5] PowerShell bulundu.
echo.
echo   [5/5] Betik baslatiliyor...
echo   ------------------------------------------------
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0ftp-yukle.ps1"
set KOD=%ERRORLEVEL%

echo.
echo   ------------------------------------------------
echo   PowerShell cikis kodu: %KOD%
if not "%KOD%"=="0" (
  echo.
  echo   Sifirdan farkli cikis kodu = betik hata verdi.
  echo   Ayrinti icin: %~dp0ftp-log.txt
)

:son
echo.
echo   ================================================
echo    Bu pencere kapanmayacak. Okuduktan sonra
echo    bir tusa basin.
echo   ================================================
pause >nul
