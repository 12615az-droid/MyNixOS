{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # KDE / GUI
    kdePackages.kate
    kdePackages.spectacle

    # Связь
    ayugram-desktop
    discord

    qbittorrent

    # Мультимедиа
    vlc
    strawberry
    darktable

    pavucontrol
    qpwgraph
    alsa-utils
nvtopPackages.full
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
    unrar
    tcpdump

    scrcpy

    iotop
    nethogs
    bandwhich
    fzf
  ];
}
