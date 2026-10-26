{ config, pkgs, ... }:

{

  programs.mangohud = {
    enable = true;

    # ============================================================
    # FULL — полная диагностика
    # ~/.config/MangoHud/MangoHud.conf
    # ============================================================
    settings = {
      # Расположение и внешний вид
      position = "top-left";
      font_size = 18;
      background_alpha = 0.35;
      round_corners = 8;
      table_columns = 3;
      text_outline = true;

      # FPS и плавность
      fps = true;
      frametime = true;
      frame_timing = true;
      dynamic_frame_timing = true;
      fps_metrics = "avg,0.01,0.001";
      fps_sampling_period = 500;
      show_fps_limit = true;

      # Видеокарта
      gpu_stats = true;
      gpu_name = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_power = true;
      gpu_power_limit = true;
      gpu_fan = true;
      gpu_efficiency = true;
      throttling_status = true;

      # Видеопамять
      vram = true;
      proc_vram = true;

      # Процессор
      cpu_stats = true;
      cpu_temp = true;
      cpu_mhz = true;
      cpu_power = true;
      cpu_efficiency = true;

      # Загрузка каждого ядра
      core_load = true;
      core_load_change = true;

      # Оперативная память и swap
      ram = true;
      swap = true;

      # Память процесса
      procmem = true;
      procmem_shared = true;

      # Диск
      io_read = true;
      io_write = true;

      # Игра / графический стек
      engine_version = true;
      wine = true;
      winesync = true;
      present_mode = true;
      gamemode = true;
      resolution = true;
      display_server = true;
      exec_name = true;
      arch = true;
    };

    # ============================================================
    # LITE — компактный мониторинг
    # ~/.config/MangoHud/lite.conf
    # ============================================================
    settingsPerApplication = {
      lite = {
        # Компактный внешний вид
        position = "top-left";
        font_size = 16;
        background_alpha = 0.30;
        round_corners = 6;
        table_columns = 2;
        text_outline = true;
        hud_compact = true;

        # Главное для оценки плавности
        fps = true;
        frametime = true;
        fps_sampling_period = 500;

        # GPU
        gpu_stats = true;
        gpu_temp = true;
        gpu_power = true;
        vram = true;

        # CPU
        cpu_stats = true;
        cpu_temp = true;
        cpu_power = true;

        # RAM
        ram = true;

        # Полезные статусы
        gamemode = true;
        present_mode = true;
      };
    };
  };
  home.packages = [
  # Полный MangoHud
  (pkgs.writeShellScriptBin "mangohud-full" ''
    export MANGOHUD_CONFIGFILE="''${XDG_CONFIG_HOME:-$HOME/.config}/MangoHud/MangoHud.conf"
    exec ${config.programs.mangohud.package}/bin/mangohud "$@"
  '')

  # Облегчённый MangoHud
  (pkgs.writeShellScriptBin "mangohud-lite" ''
    export MANGOHUD_CONFIGFILE="''${XDG_CONFIG_HOME:-$HOME/.config}/MangoHud/lite.conf"
    exec ${config.programs.mangohud.package}/bin/mangohud "$@"
  '')
];
}
