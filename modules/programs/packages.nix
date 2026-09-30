{ pkgs, ... }:

{
programs.firefox = {
  enable = true;

  languagePacks = [ "ru" ];

  preferences = {
    "intl.locale.requested" = "ru";
  };
};

services.lact.enable = true;
hardware.amdgpu.overdrive.enable = true;
programs.coolercontrol.enable = true;

  services.printing.enable = true;
  services.flatpak.enable = true;


  services.hardware.openrgb = {
  enable = true;
  motherboard = "amd";
};

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
