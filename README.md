# Contingency Command Center

A lightweight system recovery utility for Windows power users, audio engineers, and gamers. When a critical sub-system hangs mid-session — audio driver freeze, GPU hiccup, runaway process — CCC Lite gives you a single "Panic Button" to resolve it without rebooting.

## What it does

- Detects hung sub-systems (audio, display, background processes)
- One-click recovery routines — no digging through Task Manager or Device Manager
- Built for people who can't afford a reboot: live audio sessions, ranked matches, render jobs

## Requirements

- Windows 10/11
- PowerShell 5.1+ (run as Administrator for full functionality)

## Usage

```powershell
.\CCC.ps1
```

alt: extract CCC(full-package) run the CCC.exe

Follow the on-screen prompts. The Panic Button routine handles the most common hangs automatically; advanced options are available for manual targeting.

## Tech

- PowerShell — no dependencies, no installer, runs anywhere Windows does

## Status

Active development. Bug reports and feature requests welcome via Issues.

---

Built by [Arkajeet Mukherjee](https://arkajeetm.vercel.app/) — systems & software developer, audio engineer.
