{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "open";

      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";

      iconTheme = "breeze-dark";

      cursor = {
        theme = "breeze_cursors";
        size = 24;
      };

      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Next/contents/images/1920x1080.png";
    };

    fonts = {
      general = {
        family = "Noto Sans";
        pointSize = 10;
      };

      fixedWidth = {
        family = "JetBrains Mono";
        pointSize = 10;
      };
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Return";
      command = "konsole";
    };

    shortcuts = {
      kwin = {
        "Window Close" = "Meta+Q";
        "Expose" = "Meta+,";
        "Overview" = "Meta+W";
      };
    };

    kscreenlocker = {
      lockOnResume = false;
      timeout = 0;
    };

    powerdevil = {
      AC = {
        powerButtonAction = "showLogoutScreen";

        autoSuspend = {
          action = "nothing";
          idleTimeout = null;
        };

        turnOffDisplay = {
          idleTimeout = null;
        };
      };
    };
  };
}
