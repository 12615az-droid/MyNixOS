{ config, lib, ... }:

{
  xdg.dataFile."templates/NixFile.desktop".text = ''
    [Desktop Entry]
    Type=Link
    Name=Nix File
    Comment=Создать Nix-файл
    Icon=text-x-nix
    URL=.source/empty.nix
  '';

  home.activation.createNixTemplate =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      templateDir="${config.xdg.dataHome}/templates/.source"

      mkdir -p "$templateDir"

      # Удаляем старую HM-ссылку в /nix/store, если осталась.
      if [ -L "$templateDir/empty.nix" ]; then
        rm "$templateDir/empty.nix"
      fi

      # Создаём настоящий обычный файл.
      if [ ! -e "$templateDir/empty.nix" ]; then
        touch "$templateDir/empty.nix"
      fi
    '';
}
