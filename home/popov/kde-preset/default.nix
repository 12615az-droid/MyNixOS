{ ... }:

{
  imports = [
    ./appearance.nix
    ./panel.nix
    ./shortcuts.nix
    ./lockscreen.nix
    ./power.nix
  ];

  programs.plasma.enable = true;
}
