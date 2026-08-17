{ pkgs, ... }:

let
  theme = import ../../home/popov/kde-preset/theme.nix {
    inherit pkgs;
  };

  wallpaper = theme.wallpaper;

  breezeScarlet = pkgs.runCommand "sddm-breeze-scarlet" { } ''
    mkdir -p $out/share/sddm/themes/breeze-scarlet

    cp -r \
      ${pkgs.kdePackages.plasma-desktop}/share/sddm/themes/breeze/. \
      $out/share/sddm/themes/breeze-scarlet/

    chmod -R u+w $out/share/sddm/themes/breeze-scarlet

    cat > $out/share/sddm/themes/breeze-scarlet/theme.conf.user <<EOF
[General]
type=image
background=${wallpaper}

showClock=true
showlogo=hidden
EOF
  '';
in
{
  services.displayManager.sddm = {
    enable = true;

    theme =
      "${breezeScarlet}"
      + "/share/sddm/themes/breeze-scarlet";

    settings.Theme = {
      CursorTheme = "breeze_cursors";
      CursorSize = 24;
    };
  };
}
