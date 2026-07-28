# Отдельный модуль NixOS для OBS Studio.
# Подключение в configuration.nix:
#   imports = [ ./obs.nix ];

{ lib, pkgs, ... }:

let
  # Включите только при использовании NVIDIA и если нужен CUDA-фильтр.
  useNvidiaCuda = false;

  # Дополнительные плагины. Проверка наличия делает файл совместимее
  # с разными версиями nixpkgs.
  pluginIfAvailable = name:
    lib.optional
      (builtins.hasAttr name pkgs.obs-studio-plugins)
      pkgs.obs-studio-plugins.${name};

  obsPlugins = lib.concatLists [
    # Захват экрана/окон в Wayland.
    (pluginIfAvailable "wlrobs")

    # Захват отдельных приложений и устройств через PipeWire.
    (pluginIfAvailable "obs-pipewire-audio-capture")

    # Источники и обработка через GStreamer.
    (pluginIfAvailable "obs-gstreamer")

    # Захват Vulkan/OpenGL-игр.
    (pluginIfAvailable "obs-vkcapture")

    # Аппаратное кодирование VAAPI, прежде всего для AMD/Intel.
    (pluginIfAvailable "obs-vaapi")

    # Удаление фона без хромакея.
    (pluginIfAvailable "obs-backgroundremoval")
  ];
in
{
  programs.obs-studio = {
    enable = true;

    # Подключает v4l2loopback и создаёт виртуальную камеру OBS.
    enableVirtualCamera = true;

    package = pkgs.obs-studio.override {
      cudaSupport = useNvidiaCuda;
    };

    plugins = obsPlugins;
  };

  # Современный аудиостек и захват экрана в Wayland.
  security.rtkit.enable = lib.mkDefault true;

  services.pipewire = {
    enable = lib.mkDefault true;
    alsa.enable = lib.mkDefault true;
    pulse.enable = lib.mkDefault true;
    jack.enable = lib.mkDefault true;
    wireplumber.enable = lib.mkDefault true;
  };

  # Портал нужен для захвата экрана/окон в Wayland.
  # Конкретный backend портала обычно добавляет модуль KDE/GNOME/Hyprland.
  xdg.portal.enable = lib.mkDefault true;

  # Полезные консольные инструменты для диагностики и конвертации видео.
  environment.systemPackages = with pkgs; [
    ffmpeg
    v4l-utils
  ];
}
