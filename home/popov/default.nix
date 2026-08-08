{ ... }:

{
  imports = [
    ./adGuardVpn.nix
    ./baloo.nix
    ./btop.nix
    ./development.nix
    ./fastfetch.nix
    ./function.nix
    ./gaming.nix
    ./git.nix
    ./kde-preset.nix
    ./mangohud.nix
    ./monitors.nix
    ./packages.nix
    ./shell.nix
  ];

  home.username = "popov";
  home.homeDirectory = "/home/popov";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
