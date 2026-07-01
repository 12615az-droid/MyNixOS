{ pkgs, ... }:

{
  programs.firefox.enable = true;

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    wget
    micro
    vim

    fastfetch
    btop
    htop
    tree
    unzip
    zip
    p7zip
    duf

    pciutils
    usbutils

    libreoffice-qt
    darktable

    strawberry
    vlc

    ayugram-desktop
    discord

    adwaita-icon-theme
    activitywatch

    kdePackages.ksystemstats
    kdePackages.spectacle

    lm_sensors
  ];
}
