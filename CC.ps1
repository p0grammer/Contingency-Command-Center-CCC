# ==========================================
# SELF-ELEVATION CHECK (The Sheriff's Badge)
# ==========================================
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Hold your horses! This script needs Administrator rights. Requesting elevation..."
    Start-Sleep -Seconds 2
    Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

do {
    cls
    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host "       CONTINGENCY COMMAND CENTER (CCC)       " -ForegroundColor White -BackgroundColor Blue
    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host "1.  Reset Audio Services"
    Write-Host "2.  Dynamic App Sweep (Whitelist Mode)"
    Write-Host "3.  Reset Display Handshake"
    Write-Host "4.  Reboot Network Adapter"
    Write-Host "5.  Flush Standby RAM"
    Write-Host "6.  Restart NVIDIA Services"
    Write-Host "7.  Desktop (Explorer) UI Restart"
    Write-Host "----------------------------------------------"
    Write-Host "8.  Toggle VDD (Virtual Display) ON"
    Write-Host "9.  Toggle VDD (Virtual Display) OFF"
    Write-Host "----------------------------------------------"
    Write-Host "Q.  Quit Utility"
    Write-Host "=============================================="
    
    $choice = Read-Host "Select an option (1-9 or Q)"

    switch ($choice) {
        '1' { 
            Write-Host "Restarting Audio Services..." -ForegroundColor Yellow
            Restart-Service -Name "Audiosrv" -Force
            Restart-Service -Name "AudioEndpointBuilder" -Force
            Write-Host "Windows Audio services restarted." -ForegroundColor Green
        }
        '2' { 
            Write-Host "Scanning for active user applications..." -ForegroundColor Yellow
            
            # THE WHITELIST: Add any specific tools you DO NOT want to close here.
            # Use the process name (without .exe)
            $safelist = @(
                "explorer",
                "Taskmgr",
                "powershell",
                "pwsh",
                "WindowsTerminal",
                "tailscale",
                "tailscaled",
                "sunshine",
                "MSIAfterburner",
                "RTSS",
                "sshd" # Important: Protects your SSH connection!
            )

            # Find all processes that have a visible window AND are not on the safelist
            $targets = Get-Process | Where-Object { 
                $_.MainWindowTitle -ne "" -and 
                $_.Name -notin $safelist 
            }

            if ($targets) {
                foreach ($target in $targets) {
                    Write-Host "Terminating: $($target.Name)" -ForegroundColor DarkGray
                    Stop-Process -Id $target.Id -Force -ErrorAction SilentlyContinue
                }
                Write-Host "Dynamic cleanup complete." -ForegroundColor Green
            } else {
                Write-Host "No removable applications found." -ForegroundColor Green
            }
        }
        '3' { 
            Write-Host "Resetting Display Handshake..." -ForegroundColor Yellow
            Start-Process "DisplaySwitch.exe" -ArgumentList "/clone" -Wait
            Start-Process "DisplaySwitch.exe" -ArgumentList "/extend"
            Write-Host "Display handshake refreshed." -ForegroundColor Green
        }
        '4' { 
            Write-Host "Rebooting Network Adapter..." -ForegroundColor Yellow
            $adapter = Get-NetAdapter | Where-Object Status -eq "Up" | Select-Object -First 1
            Disable-NetAdapter -Name $adapter.Name -Confirm:$false
            Start-Sleep -Seconds 3
            Enable-NetAdapter -Name $adapter.Name -Confirm:$false
            Write-Host "Network adapter reset complete." -ForegroundColor Green
        }
        '5' { 
            Write-Host "Flushing RAM..." -ForegroundColor Yellow
            & "C:\AdminScripts\EmptyStandbyList.exe" standbylist
            Write-Host "Standby memory flushed." -ForegroundColor Green
        }
        '6' { 
            Write-Host "Restarting NVIDIA Services..." -ForegroundColor Yellow
            Stop-Service "NVDisplay.ContainerLocalSystem" -Force
            Start-Sleep -Seconds 2
            Start-Service "NVDisplay.ContainerLocalSystem"
            Write-Host "NVIDIA Container restarted." -ForegroundColor Green
        }
        '7' { 
            Write-Host "Restarting Explorer..." -ForegroundColor Yellow
            Stop-Process -Name explorer -Force
            Write-Host "Explorer UI restarted." -ForegroundColor Green
        }
        '8' { 
            Write-Host "Enabling Virtual Display..." -ForegroundColor Yellow
            Get-PnpDevice | Where-Object { $_.FriendlyName -like "*Virtual Display*" } | Enable-PnpDevice -Confirm:$false
            Write-Host "Virtual Display is now ON." -ForegroundColor Green
        }
        '9' { 
            Write-Host "Disabling Virtual Display..." -ForegroundColor Yellow
            Get-PnpDevice | Where-Object { $_.FriendlyName -like "*Virtual Display*" } | Disable-PnpDevice -Confirm:$false
            Write-Host "Virtual Display is now OFF." -ForegroundColor Green
        }
        'q' { Write-Host "Exiting..."; break }
        default { Write-Host "Invalid selection. Try again." -ForegroundColor Red; Start-Sleep -Seconds 1 }
    }
    
    if ($choice -ne 'q') {
        Write-Host "`nTask Complete. Press any key to return to menu..." -ForegroundColor Gray
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }

} until ($choice -eq 'q')