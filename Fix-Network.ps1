$adapter = Get-NetAdapter | Where-Object Status -eq "Up" | Select-Object -First 1
Disable-NetAdapter -Name $adapter.Name -Confirm:$false
Start-Sleep -Seconds 3
Enable-NetAdapter -Name $adapter.Name -Confirm:$false
Write-Host "Network adapter reset complete."