{ pkgs, ... }:

let
  # Те же обои, что используются в Plasma
  wallpaper =
    "${pkgs.kdePackages.plasma-workspace-wallpapers}"
    + "/share/wallpapers/ScarletTree/contents/images/5120x2880.png";

  # Берём стандартную KDE Breeze тему SDDM
  # и добавляем к ней свой конфиг.
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

    # Используем нашу модификацию Breeze
    theme =
      "${breezeScarlet}"
      + "/share/sddm/themes/breeze-scarlet";

    settings = {
      Theme = {
        CursorTheme = "breeze_cursors";
        CursorSize = 24;
      };
    };
  };
}
