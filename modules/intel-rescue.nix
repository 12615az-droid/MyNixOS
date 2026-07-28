{ ... }:

{
  specialisation.intel-rescue = {
    inheritParentConfig = true;

    configuration = { lib, ... }: {
      # Название будет видно в загрузчике
      system.nixos.tags = [ "intel-rescue" ];

      # Подключаем ранее созданный модуль UHD 730
      imports = [
        ./intel.nix
      ];

      # Полностью исключаем NVIDIA из выбора графического драйвера.
      # Эта опция не включает X11 — KDE продолжит работать на Wayland.
      services.xserver.videoDrivers =
        lib.mkForce [ "modesetting" ];

      # Отключаем параметры NVIDIA, унаследованные от основной системы
      hardware.nvidia = {
        modesetting.enable =
          lib.mkForce false;

        powerManagement.enable =
          lib.mkForce false;

        powerManagement.finegrained =
          lib.mkForce false;

        nvidiaSettings =
          lib.mkForce false;
      };

      # Дополнительная страховка: вообще не загружать модули GTX 1060
      boot.blacklistedKernelModules = lib.mkAfter [
        "nouveau"
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidiafb"
      ];
    };
  };
}
