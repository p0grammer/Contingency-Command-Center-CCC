$games = @(
    "VALORANT-Win64-Shipping", 
    "SkyrimSE", 
    "Ableton Live 12 Suite",
    "ChatGPT",
    "WhatsApp",
    "steam",
    "EpicGamesLauncher",
    "Netflix",
    "AppleTV",
    "PrimeVideo"
)

foreach ($game in $games) {
    Stop-Process -Name $game -Force -ErrorAction SilentlyContinue
}

Write-Host "Specified high-load processes terminated." -ForegroundColor Green