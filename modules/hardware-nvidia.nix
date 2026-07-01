{ config, pkgs, ... }:

{
  # Используем проприетарный драйвер NVIDIA.
  services.xserver.videoDrivers = [ "nvidia" ];

  # OpenGL/Vulkan и 32-битные библиотеки для Steam/Proton.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    # Нужно для нормальной работы NVIDIA с Wayland/XWayland.
    modesetting.enable = true;

    # Утилита nvidia-settings.
    nvidiaSettings = true;

    # Для GTX 1060 нужен закрытый модуль.
    open = false;

    # Драйвер NVIDIA 580 legacy.
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

    # Фикс артефактов после сна.
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Держит NVIDIA-драйвер инициализированным.
    nvidiaPersistenced = true;
  };

  # Принудительно сохраняем видеопамять при suspend/resume.
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp
  '';
}