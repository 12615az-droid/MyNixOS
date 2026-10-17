{ config, lib, pkgs, ... }:

let
  c = import ./palette.nix;
  wallpaper = pkgs.runCommand "nix-aurora-wallpaper" {
    nativeBuildInputs = [ pkgs.librsvg ];
  } ''
    mkdir -p $out
    rsvg-convert -w 3840 -h 2160 ${./wallpaper.svg} -o $out/wallpaper.png
  '';
  powerMenu = pkgs.writeShellApplication {
    name = "niri-power-menu";
    runtimeInputs = [ pkgs.fuzzel pkgs.systemd pkgs.niri pkgs.swaylock ];
    text = ''
      choice=$(printf '%s\n' 'Блокировка' 'Сон' 'Выйти из Niri' 'Перезагрузка' 'Выключение' | fuzzel --dmenu --prompt 'Питание > ') || exit 0
      case "$choice" in
        'Блокировка') exec swaylock -f ;;
        'Сон') swaylock -f && systemctl suspend ;;
        'Выйти из Niri') exec niri msg action quit ;;
        'Перезагрузка'|'Выключение')
          answer=$(printf '%s\n' 'Отмена' 'Подтвердить' | fuzzel --dmenu --prompt "$choice > ") || exit 0
          [ "$answer" = 'Подтвердить' ] || exit 0
          if [ "$choice" = 'Перезагрузка' ]; then
            exec systemctl reboot
          else
            exec systemctl poweroff
          fi
          ;;
      esac
    '';
  };
  sessionService = description: command: {
    Unit = {
      Description = description;
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = { ExecStart = command; Restart = "on-failure"; RestartSec = 2; };
    Install.WantedBy = [ "graphical-session.target" ];
  };
in
{
  imports = [ ./waybar.nix ];

  xdg.configFile."niri/config.kdl".text = builtins.replaceStrings
    (map (name: "@${name}@") (builtins.attrNames c))
    (builtins.attrValues c)
    (builtins.readFile ./config.kdl);
  xdg.dataFile."wallpapers/nix-aurora.png".source = "${wallpaper}/wallpaper.png";
  xdg.userDirs = { enable = true; createDirectories = true; };
  home.activation.screenshotDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p ${lib.escapeShellArg "${config.home.homeDirectory}/Pictures/Screenshots"}
  '';
  home.sessionVariables = {
    TERMINAL = "foot";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
  home.packages = with pkgs; [
    powerMenu
    wl-clipboard
    brightnessctl
    playerctl
    wireplumber
    networkmanagerapplet
    blueman
    xfconf
    mousepad
    ristretto
    xarchiver
    evince
    papirus-icon-theme
  ];

  gtk = {
    enable = true;
    theme = { name = "Adwaita-dark"; package = pkgs.gnome-themes-extra; };
    iconTheme = { name = "Papirus-Dark"; package = pkgs.papirus-icon-theme; };
    font = { name = "Inter"; size = 11; };
    gtk3.extraCss = ''
      @define-color theme_selected_bg_color #${c.blue};
      @define-color theme_selected_fg_color #${c.background};
      @define-color theme_bg_color #${c.surface};
      @define-color theme_fg_color #${c.text};
      @define-color theme_base_color #${c.background};
      @define-color theme_text_color #${c.text};
    '';
    gtk4.extraCss = ''
      @define-color accent_bg_color #${c.blue};
      @define-color accent_fg_color #${c.background};
      @define-color accent_color #${c.mint};
      @define-color window_bg_color #${c.background};
      @define-color window_fg_color #${c.text};
      @define-color view_bg_color #${c.surface};
    '';
  };
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];
      "text/plain" = [ "org.mousepad.desktop" ];
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "image/png" = [ "org.ristretto.desktop" ];
      "image/jpeg" = [ "org.ristretto.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };
  programs.foot = {
    enable = true;
    settings = {
      main = { font = "JetBrainsMono Nerd Font:size=11"; pad = "18x18"; };
      colors = {
        background = c.background;
        foreground = c.text;
        regular0 = c.surface; regular1 = c.red; regular2 = c.mint; regular3 = "f1d89a";
        regular4 = c.blue; regular5 = c.purple; regular6 = "79d5df"; regular7 = c.text;
        bright0 = c.muted; bright1 = "ffadc4"; bright2 = "b0f3d8"; bright3 = "ffe9b5";
        bright4 = "a4d4f5"; bright5 = "d0bfff"; bright6 = "a7edf2"; bright7 = "ffffff";
        selection-background = c.purple;
        selection-foreground = c.background;
      };
      cursor.color = "${c.background} ${c.mint}";
    };
  };
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Inter:size=12";
        terminal = "${pkgs.foot}/bin/foot";
        icon-theme = "Papirus-Dark";
        prompt = "❯  ";
        width = 38;
        lines = 9;
        horizontal-pad = 24;
        vertical-pad = 20;
      };
      colors = {
        background = "${c.background}f5";
        text = "${c.text}ff";
        match = "${c.mint}ff";
        selection = "${c.surface}ff";
        selection-text = "${c.purple}ff";
        selection-match = "${c.mint}ff";
        border = "${c.blue}ff";
      };
      border = { width = 2; radius = 18; };
    };
  };
  services.network-manager-applet.enable = true;
  xsession.preferStatusNotifierItems = true;

  services.mako = {
    enable = true;
    settings = {
      font = "Inter 11";
      background-color = "#${c.surface}f2";
      text-color = "#${c.text}";
      border-color = "#${c.purple}";
      border-size = 2;
      border-radius = 14;
      padding = "16";
      margin = "16";
      width = 360;
      default-timeout = 6000;
      max-visible = 4;
      "urgency=critical" = { border-color = "#${c.red}"; default-timeout = 0; };
    };
  };
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${wallpaper}/wallpaper.png";
      scaling = "fill";
      font = "Inter";
      indicator-radius = 90;
      indicator-thickness = 7;
      inside-color = "${c.background}dd";
      ring-color = c.blue;
      key-hl-color = c.mint;
      bs-hl-color = c.purple;
      text-color = c.text;
      line-color = "00000000";
      separator-color = "00000000";
      ring-ver-color = c.purple;
      ring-wrong-color = c.red;
      inside-ver-color = c.surface;
      inside-wrong-color = c.surface;
      show-failed-attempts = true;
    };
  };
  services.swayidle = {
    enable = true;
    systemdTargets = [ "graphical-session.target" ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      {
        timeout = 600;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors";
      }
    ];
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
      lock = "${pkgs.swaylock}/bin/swaylock -f";
    };
  };
  systemd.user.services = {
    niri-wallpaper = sessionService "Nix Aurora wallpaper"
      "${pkgs.swaybg}/bin/swaybg -i ${wallpaper}/wallpaper.png -m fill";
    niri-polkit = sessionService "Desktop authentication agent"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
}
