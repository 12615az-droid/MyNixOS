{ ... }:

{
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;

  xdg.configFile."waybar/config".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;

  xdg.configFile."mako/config".source = ./mako/config;

  xdg.configFile."rofi/config.rasi".source = ./rofi/config.rasi;
  xdg.configFile."rofi/purple-neon.rasi".source = ./rofi/purple-neon.rasi;

  xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;
}
