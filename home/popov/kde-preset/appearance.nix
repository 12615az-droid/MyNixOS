{ pkgs, ... }:

{
  programs.plasma = {
    workspace = {
      clickItemTo = "open";

      lookAndFeel = "org.kde.breeze.desktop";
      theme = "breeze";
      colorScheme = "BreezeLight";
      iconTheme = "breeze";

      wallpaper =
        "${pkgs.kdePackages.plasma-workspace-wallpapers}"
        + "/share/wallpapers/ScarletTree/contents/images/5120x2880.png";

      wallpaperFillMode = "preserveAspectCrop";
    };

    startup.startupScript."purple-accent" = {
      priority = 2;
      runAlways = true;

      text = ''
        plasma-apply-colorscheme --accent-color "#8B5CF6"
      '';
    };
  };
}
