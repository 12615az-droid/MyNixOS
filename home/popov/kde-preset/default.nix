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
    ./sesion.nix
    ./file-templates.nix
    ./places.nix
  ];

  programs.plasma.enable = true;
}
