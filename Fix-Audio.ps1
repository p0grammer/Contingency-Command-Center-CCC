Restart-Service -Name "Audiosrv" -Force
Restart-Service -Name "AudioEndpointBuilder" -Force
Write-Host "Windows Audio services restarted."