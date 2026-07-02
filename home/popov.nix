{ ... }:

{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./development.nix
  ];

  home.username = "popov";
  home.homeDirectory = "/home/popov";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
