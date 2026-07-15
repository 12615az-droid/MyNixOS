{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/boot.nix
    ./modules/network.nix
    ./modules/locale.nix
    ./modules/desktop-kde.nix
    ./modules/desktop-hyprland.nix
    ./modules/audio.nix
    ./modules/users.nix
    ./modules/nix-settings.nix
    ./modules/gaming.nix
    ./modules/base-dev.nix
    ./modules/packages.nix

    ./modules/hardware-nvidia.nix
    ./modules/disks.nix
    ./modules/swap.nix
    ./modules/virtualization.nix
  ];

  system.stateVersion = "26.05";
}
