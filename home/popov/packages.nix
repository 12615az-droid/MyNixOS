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
    inkscape

    pavucontrol
    qpwgraph
    alsa-utils
nvtopPackages.full
    # Офис
    libreoffice-qt

    # Пользовательские утилиты
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
