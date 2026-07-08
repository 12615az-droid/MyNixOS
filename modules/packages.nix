{ pkgs, ... }:

{
  programs.firefox.enable = true;

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    wget
    micro
    vim

    pciutils
    usbutils

    adwaita-icon-theme
 
    kdePackages.ksystemstats


    kdePackages.partitionmanager
    ntfs3g
    parted
    smartmontools

    lm_sensors
  ];
}
