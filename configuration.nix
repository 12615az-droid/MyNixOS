{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/boot.nix
    ./modules/network.nix
    ./modules/locale.nix
    ./modules/desktop-kde.nix
    ./modules/audio.nix
    ./modules/users.nix
    ./modules/nix-settings.nix
    ./modules/gaming.nix
    ./modules/development.nix
    ./modules/packages.nix

    ./modules/nvidia.nix
    ./modules/disks.nix
    ./modules/virtualization.nix
  ];

  system.stateVersion = "26.05";
}
