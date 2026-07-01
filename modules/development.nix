{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  environment.systemPackages = with pkgs; [
    git
    gcc
    gnumake
    cmake
    pkg-config
    gdb

    python3
    python3Packages.pip
    python3Packages.virtualenv

    kotlin
    gradle

    vscode

    android-studio
    android-tools
  ];
}
