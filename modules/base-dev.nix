{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    pkg-config
    gdb

    python3
    python3Packages.pip
    python3Packages.virtualenv
   
  ];
}
