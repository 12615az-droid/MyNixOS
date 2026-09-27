{ ... }:

{
  imports = [
    ../hardware-configuration.nix

    ./amdgpu.nix
    ./disks.nix
    ./bootloader.nix
    ./nonrgb.nix
  ];
}
