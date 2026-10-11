$timeout = 60 # Seconds to wait for your input
$title = "Project Argus: Scheduled Power Down"
$message = "System shutdown scheduled in t- 60 seconds. Would you like to cancel and keep working?"

$sh = New-Object -ComObject WScript.Shell
$response = $sh.Popup($message, $timeout, $title, 4 + 32)

# Response codes: 6 = Yes, 7 = No (Cancel), -1 = Timeout
if ($response -eq 7) {
    Write-Host "Shutdown aborted by user."
    exit
} else {
    Write-Host "Shielding Project Argus... Stopping services to protect HDDs."
    
    # 1. STOP THE STACK FIRST
    # This closes all database handles in Prowlarr/Sonarr/Radarr safely
    wsl.exe -u root -d Ubuntu -e systemctl stop media-stack
    
    # 2. Briefly wait to ensure the disks are no longer being written to
    Start-Sleep -s 3
    
    Write-Host "Proceeding to Power Down (State Saved)."
    # 3. Hibernate
    shutdown /h
}