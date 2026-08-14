{ ... }:

{
  imports = [
    ./appearance.nix
    ./panel.nix
    ./shortcuts.nix
    ./lockscreen.nix
    ./power.nix
    ./file-icons.nix
  ];

  programs.plasma.enable = true;
}
