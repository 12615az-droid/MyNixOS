{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # KDE остаётся запасным окружением, Hyprland появляется отдельной Wayland-сессией в SDDM.
  services.dbus.enable = true;
  security.polkit.enable = true;
  programs.dconf.enable = true;

  # Порталы нужны для скриншотов, выбора файлов, открытия ссылок и демонстрации экрана.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "kde";
  };

  environment.systemPackages = with pkgs; [
    # Основной Hyprland-набор
    kitty
    waybar
    rofi
    mako

    # Системные диалоги и авторизация
    kdePackages.polkit-kde-agent-1

    # Скриншоты / буфер / цвет / ночной режим
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
    hyprpicker
    hyprsunset

    # Звук / медиа / яркость
    pavucontrol
    pamixer
    playerctl
    brightnessctl

    # Трей, уведомления, мелкие утилиты
    networkmanagerapplet
    libnotify
    jq
    xdg-utils
  ];
}
