MyNixOS

My personal modular NixOS configuration for my main PC.

The repository is built around Nix Flakes, Home Manager, KDE Plasma 6, and Plasma Manager. System and user configuration is split into small logical modules.

GitHub: https://github.com/12615az-droid/MyNixOS

Main stack

- NixOS 26.05
- "x86_64-linux"
- Nix Flakes
- Home Manager 26.05
- Plasma Manager
- KDE Plasma 6
- SDDM
- systemd-boot
- NetworkManager
- PipeWire
- NVIDIA proprietary driver
- libvirt + QEMU/KVM

Main Flake configuration:

nixosConfigurations.nixos

KDE Plasma

The main desktop environment is KDE Plasma 6.

User-side Plasma configuration is managed declaratively with Plasma Manager:

home/popov/kde-preset/
├── appearance.nix
├── default.nix
├── file-icons.nix
├── icons/
│   └── text-x-nix.svg
├── lockscreen.nix
├── panel.nix
├── power.nix
├── shortcuts.nix
└── theme.nix

Appearance

The desktop uses a light Breeze setup:

- Breeze Look and Feel
- Breeze Light
- Breeze Icons
- "Scarlet Tree" wallpaper
- deep purple accent "#6D28D9"

Panel

The bottom Plasma panel is configured as a single full-width panel:

- bottom position;
- full screen width;
- no floating gap;
- automatic hiding;
- reveals when the pointer reaches the bottom edge;
- Kickoff launcher;
- pinned applications;
- system tray;
- clock.

Pinned applications include:

- Dolphin
- Konsole
- Firefox
- VS Code
- Discord
- Steam
- System Settings
- Virt-Manager
- KDE Connect
- Android Studio
- Heroic Games Launcher
- AyuGram

Keyboard shortcuts

The main shortcuts are centered around the Meta / Win key:

Shortcut| Action
"Meta"| open application launcher
"Meta + Enter"| launch Konsole
"Meta + Q"| close active window
"Meta + W"| KDE Overview
"Meta + ,"| show open windows

Custom ".nix" file icon

Nix files use a dedicated MIME type:

*.nix
  ↓
text/x-nix
  ↓
text-x-nix

A custom SVG icon is added to Breeze, combining the standard file design with the classic blue Nix logo.

This makes ".nix" files immediately distinguishable from regular text files in Dolphin.

SDDM

The SDDM login screen has its own system module:

modules/desktop/sddm.nix

SDDM is used together with Plasma and follows the same overall visual style as the desktop.

Hardware

Graphics

- Intel UHD 730
- NVIDIA GeForce GTX 1060
- proprietary NVIDIA driver
- NVIDIA modesetting
- 32-bit graphics libraries for Steam and Proton
- Vulkan

NVIDIA configuration:

hosts/nixos/hardware/nvidia.nix

Monitors

User monitor configuration:

home/popov/monitors.nix

Audio

PipeWire is used for audio:

- PipeWire
- ALSA
- PulseAudio compatibility
- RTKit
- 32-bit ALSA support
- "pavucontrol"
- "qpwgraph"
- "alsa-utils"

Bluetooth and printing

modules/desktop/bluetooth.nix
modules/desktop/printer.nix

Swap

Swap configuration:

modules/system/swap.nix

The setup uses:

- zram;
- "zstd" compression;
- a fallback swapfile.

Gaming

Gaming configuration is split between system and user modules.

System side

modules/programs/gaming.nix

- Steam
- GameMode
- Vulkan Tools
- Mesa Demos

User side

home/popov/gaming.nix
home/popov/mangohud.nix

- Heroic Games Launcher
- Legendary
- ProtonUp-Qt
- Gamescope
- Lutris
- MangoHud

MangoHud

MangoHud has two separate profiles.

Full

mangohud-full

The full profile is intended for detailed monitoring and diagnostics:

- FPS and frametime;
- FPS metrics;
- GPU load, temperature, clocks and power;
- VRAM;
- CPU load, temperature, clocks and power;
- per-core load;
- RAM and swap;
- process memory;
- disk I/O;
- Wine information;
- GameMode;
- present mode;
- display server;
- resolution;
- additional graphics stack information.

Lite

mangohud-lite

A compact profile for normal gameplay:

- FPS;
- frametime;
- GPU load;
- GPU temperature;
- GPU power;
- VRAM;
- CPU load;
- CPU temperature;
- CPU power;
- RAM;
- GameMode;
- present mode.

Virtualization

modules/virtualization/default.nix

The virtualization stack includes:

- KVM
- QEMU
- libvirt
- Virt-Manager
- Virt-Viewer
- swtpm
- SPICE
- USB redirection

Default libvirt connection:

qemu:///system

VM and ISO directories are created automatically, including:

~/VMs
~/VMs/images
/home/popov/Drives/HDD1/VMs
/home/popov/Drives/HDD1/VMs/iso

Development

System development tools:

modules/programs/base-dev.nix

User development environment:

home/popov/development.nix

The setup includes:

- GCC
- GNU Make
- CMake
- pkg-config
- GDB
- Python 3
- pip
- virtualenv
- VS Code
- Android Studio
- Android Platform Tools / ADB
- JDK 17
- Kotlin
- Gradle

adb-qr

The directory:

packages/adb-qr/

