Stop-Process -Name explorer -Force
Start-Sleep -Seconds 1
Start-Process explorer
Write-Host "Windows Explorer UI restarted."