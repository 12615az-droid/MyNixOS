{ ... }:

{
boot = {
  loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
      editor = false;
    };

    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

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
};

}

