<div align="center">❄️ MyNixOS

My personal modular NixOS configuration

""NixOS" (https://img.shields.io/badge/NixOS-26.05-5277C3?logo=nixos&logoColor=white)" (https://nixos.org/)
""KDE Plasma" (https://img.shields.io/badge/KDE-Plasma%206-1D99F3?logo=kde&logoColor=white)" (https://kde.org/plasma-desktop/)
""Home Manager" (https://img.shields.io/badge/Home%20Manager-enabled-7EBAE4)" (https://github.com/nix-community/home-manager)
""Flakes" (https://img.shields.io/badge/Nix-Flakes-5277C3?logo=nixos&logoColor=white)" (https://nixos.wiki/wiki/Flakes)
""Architecture" (https://img.shields.io/badge/arch-x86__64-lightgrey)"

</div>---

🖥️ System

Component| Configuration
OS| NixOS 26.05
Architecture| "x86_64-linux"
Desktop| KDE Plasma 6
Display Manager| SDDM
User config| Home Manager
Plasma config| Plasma Manager
Bootloader| systemd-boot
Network| NetworkManager
Audio| PipeWire
GPU| Intel UHD 730 + NVIDIA GTX 1060
Virtualization| QEMU/KVM + libvirt

Main Flake configuration:

nixosConfigurations.nixos

---

🎨 KDE Plasma

Plasma settings are separated from the system configuration:

home/popov/kde-preset/

Module| Purpose
"appearance.nix"| Breeze, colors and wallpaper
"theme.nix"| shared theme values
"panel.nix"| bottom panel
"shortcuts.nix"| keyboard shortcuts
"lockscreen.nix"| lock screen
"power.nix"| power and idle behavior
"file-icons.nix"| MIME and custom icons
"icons/"| custom SVG files

Appearance

Setting| Value
Look & Feel| Breeze
Color Scheme| Breeze Light
Icons| Breeze
Wallpaper| Scarlet Tree
Accent| 🟣 "#6D28D9"

Panel

Setting| Value
Position| Bottom
Length| Full width
Floating| Disabled
Visibility| Auto Hide
Launcher| KDE Kickoff
System Tray| Enabled
Clock| Enabled

Pinned applications include:

"Dolphin" · "Konsole" · "Firefox" · "VS Code" · "Discord" · "Steam" · "System Settings" · "Virt-Manager" · "KDE Connect" · "Android Studio" · "Heroic" · "AyuGram"

---

⌨️ Keyboard shortcuts

Shortcut| Action
"Meta"| 🚀 Application Launcher
"Meta + Enter"| 💻 Launch Konsole
"Meta + Q"| ❌ Close active window
"Meta + W"| 🪟 KDE Overview
"Meta + ,"| 🔎 Show open windows

---

❄️ Custom ".nix" icon

Nix files use their own MIME type and custom Breeze-style SVG icon.

*.nix
   │
   ▼
text/x-nix
   │
   ▼
text-x-nix.svg

This makes Nix files immediately distinguishable from normal text files in Dolphin.

---

🎮 Gaming

Component| Purpose
Steam| Main game client
GameMode| Runtime game optimizations
Heroic| Epic / GOG launcher
Legendary| Epic CLI
ProtonUp-Qt| Proton management
Gamescope| Gaming compositor
Lutris| Additional game launcher
MangoHud| Performance overlay

MangoHud

Two MangoHud profiles are configured.

Profile| Command| Purpose
🟢 Lite| "mangohud-lite"| Compact gaming HUD
🔵 Full| "mangohud-full"| Detailed diagnostics

Lite

Includes:

- FPS
- frametime
- GPU load / temperature / power
- VRAM
- CPU load / temperature / power
- RAM
- GameMode
- Present Mode

Full

Includes detailed:

- FPS metrics
- frametime
- GPU load
- clocks
- temperature
- power
- VRAM
- CPU stats
- per-core load
- RAM and swap
- process memory
- disk I/O
- Wine
- GameMode
- Present Mode
- Display Server
- Resolution
- graphics stack information

---

🖥️ Hardware

Component| Hardware
iGPU| Intel UHD 730
dGPU| NVIDIA GeForce GTX 1060
Driver| NVIDIA proprietary
Vulkan| Enabled
32-bit graphics| Enabled

NVIDIA configuration:

hosts/nixos/hardware/nvidia.nix

---

🖥️ Virtualization

Component| Enabled
KVM| ✅
QEMU| ✅
libvirt| ✅
Virt-Manager| ✅
Virt-Viewer| ✅
swtpm| ✅
SPICE| ✅
USB Redirection| ✅

Default connection:

qemu:///system

---

🛠️ Development

Category| Tools
C / C++| GCC, Make, CMake, GDB
Python| Python 3, pip, virtualenv
Android| Android Studio, ADB
JVM| JDK 17, Kotlin, Gradle
Editor| VS Code

📱 adb-qr

A local Nix package definition is included for the third-party project:

https://github.com/aleixrodriala/adb-qr

packages/adb-qr/

«"adb-qr" is not my project.»

The local derivation is used because the application is not available as a package in the Nixpkgs version used by this configuration.

---

⚡ Fastfetch

Fastfetch has a small custom configuration:

home/popov/fastfetch.nix

Its output is divided into three sections:

──────────── USER ─────────────
───────────── OS ──────────────
────────── HARDWARE ───────────

It includes:

- user
- GitHub profile
- OS
- kernel
- uptime
- package count
- desktop/session
- host
- monitors
- CPU
- GPU
- memory
- disks

Colors, separators and output formatting are customized as well.

---

🐚 Bash aliases

Alias| Action
"ll"| "ls -lah"
"sbtop"| run btop as root
"rebuild"| rebuild and switch
"nbuild"| build only
"ntest"| test configuration
"nupdate"| update Flake and rebuild
"nclean"| delete old Nix generations
"watchnvidia"| refresh "nvidia-smi" every second
"grep"| colored grep output

Also available:

rebuildVPN <server> <ip>

for remote VPN-server rebuilds over SSH.

---

📁 Repository structure

<details>
<summary><b>Show repository tree</b></summary><br>.
├── configuration.nix
├── flake.lock
├── flake.nix
├── home/
│   ├── default.nix
│   └── popov/
│       ├── development.nix
│       ├── fastfetch.nix
│       ├── gaming.nix
│       ├── git.nix
│       ├── kde-preset/
│       │   ├── appearance.nix
│       │   ├── default.nix
│       │   ├── file-icons.nix
│       │   ├── icons/
│       │   ├── lockscreen.nix
│       │   ├── panel.nix
│       │   ├── power.nix
│       │   ├── shortcuts.nix
│       │   └── theme.nix
│       ├── mangohud.nix
│       ├── monitors.nix
│       ├── packages.nix
│       └── shell.nix
├── hosts/
├── modules/
├── packages/
├── README.md
└── README.en.md

</details>Directory| Purpose
"hosts/"| machine-specific configuration
"modules/"| system-wide NixOS modules
"home/"| Home Manager user configuration
"packages/"| local Nix package definitions

---

🚀 Build

Action| Command
Build| "nbuild"
Test| "ntest"
Apply| "rebuild"
Update| "nupdate"
Clean| "nclean"

Direct NixOS command:

sudo nixos-rebuild switch --flake .#nixos

---

Git + Flakes

New files must be visible to Git:

git add path/to/file

Otherwise Nix may report:

Path '...' does not exist in Git repository

A commit is not required for a local build.

---

⚠️ Using this configuration on another machine

This configuration is hardware-specific.

Review at least:

File| Purpose
"hardware-configuration.nix"| hardware and filesystems
"hardware/nvidia.nix"| GPU configuration
"hardware/disks.nix"| disks
"hardware/bootloader.nix"| boot configuration
"users/default.nix"| user configuration
"locale.nix"| locale and timezone
"swap.nix"| swap / zram
"monitors.nix"| displays
"git.nix"| Git identity

The username and home directory also need to be changed:

popov
/home/popov
