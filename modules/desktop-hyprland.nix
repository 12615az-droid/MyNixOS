{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Чтобы Wayland/Electron/Firefox работали стабильнее в Hyprland.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
  ];

  environment.systemPackages = with pkgs; [
    kitty
    waybar
    rofi-wayland
    mako

    grim
    slurp
    swappy

    wl-clipboard
    cliphist

    pavucontrol
    pamixer
    playerctl
    brightnessctl

    hyprpicker
    hyprsunset

    libnotify
    networkmanagerapplet
  ];
}
