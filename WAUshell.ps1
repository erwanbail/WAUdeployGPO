$currentDir = Split-Path  -Parent -Path $MyInvocation.MyCommand.Definition
$nomInstall = Join-Path -Path $currentDir -ChildPath "WAU.msi"
$cheminReg1 = "HKLM\SOFTWARE\Romanitho\Winget-AutoUpdate"

$computerName = $env:COMPUTERNAME

$date = Get-Date -Format "yyyy-MM-dd"
$timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logFileName = "${date}_${computerName}_InstallLogWAU.txt"

$logDirectory ="\\SRV-DATA\LOG_DEPLOY_WAU"
$logPath = Join-Path -Path $logDirectory -ChildPath $logFileName

Start-Sleep -Seconds 2
 
Add-Content -Path $logPath -Value "$timeStamp  - $computerName  : Début d'Exécution du script d'installation de WAU "

$env = $env:USERDNSDOMAIN

     Add-Content -Path $logPath -Value "$timeStamp  - $computerName  : Exécution dans un environnement $env "


$user = $env:USERNAME 

     Add-Content -Path $logPath -Value "$timeStamp  - $computerName  : Exécution avec le compte $user "


function Test-WingetPresence {
    $basePath = "C:\Program Files\WindowsApps"
    try {
        $wingetExe = Get-ChildItem -Path "$basePath\Microsoft.DesktopAppInstaller_*" -Recurse -Filter winget.exe -ErrorAction Stop | Select-Object -First 1
        if ($wingetExe -and (Test-Path $wingetExe.FullName)) {
            Write-Host "winget détecté : $($wingetExe.FullName)"
            return $true
        } else {
            Write-Host "winget non trouvé dans WindowsApps"
            return $false
        }
    } catch {
        Write-Warning "Accès refusé à WindowsApps ou erreur : $_"
        return $false
    }
}


if (Test-Path -Path $cheminReg1) {

	Write-Host "WAU est déjà installé dans cet Ordinateur"

	Write-Host "!!! Abandon du processus d'installation !!!"
    	Add-Content -Path $logPath -Value "$timeStamp  - $computerName - $userName : WAU déja installé, abandon de la procédure d'installation "
        exit 0

            } elseif (-not (Test-WingetPresence)) {
        
                 Write-Host "winget non présent. Abandon du process."
                 Add-Content -Path $logPath -Value "$timeStamp - $computerName : winget introuvable, installation annulée."
                 exit 1
                }
                else{

                Add-Content -Path $logPath -Value "$timeStamp  - $computerName : WAU a correctement été Installé. "
                Start-Process -FilePath $nomInstall -ArgumentList "/qn USERCONTEXT=1 NOTIFICATIONLEVEL=None UPDATESATTIME=13:00:00 UPDATESINTERVAL=Daily BYPASSLISTFORUSERS=1 UPDATESATLOGON=0"
                
}