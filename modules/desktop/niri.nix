{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  # niri-session imports the environment and starts graphical-session.target.
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${pkgs.niri}/bin/niri-session --theme 'border=blue;text=cyan;prompt=magenta;time=blue;action=cyan;button=magenta;container=black;input=white'";
      user = "greeter";
    };
  };

  security.polkit.enable = true;
  security.pam.services.swaylock = { };
  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [ thunar-archive-plugin thunar-volman ];
  };

  # Niri supplies the GNOME screencast portal; GTK handles file selection.
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.systemPackages = with pkgs; [ xwayland-satellite ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono inter noto-fonts noto-fonts-color-emoji ];
}
