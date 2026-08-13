{ config, ... }:

{


  # Использовать драйвер NVIDIA.
  # Название xserver историческое — Wayland продолжает работать.
  services.xserver.videoDrivers = [ "nvidia" ];


  hardware.nvidia = {
    # GTX 1060 — Pascal
    open = false;

    # DRM/KMS для KDE Wayland
    modesetting.enable = true;

    powerManagement = {
      # Сохранение видеопамяти
      enable = true;
      finegrained = false;
    };

    package =
      config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
}
