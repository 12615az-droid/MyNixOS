{ config, lib, pkgs, ... }:

let
  myNixOS = "${config.home.homeDirectory}/MyNixOS";
in
{
  home.activation.addMyNixOSPlace =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      places="$HOME/.local/share/user-places.xbel"

      mkdir -p "$HOME/.local/share"

      # Если Dolphin ещё ни разу не создавал файл.
      if [ ! -f "$places" ]; then
        cat > "$places" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xbel>
<xbel xmlns:bookmark="http://www.freedesktop.org/standards/desktop-bookmarks">
</xbel>
EOF
      fi

      # Добавляем MyNixOS только если его ещё нет.
      if ! ${pkgs.gnugrep}/bin/grep -Fq \
        'href="file://${myNixOS}"' "$places"; then

        tmp="$(${pkgs.coreutils}/bin/mktemp)"

        ${pkgs.gnused}/bin/sed '/<\/xbel>/i\
 <bookmark href="file://${myNixOS}">\
  <title>MyNixOS</title>\
  <info>\
   <metadata owner="http://freedesktop.org">\
    <bookmark:icon name="folder-development"/>\
   </metadata>\
  </info>\
 </bookmark>
' "$places" > "$tmp"

        ${pkgs.coreutils}/bin/cat "$tmp" > "$places"
        ${pkgs.coreutils}/bin/rm "$tmp"
      fi
    '';
}
