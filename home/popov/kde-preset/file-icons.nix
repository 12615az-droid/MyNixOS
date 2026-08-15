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
  # NIX FILE ICON — BREEZE
  # ─────────────────────────────────────────────

  xdg.dataFile."icons/breeze/mimetypes/16/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;

  xdg.dataFile."icons/breeze/mimetypes/22/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;

  xdg.dataFile."icons/breeze/mimetypes/32/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;

  xdg.dataFile."icons/breeze/mimetypes/64/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;

  xdg.dataFile."icons/hicolor/scalable/mimetypes/text-x-nix.svg".source =
    ./icons/text-x-nix.svg;


  # ─────────────────────────────────────────────
  # NIX FOLDER ICON — BREEZE
  # ─────────────────────────────────────────────

  xdg.dataFile."icons/breeze/places/16/folder-nix.svg".source =
    ./icons/folder-nix.svg;

  xdg.dataFile."icons/breeze/places/22/folder-nix.svg".source =
    ./icons/folder-nix.svg;

  xdg.dataFile."icons/breeze/places/32/folder-nix.svg".source =
    ./icons/folder-nix.svg;

  xdg.dataFile."icons/breeze/places/64/folder-nix.svg".source =
    ./icons/folder-nix.svg;

  xdg.dataFile."icons/hicolor/scalable/places/folder-nix.svg".source =
    ./icons/folder-nix.svg;


  # ─────────────────────────────────────────────
  # UPDATE MIME DATABASE
  # ─────────────────────────────────────────────

  home.activation.updateNixMimeDatabase =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ${pkgs.shared-mime-info}/bin/update-mime-database \
        "$HOME/.local/share/mime"
    '';


  # ─────────────────────────────────────────────
  # AUTO NIX FOLDER ICONS
  # ─────────────────────────────────────────────
  #
  # Правило:
  #   *.nix прямо в папке -> Nix folder
  #   .nix-icon           -> принудительно Nix folder
  #   .no-nix-icon        -> принудительно обычная папка
  #
  # Рекурсивно содержимое НЕ проверяется.
  # Скрипт не перезаписывает чужие .directory.
  # Удаляет только созданные им самим .directory.

  home.activation.updateNixFolderIcons =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      roots=(
        "$HOME/MyNixOS"
        "$HOME/NixOS-vpnServer"
      )

      for root in "''${roots[@]}"; do
        [ -d "$root" ] || continue

        while IFS= read -r -d "" dir; do
          directory_file="$dir/.directory"

          # Принудительно оставить обычную иконку.
          if [ -e "$dir/.no-nix-icon" ]; then
            if [ -f "$directory_file" ] &&
               ${pkgs.gnugrep}/bin/grep -q '^X-NixFolderIcon=true$' "$directory_file"; then
              rm -f "$directory_file"
            fi
            continue
          fi

          wants_nix_icon=false

          # Принудительно включить Nix-иконку.
          if [ -e "$dir/.nix-icon" ]; then
            wants_nix_icon=true

          # Либо найти *.nix только непосредственно в этой папке.
          elif ${pkgs.findutils}/bin/find "$dir" \
              -mindepth 1 -maxdepth 1 \
              -type f -name '*.nix' \
              -print -quit | ${pkgs.gnugrep}/bin/grep -q .; then
            wants_nix_icon=true
          fi

          if [ "$wants_nix_icon" = true ]; then
            # Если .directory пользовательский — не трогаем.
            if [ -e "$directory_file" ] &&
               ! ${pkgs.gnugrep}/bin/grep -q '^X-NixFolderIcon=true$' "$directory_file"; then
              continue
            fi

            cat > "$directory_file" <<'EOF'
[Desktop Entry]
Icon=folder-nix
X-NixFolderIcon=true
EOF

          else
            # Удаляем только наш .directory.
            if [ -f "$directory_file" ] &&
               ${pkgs.gnugrep}/bin/grep -q '^X-NixFolderIcon=true$' "$directory_file"; then
              rm -f "$directory_file"
            fi
          fi

        done < <(
          ${pkgs.findutils}/bin/find "$root" \
            -type d \
            \( -name .git -o -name .direnv -o -name result \) -prune \
            -o -type d -print0
        )
      done
    '';
}
