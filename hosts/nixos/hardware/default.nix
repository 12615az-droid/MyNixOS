{ ... }:

{
  imports = [
    ../hardware-configuration.nix

    ./nvidia.nix
    ./disks.nix
    ./bootloader.nix
  ];
}
