{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

    # Графическая заставка вместо бегущих сообщений
    plymouth.enable = true;

    # Показывать только ошибки ядра
    consoleLogLevel = 3;

    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];



extraModprobeConfig = ''
  options rtw89_core disable_ps_mode=Y
'';


extraModulePackages = [
    config.boot.kernelPackages.nct6687d
  ];

  kernelModules = [ "nct6687" ];

 blacklistedKernelModules = [
    "nct6683"
  ];
 };

}
