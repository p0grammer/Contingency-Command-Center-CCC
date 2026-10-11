# =========================================================
# Project Argus: Bifrost Bridge (WSL2 PortProxy)
# Location: C:\AdminScripts\fix-wsl-proxy.ps1
# =========================================================

$wsl_ip = (wsl -d Ubuntu hostname -I).Trim().Split(" ")[0]

if (-not $wsl_ip) {
    Write-Host "[!] BIFROST ERROR: Could not find the path to the Other Realm (WSL IP)." -ForegroundColor Red
    exit
}

Write-Host "[+] BIFROST: Rainbow Bridge established to $wsl_ip" -ForegroundColor Cyan

$ports = @(8096, 8989, 7878, 9696, 8080, 8191)

Write-Host "[+] BIFROST: Opening the gates for Tailscale traffic..." -ForegroundColor Yellow
foreach ($port in $ports) {
    netsh interface portproxy delete v4tov4 listenport=$port listenaddress=0.0.0.0 | Out-Null
    netsh interface portproxy add v4tov4 listenport=$port listenaddress=0.0.0.0 connectport=$port connectaddress=$wsl_ip | Out-Null
    Write-Host "    -> Port $port is now open across the bridge." -ForegroundColor Gray
}

# Verifying Firewall (The Heimdall Check)
foreach ($port in $ports) {
    $ruleName = "Bifrost_Port_$port"
    if (-not (Get-NetFirewallRule -Name $ruleName -ErrorAction SilentlyContinue)) {
        New-NetSecurityRule -Name $ruleName -DisplayName "Bifrost Bridge: Port $port" -Direction Inbound -LocalPort $port -Protocol TCP -Action Allow | Out-Null
    }
}

Write-Host "[!] BIFROST: The bridge is stable. The realms are connected." -ForegroundColor Green