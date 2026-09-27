{ ... }:

{
  boot = {
    # Графическая заставка вместо бегущих сообщений
    plymouth.enable = true;

    # Показывать только ошибки ядра
    consoleLogLevel = 3;

    # Убрать обычные сообщения ранней загрузки NixOS
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];



extraModprobeConfig = ''
  options rtw89_core disable_ps_mode=Y
'';
  };
}
