{ pkgs, ... }:

let
  theme = import ./theme.nix { inherit pkgs; };
in
{
  programs.plasma = {
    workspace = {
      clickItemTo = "open";

      lookAndFeel = "org.kde.breeze.desktop";
      theme = "breeze";
      colorScheme = "BreezeLight";
      iconTheme = "breeze";

      wallpaperSlideShow = {
        path = theme.wallpaperDir;

        # 24 часа
        interval = 24 * 60 * 60;
      };

      wallpaperFillMode = "preserveAspectCrop";
    };

    startup.startupScript."purple-accent" = {
      priority = 2;
      runAlways = true;

      text = ''
        plasma-apply-colorscheme --accent-color "${theme.accent}"
      '';
    };
  };
}
