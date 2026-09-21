@echo off
setlocal
if not exist "%~dp0prototype\agora.html" (
  echo Prototipo nao encontrado. Extraia a pasta completa do projeto.
  pause
  exit /b 1
)
start "" "%~dp0prototype\agora.html"
