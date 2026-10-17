# MyNixOS · Niri + Noctalia / Nix Aurora

The `niri` branch replaces Plasma with a scrollable Niri Wayland desktop on
NixOS 26.05 and Home Manager. The dark theme combines NixOS blue, mint and
purple, rounded windows, a gradient focus ring and custom 4K wallpaper.

Inspired by [rust1xxx/Niri-Noctalia-Dots](https://github.com/rust1xxx/Niri-Noctalia-Dots):
floating capsule bar, left-aligned clock and system stats, centred workspaces,
media visualizer and right-aligned controls. Panels, popups, notifications and
Kitty are fully opaque; blur is disabled. Noctalia 4.7.6 is taken from the
existing pinned nixpkgs, with a custom Nix-Aurora colour scheme.

[Полная инструкция на русском](README.md)

## Desktop

- greetd + tuigreet login starts `niri-session` with systemd session integration.
- Noctalia provides the panel, launcher, control centre, notifications, wallpaper selector and media visualizer.
- Noctalia session menu with a cancellable countdown before shutdown/reboot.
- Opaque Kitty terminal; Thunar and Xarchiver; Mousepad, Ristretto and Evince.
- Swaylock after 5 minutes, monitor power-off after 10 minutes; Noctalia idle management is disabled to avoid competing lockers.
- Adwaita-dark with custom accents, Papirus icons, Bibata Modern Ice cursor.
- xwayland-satellite for X11 apps; GNOME screencast portal and GTK file chooser.

Plasma, SDDM, plasma-manager, KDE Connect, Baloo and the old KDE preset are
removed, along with explicitly installed KDE apps. GParted replaces Partition
Manager and LibreOffice uses the GTK variant. Independent Qt applications,
games, development tools, hardware configuration, SSH, VPN and virtualization
are preserved. Existing KDE files in the user's home directory are not deleted.
Some retained applications may still depend on KDE/Qt libraries in the Nix store.

## Install on the configured machine

This configuration contains machine-specific disks and user settings.
Check `hosts/nixos/hardware-configuration.nix` before using another machine.

From an existing clean clone:

```bash
cd ~/MyNixOS
git fetch origin
git switch --track origin/niri
nix flake check
sudo nixos-rebuild build --flake .#nixos
sudo nixos-rebuild boot --flake .#nixos
sudo reboot
```

Use `git switch niri` if the local branch already exists. Using `boot` avoids
replacing the running desktop mid-session. Log in with your existing username
and password. Keep older generations until the desktop has been tested; select
an older generation in the bootloader if needed.

Validated: full NixOS configuration evaluation (`system.build.toplevel.drvPath`),
build of `checks.x86_64-linux.niri-config`, and generated KDL validation by
Niri 26.04 (`config is valid`). Generated Noctalia JSON was checked against
v4.7.6 setting keys, opacity values and lock-before-suspend commands.
A full system package build and a live graphical session were not tested.

## Shortcuts and customization

Super+Enter: terminal; Super+D: launcher; Super+E: files; Super+B: browser;
Super+L: lock; Super+Shift+E: power menu; Super+O: overview;
Super+1–4: named workspaces; Super+arrows: focus; Super+Ctrl+arrows: move;
Super+F: maximize column; Super+Shift+F: fullscreen; Super+V: floating;
Print: screenshot; Alt+Shift: RU/EN; Super+Shift+/: shortcut overlay;
Super+S: control centre; Super+X: wallpapers; Super+N: notification history.

Screenshots are saved in `~/Pictures/Screenshots`. Displays use automatic modes;
inspect names with `niri msg outputs` before adding explicit output settings.

Desktop files live in `home/popov/niri/`: `palette.nix` controls UI colours,
`config.kdl` controls windows and shortcuts, `noctalia-settings.json` controls
the shell layout and opacity, `noctalia.nix` installs the shell and its palette,
`default.nix` configures apps and services, and `wallpaper.svg` is the wallpaper
source with its own gradient colours. System integration is in
`modules/desktop/niri.nix`.

See [Niri documentation](https://niri-wm.github.io/niri/) and
[Noctalia v4 documentation](https://docs.noctalia.dev/noctalia-shell-legacy/).
Noctalia settings are declarative; copy UI experiments into the JSON file
and rebuild to persist them. Wallpaper colour extraction is disabled.
The existing adb-qr package comes from [aleixrodriala/adb-qr](https://github.com/aleixrodriala/adb-qr).
