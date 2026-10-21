<div align="center">

# ❄️ MyNixOS

**A personal, modular NixOS configuration for a primary desktop PC**

[Русская версия](README.md)

[![NixOS](https://img.shields.io/badge/NixOS-26.05-5277C3?logo=nixos&logoColor=white)](https://nixos.org/)
[![KDE Plasma](https://img.shields.io/badge/KDE-Plasma%206-1D99F3?logo=kde&logoColor=white)](https://kde.org/plasma-desktop/)
[![Home Manager](https://img.shields.io/badge/Home%20Manager-enabled-7EBAE4)](https://github.com/nix-community/home-manager)
[![Flakes](https://img.shields.io/badge/Nix-Flakes-5277C3?logo=nixos&logoColor=white)](https://wiki.nixos.org/wiki/Flakes)
![Architecture](https://img.shields.io/badge/arch-x86__64--linux-lightgrey)

</div>

> [!IMPORTANT]
> This config describes one specific computer; it is not a universal installer. Replace disk UUIDs, the user name, home directory, SSH key, and hardware-specific options before deploying it elsewhere.

## Overview

The flake defines one host, `nixos`, and combines NixOS system modules, a Home Manager user profile, and Plasma Manager desktop settings.

| Component | Configuration |
| --- | --- |
| Release branch | NixOS / Home Manager `26.05` |
| Architecture | `x86_64-linux` |
| Host | `nixos` |
| User | `popov` (UID 1000) |
| Desktop | KDE Plasma 6, SDDM |
| Graphics | AMDGPU, Mesa, Vulkan, and 32-bit graphics support |
| Networking | NetworkManager, Tailscale |
| Audio | PipeWire with ALSA/PulseAudio compatibility |
| Boot | UEFI, systemd-boot, Plymouth |
| Storage | Btrfs for `/`, `/home`, and `/nix`; separate ext4 HDD |
| Virtualization | KVM/QEMU, libvirt, virt-manager, SPICE, swtpm, virtiofsd |
| Android | Waydroid with nftables |
| Gaming | Steam, GameMode, Gamescope, Lutris, Heroic, MangoHud |

The main flake output is:

```text
nixosConfigurations.nixos
```

Import flow:

```text
flake.nix
└── configuration.nix
    ├── hosts/nixos       # host and machine-specific hardware
    ├── modules           # reusable system features
    └── home              # Home Manager profile for popov
```

## Repository layout

```text
.
├── flake.nix                         # inputs and nixosConfigurations.nixos
├── flake.lock                        # pinned dependency revisions
├── configuration.nix                 # common entry point and stateVersion
├── hosts/nixos/
│   ├── default.nix                   # hostname and hardware/ import
│   ├── hardware-configuration.nix    # filesystems, boot modules, platform
│   └── hardware/                     # AMDGPU, bootloader, HDD, OpenRGB, sensors
├── modules/
│   ├── system/                       # boot, locale, Nix, network, SSH, swap
│   ├── desktop/                      # Plasma, SDDM, PipeWire, Bluetooth, printing
│   ├── programs/                     # development, Steam, OBS, system packages
│   ├── users/                        # popov account and authorized SSH key
│   └── virtualization/               # libvirt/QEMU and Waydroid
├── home/popov/
│   ├── default.nix                   # user module imports
│   ├── kde-preset/                   # Plasma Manager and Dolphin integration
│   ├── wallpaper/                    # wallpaper collection
│   └── *.nix                         # apps, shell, Git, monitoring, and more
└── packages/adb-qr/default.nix       # local adb-qr derivation
```

## System configuration

### Boot and hardware

- systemd-boot retains five generations, disables entry editing, and uses a three-second timeout;
- Plymouth and quiet kernel options reduce boot output;
- the external `nct6687` hardware-monitoring module is loaded, while `nct6683` is blocked;
- power saving is disabled for the `rtw89_core` Wi-Fi driver;
- AMDGPU is selected as the X.Org driver, with Mesa enabled for 64- and 32-bit applications;
- LACT, AMDGPU overdrive, and CoolerControl are enabled;
- OpenRGB runs as a system service with the bundled `norm2.orp` profile.

The system drive uses one Btrfs filesystem for `/` and the `/home` and `/nix` subvolumes. The EFI partition is mounted at `/boot`. A separate ext4 HDD is automounted at `/home/popov/Drives/HDD1` and unmounted after 300 idle seconds. All UUIDs are specific to the original machine.

### Memory and swap

Two swap tiers are configured:

- Zstandard-compressed zram, sized up to 100% of RAM, priority 100;
- a 16 GiB `/var/lib/swapfile`, priority 10.

The config also sets `vm.swappiness = 100` and `vm.page-cluster = 0`.

### Network and remote access

NetworkManager controls networking, Wi-Fi power saving is disabled, and Tailscale is enabled. UDP port 5353 is open for mDNS.

OpenSSH runs as a system service and opens its firewall port. Only key-based access by `popov` is permitted; root login, password authentication, and keyboard-interactive authentication are disabled. Home Manager also defines a client alias named `my-server`. `adGuardVpn.nix` installs `wireguard-tools`, `qrencode`, and the OpenSSH client, but does not create a VPN tunnel by itself.

### Locale and input

- timezone: `Europe/Minsk`;
- default locale: `ru_RU.UTF-8`;
- console keymap: US;
- Plasma provides US and RU layouts with global switching.

System XKB specifies `Alt+Shift`, while Plasma Manager specifies `Meta+Space`. If layout switching is inconsistent, keep only one of these bindings.

### Desktop and multimedia

Plasma 6 runs through SDDM. The SDDM theme is derived from Breeze and shares the desktop wallpaper. KDE Connect and dconf are enabled.

PipeWire provides ALSA, 32-bit ALSA, and PulseAudio compatibility; RTKit grants real-time priority to audio workloads. The `fix-headphones` user oneshot starts with the session, waits for PipeWire/WirePlumber, and uses `pactl` to select the `analog-output-headphones` port automatically when the front-panel jack is available. `pavucontrol`, `qpwgraph`, and `alsa-utils` are available for diagnostics.

CUPS, SANE, the proprietary HPLIP plugin, and Simple Scan support printing and scanning. The user belongs to the `lp` and `scanner` groups.

## KDE Plasma and Dolphin

`home/popov/kde-preset/` declaratively configures:

- Breeze/Breeze Light, Breeze icons, and the purple `#6A0DAD` accent;
- a 24-hour slideshow sourced from `home/popov/wallpaper/`;
- an opaque 48 px bottom panel on every screen with auto-hide;
- an empty login session, no AC auto-suspend, and no AC display timeout;
- no automatic lock or lock-on-resume;
- pinned Dolphin, Konsole, Firefox, Discord, Steam, System Settings, virt-manager, KDE Connect, Android Studio, Zed, Heroic, and AyuGram launchers;
- a `MyNixOS` entry in the Dolphin Places sidebar.

Keyboard shortcuts:

| Shortcut | Action |
| --- | --- |
| `Meta` / `Alt+F1` | application launcher |
| `Meta+Enter` | Konsole |
| `Meta+Q` | close the active window |
| `Meta+W` | Overview |
| `Meta+,` | expose windows |

For `*.nix`, the profile registers the `text/x-nix` MIME type, a custom file icon, and a “Nix File” Dolphin creation template. An activation script assigns a Nix folder icon to directories with an immediate `.nix` child under `~/MyNixOS` and `~/NixOS-vpnServer`. `.nix-icon` forces the icon, `.no-nix-icon` disables it, and unrelated `.directory` files are preserved.

## Software

### Development

- system-wide: GCC, Make, CMake, pkg-config, GDB, Python 3, pip, virtualenv, and JDK 8;
- user profile: Android Studio, Android platform-tools/ADB, JDK 17, Kotlin, Gradle, and Codex;
- Zed with Nix, Kotlin, Java, and XML extensions, `nixd`, `nixfmt`, JetBrains Mono, and a NIX//UNDERGROUND theme;
- Git with `main` as the default branch, Micro as editor, and a configured author identity;
- a local [`adb-qr`](packages/adb-qr/default.nix) package for wireless ADB pairing via QR code.

### Gaming and recording

Steam enables Remote Play, local network game transfers, and Protontricks. The user profile adds Heroic, Legendary, ProtonUp-Qt, Gamescope, and Lutris. GameMode is enabled system-wide, with Vulkan Tools and Mesa Demos available for diagnostics. OBS Studio uses PipeWire/WirePlumber and XDG portals.

MangoHud provides a full `MangoHud.conf` and a compact `lite.conf`. Wrapper commands select them:

```bash
mangohud-full <command>
mangohud-lite <command>
```

### User applications and utilities

Home Manager installs Firefox with Russian localization and custom purple CSS, btop and bottom with the NIX//UNDERGROUND theme, Fastfetch, Kate, Spectacle, Discord, AyuGram, qBittorrent, VLC, Strawberry, Darktable, Inkscape, LibreOffice, scrcpy, and multiple CLI monitoring tools.

Baloo indexes the home directory while excluding games, mounted drives, caches, Android/Gradle data, Steam, virtual machines, Trash, and this repository's `.git` directory.

## Installation and deployment

### Requirements

- an existing UEFI NixOS installation;
- Git and network access to fetch flake inputs;
- `nix-command` and `flakes` enabled (the config keeps them enabled after first deployment);
- verified backups of important data.

### Deploying on the original machine

```bash
git clone https://github.com/12615az-droid/MyNixOS.git ~/MyNixOS
cd ~/MyNixOS
sudo nixos-rebuild build --flake .#nixos
sudo nixos-rebuild test --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
```

`build` only builds the generation, `test` activates it until reboot, and `switch` activates it and makes it the default boot generation. Review the changes carefully before the first `switch`.

### Porting to another machine

1. Generate a fresh `/etc/nixos/hardware-configuration.nix` with `sudo nixos-generate-config`, then transfer the relevant values to `hosts/nixos/hardware-configuration.nix`.
2. Replace UUIDs and mount points in `hardware-configuration.nix` and `hardware/disks.nix`.
3. Replace `popov`, the UID, home directory, Git identity, SSH key, and activation-script paths.
4. Review AMDGPU, OpenRGB, `nct6687`, LACT/overdrive, CoolerControl, and the Wi-Fi workaround for the target hardware.
5. Change or remove Firefox's fixed `6o792e29.default` profile path.
6. Review the use of unfree packages and automatic acceptance of the Android SDK license.
7. Run `nixos-rebuild build`, then `test`, and only use `switch` after validation.

## Daily operations

The Bash profile defines these aliases:

| Command | Purpose |
| --- | --- |
| `nbuild` | build the configuration |
| `ntest` | activate it temporarily |
| `rebuild` | build and switch |
| `nupdate` | update `flake.lock` and switch |
| `nclean` | remove old generations and store garbage |
| `wsensors` | refresh `sensors` every second |

Equivalent commands without aliases:

```bash
sudo nixos-rebuild build --flake ~/MyNixOS#nixos
sudo nixos-rebuild test --flake ~/MyNixOS#nixos
sudo nixos-rebuild switch --flake ~/MyNixOS#nixos
(cd ~/MyNixOS && nix flake update)
```

Nix runs garbage collection weekly, removes store paths older than 14 days, and optimizes the store weekly.

## Validation and troubleshooting

```bash
# Evaluate the flake and build without switching
nix flake check --no-build
sudo nixos-rebuild build --flake .#nixos

# Inspect errors from the current boot
journalctl -b -p err

# Inspect graphics and Vulkan
glxinfo -B
vulkaninfo --summary

# Inspect virtualization
virsh -c qemu:///system list --all

# Inspect the additional drive automount
systemctl status home-popov-Drives-HDD1.automount
```

When Home Manager encounters a conflicting managed file, it backs it up with the `.hm-backup` extension. Libvirt defaults to `qemu:///system`; VM directories are created under `~/VMs` and on the HDD.

## Known caveats

- The repository contains a public SSH key and a client-side server address. Private keys must never be committed.
- `cpu-monitoring.nix` targets `intel-rapl:*` even though the host is configured for AMD; CPU energy readings may require a different udev rule.
- `modules/virtualization/virtiofs.nix` is not imported, but `virtiofsd` is already configured directly in `modules/virtualization/default.nix`.
- `stateVersion = "26.05"` controls state compatibility and should not be changed automatically during routine upgrades.
- The configuration permits unfree packages and accepts the Android SDK license.

## License and third-party software

There is currently no repository-level license file, so reuse rights for the configuration itself are not explicitly granted. `adb-qr` is the third-party MIT-licensed project [aleixrodriala/adb-qr](https://github.com/aleixrodriala/adb-qr); this repository only provides its Nix packaging.
