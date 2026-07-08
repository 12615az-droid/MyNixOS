{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Чтобы Electron-приложения лучше работали через Wayland.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
      kitty
      waybar
      rofi
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
    ];
}



