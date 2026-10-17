{ ... }:

{
  imports = [
    ./adGuardVpn.nix
    ./btop.nix
    ./development.nix
    ./fastfetch.nix
    ./function.nix
    ./gaming.nix
    ./git.nix
    ./niri
    ./mangohud.nix
    ./monitors.nix
    ./packages.nix
    ./shell.nix
    ./ssh.nix
   ./Bottom.nix
   ./zed.nix

  ];

  home.username = "popov";
  home.homeDirectory = "/home/popov";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}

