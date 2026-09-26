@echo off
rem ============================================================
rem  LRC Library - Loan & Inventory Management (single HTML file)
rem  Opens LRC_System_F.html in Google Chrome or Microsoft Edge.
rem  No installation, no server, no internet needed.
rem ============================================================
setlocal
set "HTML=%~dp0LRC_System_F.html"
if not exist "%HTML%" (
  echo LRC_System_F.html was not found next to this file.
  pause
  exit /b 1
)
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
  start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "%HTML%"
  exit /b 0
)
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
  start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" "%HTML%"
  exit /b 0
)
if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" (
  start "" "%LocalAppData%\Google\Chrome\Application\chrome.exe" "%HTML%"
  exit /b 0
)
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
  start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" "%HTML%"
  exit /b 0
)
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
  start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" "%HTML%"
  exit /b 0
)
start "" "%HTML%"
