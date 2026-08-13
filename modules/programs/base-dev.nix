{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    pkg-config
    gdb
  jdk8
    python3
    python3Packages.pip
    python3Packages.virtualenv
   
  ];
}
