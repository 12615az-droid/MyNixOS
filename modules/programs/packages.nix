{ pkgs, ... }:

{


services.lact.enable = true;
hardware.amdgpu.overdrive.enable = true;
programs.coolercontrol.enable = true;


  services.flatpak.enable = true;




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

    cisco-packet-tracer_9
  ];
}
