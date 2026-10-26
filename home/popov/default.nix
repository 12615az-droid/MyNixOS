{ ... }:

{
  imports = [
    ./apps
    ./development
    ./desktop
    ./gaming
    ./terminal
  ];

  home.username = "popov";
  home.homeDirectory = "/home/popov";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
