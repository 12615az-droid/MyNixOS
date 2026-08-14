{ pkgs, lib, ... }:

{
  # ─────────────────────────────────────────────
  # NIX MIME
  # ─────────────────────────────────────────────

  xdg.dataFile."mime/packages/nix.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
      <mime-type type="text/x-nix">
        <comment>Nix source file</comment>

        <icon name="text-x-nix"/>

        <glob pattern="*.nix" weight="80"/>
      </mime-type>
    </mime-info>
  '';

  # ─────────────────────────────────────────────
  # NIX ICON — BREEZE
  # ─────────────────────────────────────────────

  # Кладём нашу иконку непосредственно в активную
  # тему Breeze.
  xdg.dataFile."icons/breeze/mimetypes/16/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;

  xdg.dataFile."icons/breeze/mimetypes/22/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;

  xdg.dataFile."icons/breeze/mimetypes/32/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;

  xdg.dataFile."icons/breeze/mimetypes/64/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;


  # Fallback тоже оставим
  xdg.dataFile."icons/hicolor/scalable/mimetypes/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;


  # ─────────────────────────────────────────────
  # UPDATE MIME DATABASE
  # ─────────────────────────────────────────────

  home.activation.updateNixMimeDatabase =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ${pkgs.shared-mime-info}/bin/update-mime-database \
        "$HOME/.local/share/mime"
    '';
}
