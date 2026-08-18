{ ... }:

{
  imports = [
    ./appearance.nix
    ./panel.nix
    ./shortcuts.nix
    ./lockscreen.nix
    ./power.nix
    ./file-icons.nix
    ./keyboard.nix
  ];

  programs.plasma.enable = true;
}
