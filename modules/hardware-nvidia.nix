{ config, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Использовать драйвер NVIDIA.
  # Название xserver историческое — Wayland продолжает работать.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Отключить Intel UHD 730 в обычной NVIDIA-конфигурации.
  # В резервной specialisation этот параметр потом переопределим.
 # boot.kernelParams = [
 #   "module_blacklist=i915"
 # ];

 # boot.blacklistedKernelModules = [
   # "i915"
 # ];

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
