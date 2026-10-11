Stop-Service "NVDisplay.ContainerLocalSystem" -Force
Start-Sleep -Seconds 2
Start-Service "NVDisplay.ContainerLocalSystem"
Write-Host "NVIDIA Container restarted."