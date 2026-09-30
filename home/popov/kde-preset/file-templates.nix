{ ... }:

{
  # ─────────────────────────────────────────────
  # DOLPHIN — CREATE NEW → NIX FILE
  # ─────────────────────────────────────────────

  xdg.dataFile."templates/NixFile.desktop".text = ''
    [Desktop Entry]
    Type=Link
    Name=Nix File
    Comment=Имя Nix-файла:
    Icon=text-x-nix
    URL=.source/empty.nix
  '';

  xdg.dataFile."templates/.source/empty.nix".text = "";
}
