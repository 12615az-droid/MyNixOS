{ pkgs, ... }:

{
  # Загружает Intel i915 заранее — до запуска графической оболочки
  boot.initrd.kernelModules = [ "i915" ];

  # Не даём NVIDIA/nouveau захватить видеокарту.
  # Этот модуль рассчитан на работу только через Intel UHD 730.
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
  ];

  # Прошивки Intel для графики и аппаратного видеодекодирования
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;

    # Steam, Wine и другие 32-битные приложения
    enable32Bit = true;

    extraPackages = with pkgs; [
      # VA-API для современных Intel, включая UHD 730
      intel-media-driver

      # Intel Quick Sync Video
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables = {
    # Современный VA-API-драйвер Intel
    LIBVA_DRIVER_NAME = "iHD";
  };
}
