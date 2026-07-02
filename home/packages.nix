{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # KDE / GUI
    kdePackages.kate
    kdePackages.spectacle

    # Связь
    ayugram-desktop
    discord

    # Мультимедиа
    vlc
    strawberry
    darktable

    # Офис
    libreoffice-qt

    # Пользовательские утилиты
    fastfetch
    btop
    htop
    tree
    duf
    unzip
    zip
    p7zip

    # Учёт активности
    activitywatch
  ];
}
