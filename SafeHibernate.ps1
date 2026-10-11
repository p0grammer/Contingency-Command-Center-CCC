# 1. Gracefully stop the Argus stack to close all database handles
Write-Host "Shielding databases... Stopping Project Argus."
wsl.exe -u root -d Ubuntu -e systemctl stop media-stack

# 2. Wait 3 seconds to ensure Docker containers have fully exited
Start-Sleep -s 3

# 3. Trigger Hibernation
Write-Host "All clear. Entering Hibernation."
shutdown /h