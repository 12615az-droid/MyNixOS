{ config, pkgs, ... }:
let
  c = import ./palette.nix;
  base = builtins.fromJSON (builtins.readFile ./noctalia-settings.json);
  shell = "${pkgs.noctalia-shell}/bin/noctalia-shell";
  lock = "${pkgs.swaylock}/bin/swaylock -f";
  dark = {
    mPrimary = "#${c.blue}"; mOnPrimary = "#${c.background}";
    mSecondary = "#${c.mint}"; mOnSecondary = "#${c.background}";
    mTertiary = "#${c.purple}"; mOnTertiary = "#${c.background}";
    mError = "#${c.red}"; mOnError = "#${c.background}";
    mSurface = "#${c.background}"; mOnSurface = "#${c.text}";
    mSurfaceVariant = "#${c.surface}"; mOnSurfaceVariant = "#${c.muted}";
    mOutline = "#${c.border}"; mShadow = "#000000";
    mHover = "#${c.purple}"; mOnHover = "#${c.background}";
  };
  light = dark // {
    mPrimary = "#395e9e"; mOnPrimary = "#ffffff";
    mSecondary = "#27775e"; mOnSecondary = "#ffffff";
    mTertiary = "#7350ab"; mOnTertiary = "#ffffff";
    mError = "#b33556"; mOnError = "#ffffff";
    mSurface = "#eef3fc"; mOnSurface = "#17243b";
    mSurfaceVariant = "#dce6f5"; mOnSurfaceVariant = "#435674";
    mOutline = "#9bacc6"; mHover = "#cfc0ef"; mOnHover = "#17243b";
  };
  settings = base // {
    appLauncher = base.appLauncher // { terminalCommand = "${pkgs.kitty}/bin/kitty -e"; };
    wallpaper = base.wallpaper // { directory = "${config.xdg.dataHome}/wallpapers"; };
    hooks = {
      enabled = true;
      startup = "${shell} ipc call wallpaper set ${config.xdg.dataHome}/wallpapers/nix-aurora.png all";
    };
    sessionMenu = base.sessionMenu // {
      powerOptions = [
        { action = "lock"; enabled = true; keybind = "1"; command = lock; }
        # swaylock -f returns only after the lock surface is ready.
        { action = "suspend"; enabled = true; keybind = "2"; command = "${lock} && ${pkgs.systemd}/bin/systemctl suspend"; }
        { action = "reboot"; enabled = true; keybind = "3"; }
        { action = "logout"; enabled = true; keybind = "4"; command = "${pkgs.niri}/bin/niri msg action quit"; }
        { action = "shutdown"; enabled = true; keybind = "5"; }
      ];
    };
    systemMonitor = { externalMonitor = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop"; };
  };
in {
  # Use the v4 package already pinned by flake.lock, not the incompatible v5 API.
  home.packages = [ pkgs.noctalia-shell ];
  xdg.configFile."noctalia/settings.json".text = builtins.toJSON settings;
  xdg.configFile."noctalia/colorschemes/Nix-Aurora/Nix-Aurora.json".text =
    builtins.toJSON { inherit dark light; };
  # Do not manage colors.json: Noctalia generates that writable runtime file.
  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia desktop shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = { ExecStart = shell; Restart = "on-failure"; RestartSec = 2; };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
