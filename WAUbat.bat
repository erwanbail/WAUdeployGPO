@echo off
set "cheminReg=HKLM\SOFTWARE\Romanitho\Winget-AutoUpdate"

timeout /t 5 -nobreak >nul

set "logPath=\\yourpublicdataserver\path\path\path\WAUlog.txt"

set "CurrentDir=%~dp0"

timeout /t 5 -nobreak >nul

PowerShell.exe -Command "& {if (Test-Path 'Registry::%cheminReg%') {exit 0} else { exit 1}}"
if %errorlevel%==0 (

	>> C:\Temp\alrdyinstld.txt echo WAU deja installe, abandon 
	timeout /t 10 -nobreak >nul 
	exit

	) else (
		>> C:\Temp\notinstld.txt echo WAU n'est pas installe
		
	PowerShell.exe -Command "& { Start-Process PowerShell.exe -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', '%CurrentDir%WAUshell.ps1' -Verb RunAs }"
		)