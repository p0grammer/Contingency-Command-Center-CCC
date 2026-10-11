# Contingency Command Center: Remote SSH Scripts

This guide provides a breakdown of the 10 emergency PowerShell scripts designed to be executed via SSH from your tablet to manage your system when the display or UI is unresponsive.

## 1. Fix-Audio.ps1 (Audio Engine Hard Reset)
* **What it does:** Force-restarts the "Audiosrv" and "AudioEndpointBuilder" Windows services.
* **When to use it:** Use this when your audio interface stops making sound, or if Ableton/ASIO drivers lock up and stop responding.
* **Tablet Command:** `C:\AdminScripts\Fix-Audio.ps1`.

## 2. Kill-Game.ps1 (Fullscreen App Kill-Switch)
* **What it does:** Searches for and instantly terminates processes named **VALORANT**, **Skyrim**, or **Ableton**.
* **When to use it:** Use this when a game freezes and hijacks your screen, preventing access to the desktop or Task Manager.
* **Tablet Command:** `C:\AdminScripts\Kill-Game.ps1`.

## 3. Fix-Display.ps1 (Display Handshake Reset)
* **What it does:** Cycles Windows "Project" modes between Clone and Extend to force a new GPU-to-monitor handshake.
* **When to use it:** Use this if your monitor goes black or shows "No Signal" while the PC is still running.
* **Tablet Command:** `C:\AdminScripts\Fix-Display.ps1`.

## 4. Fix-Network.ps1 (Network Adapter Reboot)
* **What it does:** Identifies the active internet adapter, disables it for 3 seconds, and re-enables it.
* **When to use it:** Use it if a large file transfer crashes your network card or if the internet connection drops.
* **Tablet Command:** `C:\AdminScripts\Fix-Network.ps1`.

## 5. Flush-RAM.ps1 (Memory Cache Clear)
* **What it does:** Triggers the `EmptyStandbyList.exe` tool to clear the "standby" portion of your system RAM.
* **When to use it:** Use this if your PC feels sluggish or stuttery after closing heavy creative software.
* **Tablet Command:** `C:\AdminScripts\Flush-RAM.ps1`.

## 6. Fix-GPU.ps1 (NVIDIA Service Restart)
* **What it does:** Stops and restarts the background "NVIDIA Container" service.
* **When to use it:** Use this for localized stuttering or if the NVIDIA Control Panel stops responding.
* **Tablet Command:** `C:\AdminScripts\Fix-GPU.ps1`.

## 7. Boot-SafeMode.ps1 (Emergency Safe Mode)
* **What it does:** Changes boot settings to load only bare minimum drivers on the next startup and forces a reboot