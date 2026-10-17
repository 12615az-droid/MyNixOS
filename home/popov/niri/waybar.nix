{ pkgs, ... }:
let c = import ./palette.nix;
in {
  programs.waybar = {
    enable = true;
    systemd = { enable = true; targets = [ "graphical-session.target" ]; };
    settings.main = {
      layer = "top";
      position = "top";
      height = 42;
      margin-top = 10;
      margin-left = 16;
      margin-right = 16;
      spacing = 4;
      modules-left = [ "custom/launcher" "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "memory" "pulseaudio" "network" "bluetooth" "niri/language" "tray" "custom/power" ];
      "custom/launcher" = { format = ""; tooltip-format = "Приложения · Super+D"; on-click = "${pkgs.fuzzel}/bin/fuzzel"; };
      "niri/workspaces" = {
        format = "{icon}";
        format-icons = { main = "01"; work = "02"; chat = "03"; games = "04"; default = "·"; };
      };
      "niri/window" = { format = "{}"; max-length = 28; separate-outputs = true; };
      clock = { format = "{:%H:%M  ·  %d.%m}"; tooltip-format = "<big>{:%A, %d %B %Y}</big>\n<tt>{calendar}</tt>"; };
      cpu = { format = "  {usage}%"; interval = 5; };
      memory = { format = "  {}%"; interval = 5; };
      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "󰖁";
        format-icons.default = [ "" "" "" ];
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      network = {
        format-wifi = "  {signalStrength}%";
        format-ethernet = "󰈀";
        format-disconnected = "󰖪";
        tooltip-format = "{ifname} · {ipaddr}";
        on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
      };
      bluetooth = {
        format = "";
        format-connected = " {num_connections}";
        format-disabled = "󰂲";
        on-click = "${pkgs.blueman}/bin/blueman-manager";
      };
      "niri/language" = { format = "{short}"; };
      tray = { spacing = 10; icon-size = 17; };
      "custom/power" = { format = "⏻"; tooltip-format = "Питание · Super+Shift+E"; on-click = "niri-power-menu"; };
    };
    style = ''
      * { font-family: "JetBrainsMono Nerd Font", "Inter"; font-size: 12px; border: none; min-height: 0; }
      window#waybar { background: alpha(#${c.background}, 0.94); color: #${c.text}; border: 1px solid #${c.border}; border-radius: 16px; }
      tooltip { background: #${c.surface}; border: 1px solid #${c.purple}; border-radius: 12px; }
      tooltip label { color: #${c.text}; padding: 8px; }
      #custom-launcher { font-size: 25px; color: #${c.blue}; padding: 0 18px; }
      #workspaces { margin: 6px 4px; background: #${c.surface}; border-radius: 10px; }
      #workspaces button { color: #${c.muted}; padding: 0 10px; border-radius: 9px; }
      #workspaces button.active { background: linear-gradient(110deg, #${c.blue}, #${c.mint}); color: #${c.background}; font-weight: bold; }
      #workspaces button:hover { background: #${c.border}; color: #${c.text}; box-shadow: none; }
      #workspaces button.urgent { background: #${c.purple}; color: #${c.background}; }
      #window { color: #${c.muted}; padding: 0 10px; }
      #clock { color: #${c.text}; font-weight: bold; padding: 0 16px; }
      #cpu, #memory, #pulseaudio, #network, #bluetooth, #language, #tray { padding: 0 8px; }
      #cpu, #network { color: #${c.blue}; }
      #memory, #bluetooth { color: #${c.purple}; }
      #pulseaudio, #language { color: #${c.mint}; }
      #pulseaudio.muted, #network.disconnected { color: #${c.muted}; }
      #custom-power { color: #${c.purple}; background: #${c.surface}; margin: 6px; padding: 0 13px; border-radius: 10px; }
    '';
  };
}