contains a local Nix package definition for the third-party project "adb-qr" (https://github.com/aleixrodriala/adb-qr).

"adb-qr" itself is not my project. The local derivation exists so the application can be installed through this configuration because it is not available as a package in the Nixpkgs version used here.

"adb-qr" provides QR-code based pairing for wireless Android Debug Bridge connections.

Applications

Some of the user applications included in the configuration:

- Firefox
- Dolphin
- Konsole
- Kate
- Spectacle
- LibreOffice
- VLC
- Strawberry
- Darktable
- Inkscape
- Discord
- AyuGram Desktop
- qBittorrent
- scrcpy
- btop
- htop
- nvtop
- iotop
- nethogs
- bandwhich
- fzf
- duf
- various system and networking utilities

Fastfetch

Fastfetch is slightly customized through Home Manager:

home/popov/fastfetch.nix

It uses the built-in NixOS logo and a custom layout divided into:

USER
OS
HARDWARE

The output includes information such as:

- user;
- GitHub profile;
- operating system;
- kernel;
- uptime;
- package count;
- desktop/session;
- host;
- monitors;
- CPU;
- GPU;
- memory;
- disks.

Custom colors, separators, and output formatting are also configured.

KDE Connect

KDE Connect is enabled system-wide and is used for Android integration with Plasma.

Bash

Bash configuration is located in:

home/popov/shell.nix
home/popov/function.nix

Aliases

Alias| Command / action
"ll"| "ls -lah"
"sbtop"| run "btop" with "sudo"
"rebuild"| apply the current "~/MyNixOS" configuration
"nbuild"| build the configuration without switching
"ntest"| temporarily activate the configuration for testing
"nupdate"| update Flake inputs and rebuild the system
"nclean"| remove old Nix generations and garbage
"watchnvidia"| refresh "nvidia-smi" every second
"grep"| enable automatic colored grep output

Common commands:

rebuild
nbuild
ntest
nupdate
nclean
watchnvidia

"rebuildVPN"

A Bash helper function is also defined:

rebuildVPN <server> <ip>

It performs a remote "nixos-rebuild" for a VPN server from a separate Flake configuration over SSH.

Repository structure

.
├── configuration.nix
├── flake.lock
├── flake.nix
│
├── home/
│   ├── default.nix
│   └── popov/
│       ├── adGuardVpn.nix
│       ├── baloo.nix
│       ├── btop.nix
│       ├── default.nix
│       ├── development.nix
│       ├── fastfetch.nix
│       ├── function.nix
│       ├── gaming.nix
│       ├── git.nix
│       ├── kde-preset/
│       │   ├── appearance.nix
│       │   ├── default.nix
│       │   ├── file-icons.nix
│       │   ├── icons/
│       │   │   └── text-x-nix.svg
│       │   ├── lockscreen.nix
│       │   ├── panel.nix
│       │   ├── power.nix
│       │   ├── shortcuts.nix
│       │   └── theme.nix
│       ├── mangohud.nix
│       ├── monitors.nix
│       ├── packages.nix
│       └── shell.nix
│
├── hosts/
│   └── nixos/
│       ├── default.nix
│       ├── hardware/
│       │   ├── bootloader.nix
│       │   ├── default.nix
│       │   ├── disks.nix
│       │   └── nvidia.nix
│       └── hardware-configuration.nix
│
├── modules/
│   ├── default.nix
│   ├── desktop/
│   │   ├── audio.nix
│   │   ├── bluetooth.nix
│   │   ├── default.nix
│   │   ├── graphics.nix
│   │   ├── kde.nix
│   │   ├── printer.nix
│   │   └── sddm.nix
│   ├── programs/
│   │   ├── base-dev.nix
│   │   ├── default.nix
│   │   ├── gaming.nix
│   │   ├── obs.nix
│   │   └── packages.nix
│   ├── system/
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── locale.nix
│   │   ├── network.nix
│   │   ├── nix-settings.nix
│   │   ├── ssh.nix
│   │   └── swap.nix
│   ├── users/
│   │   └── default.nix
│   └── virtualization/
│       └── default.nix
│
├── packages/
│   └── adb-qr/
│       └── default.nix
│
├── README.md
└── README.en.md

Configuration layout

"hosts/"

Machine-specific configuration:

hosts/nixos/

This includes hardware configuration, bootloader, disk, and NVIDIA settings.

"modules/"

Reusable system-level NixOS modules:

modules/
├── desktop/
├── programs/
├── system/
├── users/
└── virtualization/

"home/"

Home Manager user configuration:

home/popov/

This contains Plasma Manager, applications, shell configuration, Git, gaming configuration, Fastfetch, MangoHud, and the development environment.

Build and apply

Build:

sudo nixos-rebuild build --flake .#nixos

Temporarily test:

sudo nixos-rebuild test --flake .#nixos

Apply:

sudo nixos-rebuild switch --flake .#nixos

Or use the configured alias:

rebuild

Updating

nix flake update
sudo nixos-rebuild switch --flake .#nixos

Or simply:

nupdate

Git and Flakes

New files must be visible to Git before they can be included in a Flake build.

For example:

git add path/to/file

Otherwise Nix may report:

Path '...' does not exist in Git repository

A commit is not required for a local build; adding the file to the Git index is enough.

Using this configuration on another machine

This configuration is hardware-specific.

Before using it on another machine, at minimum review:

- "hosts/nixos/hardware-configuration.nix"
- "hosts/nixos/hardware/disks.nix"
- "hosts/nixos/hardware/nvidia.nix"
- "hosts/nixos/hardware/bootloader.nix"
- "modules/users/default.nix"
- "modules/system/locale.nix"
- "modules/system/swap.nix"
- "home/popov/default.nix"
- "home/popov/monitors.nix"
- "home/popov/git.nix"

The "popov" username, home directory, and hardware-specific settings will also need to be changed.
