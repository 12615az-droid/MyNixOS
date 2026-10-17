{ config, lib, pkgs, ... }:

let
  c = import ./palette.nix;
  wallpaper = pkgs.runCommand "nix-aurora-wallpaper" {
    nativeBuildInputs = [ pkgs.librsvg ];
  } ''
    mkdir -p $out
    rsvg-convert -w 3840 -h 2160 ${./wallpaper.svg} -o $out/wallpaper.png
  '';
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
  imports = [ ./noctalia.nix ];

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
    TERMINAL = "kitty";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
  home.packages = with pkgs; [
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
      "text/plain" = [ "org.xfce.mousepad.desktop" ];
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "image/png" = [ "org.xfce.ristretto.desktop" ];
      "image/jpeg" = [ "org.xfce.ristretto.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };
  programs.kitty = {
    enable = true;
    font = { name = "JetBrainsMono Nerd Font"; size = 11; };
    settings = {
      background_opacity = "1.0";
      dynamic_background_opacity = false;
      window_padding_width = 14;
      hide_window_decorations = "yes";
      tab_bar_style = "powerline";
      background = "#${c.background}";
      foreground = "#${c.text}";
      cursor = "#${c.mint}";
      cursor_text_color = "#${c.background}";
      selection_background = "#${c.purple}";
      selection_foreground = "#${c.background}";
      active_tab_background = "#${c.blue}";
      active_tab_foreground = "#${c.background}";
      inactive_tab_background = "#${c.surface}";
      inactive_tab_foreground = "#${c.muted}";
      color0 = "#${c.surface}"; color1 = "#${c.red}";
      color2 = "#${c.mint}"; color3 = "#f1d89a";
      color4 = "#${c.blue}"; color5 = "#${c.purple}";
      color6 = "#79d5df"; color7 = "#${c.text}";
      color8 = "#${c.muted}"; color9 = "#ffadc4";
      color10 = "#b0f3d8"; color11 = "#ffe9b5";
      color12 = "#a4d4f5"; color13 = "#d0bfff";
      color14 = "#a7edf2"; color15 = "#ffffff";
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
      inside-color = "${c.background}ff";
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
    niri-network = sessionService "Network authentication and tray applet"
      "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
    niri-polkit = sessionService "Desktop authentication agent"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
}
