{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
    libreoffice

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

