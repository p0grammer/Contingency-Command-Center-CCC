Start-Process "DisplaySwitch.exe" -ArgumentList "/clone" -Wait
Start-Process "DisplaySwitch.exe" -ArgumentList "/extend"
Write-Host "Display handshake refreshed."