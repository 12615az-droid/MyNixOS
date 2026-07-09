{ ... }:

{
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  xdg.configFile."hypr/macchiato.conf".source = ./hypr/macchiato.conf;

  xdg.configFile."waybar/config".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;

  xdg.configFile."mako/config".source = ./mako/config;
}
