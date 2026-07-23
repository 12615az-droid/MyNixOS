{ config, pkgs, lib, ... }:

{
  # Intel + NVIDIA.
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  # Intel должна запускаться как можно раньше.
  boot.initrd.kernelModules = [ "i915" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      # Аппаратное декодирование видео Intel UHD 730.
      intel-media-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;

    # GTX 1060 требует закрытого модуля.
    open = false;

    # GTX 1060 относится к Pascal и использует legacy 580.
    package =
      config.boot.kernelPackages.nvidiaPackages.legacy_580;

    powerManagement.enable = true;
    powerManagement.finegrained = false;

    nvidiaPersistenced = true;

    # Пока PRIME-режимы не включаем.
    # Для Wayland оба GPU доступны композитору напрямую.
  };

  # Сохранение видеопамяти при suspend/resume.
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp
  '';
}
