{ ... }:

{
  imports = [
    ./gaming.nix
    ./obs.nix
    ./base-dev.nix
    ./packages.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
