{ pkgs, ... }:

{
  programs.btop = {
    enable = true;
    package = pkgs.btop;

    settings = {
      # Цветовая тема ниже
      color_theme = "nixos-fastfetch";
      theme_background = false;
      truecolor = true;

      # Интерфейс
      rounded_corners = true;
      terminal_sync = true;
      disable_mouse = false;
      vim_keys = true;

      # Block не требует Nerd Font и надёжнее отображается в Konsole
      graph_symbol = "block";
      graph_symbol_cpu = "block";
      graph_symbol_mem = "block";
      graph_symbol_net = "block";
      graph_symbol_proc = "block";

      # Все основные панели
      shown_boxes = "cpu mem net proc";

      # Обновление раз в две секунды
      update_ms = 2000;

      # Верхняя строка
      clock_format = "%H:%M:%S  /user@/host";

      # CPU
      cpu_graph_upper = "total";
      cpu_graph_lower = "user";
      cpu_invert_lower = true;
      cpu_single_graph = false;
      cpu_bottom = false;

      show_uptime = true;
      show_cpu_freq = true;
      freq_mode = "average";

      check_temp = true;
      show_coretemp = true;

      # NVIDIA/Intel GPU будут показаны при доступности
      show_gpu_info = "Auto";

      # Для ватт нужны дополнительные права, поэтому отключено
      show_cpu_watts = false;

      # Память и диски
      mem_graphs = true;
      mem_below_net = false;

      show_swap = true;
      swap_disk = false;

      show_disks = true;

      # Показывать все физические диски без фильтра
      disks_filter = "";
      only_physical = true;
      use_fstab = false;

      disk_free_priv = false;
      show_io_stat = true;
      io_mode = false;
      io_graph_combined = false;

      # Сеть
       net_auto = true;
   net_sync = true;
      swap_upload_download = false;
      base_10_bitrate = "Auto";

      # Процессы
      proc_sorting = "cpu lazy";
      proc_reversed = false;
      proc_tree = false;

      proc_colors = true;
      proc_gradient = true;
      proc_per_core = false;
      proc_mem_bytes = true;
      proc_cpu_graphs = true;

      proc_info_smaps = false;
      proc_left = false;
      proc_filter_kernel = false;
      proc_follow_detailed = true;
      proc_aggregate = false;
      proc_tree_auto_collapse = 4;
      keep_dead_proc_usage = true;

      # Если батареи нет, этот элемент просто не появится
      show_battery = true;
      selected_battery = "Auto";
      show_battery_watts = true;

      base_10_sizes = false;
      temp_scale = "celsius";

      # Home Manager управляет файлом, btop не должен его перезаписывать
      save_config_on_exit = false;
      log_level = "WARNING";
    };

    themes = {
      "nixos-fastfetch" = ''
        # NixOS cyan / blue / magenta

        # Прозрачный фон
        theme[main_bg]="#00"

        # Основной текст
        theme[main_fg]="#cad3f5"
        theme[title]="#8aadf4"
        theme[hi_fg]="#8bd5ca"
        theme[inactive_fg]="#6e738d"

        # Выбранный процесс
        theme[selected_bg]="#363a4f"
        theme[selected_fg]="#cad3f5"

        # Текст графиков и фон шкал
        theme[graph_text]="#6e738d"
        theme[meter_bg]="#363a4f"
        theme[proc_misc]="#c6a0f6"

        # Рамки панелей
        theme[cpu_box]="#8bd5ca"
        theme[mem_box]="#8aadf4"
        theme[net_box]="#7dc4e4"
        theme[proc_box]="#c6a0f6"
        theme[div_line]="#494d64"

        # Температура
        theme[temp_start]="#8bd5ca"
        theme[temp_mid]="#8aadf4"
        theme[temp_end]="#c6a0f6"

        # CPU
        theme[cpu_start]="#8bd5ca"
        theme[cpu_mid]="#8aadf4"
        theme[cpu_end]="#c6a0f6"

        # Свободная память и диски
        theme[free_start]="#8bd5ca"
        theme[free_mid]="#7dc4e4"
        theme[free_end]="#8aadf4"

        # Кэш
        theme[cached_start]="#7dc4e4"
        theme[cached_mid]="#8aadf4"
        theme[cached_end]="#b7bdf8"

        # Доступная память
        theme[available_start]="#8aadf4"
        theme[available_mid]="#b7bdf8"
        theme[available_end]="#c6a0f6"

        # Использованная память и диски
        theme[used_start]="#8aadf4"
        theme[used_mid]="#b7bdf8"
        theme[used_end]="#c6a0f6"

        # Загрузка сети
        theme[download_start]="#8bd5ca"
        theme[download_mid]="#7dc4e4"
        theme[download_end]="#8aadf4"

        # Отдача сети
        theme[upload_start]="#8aadf4"
        theme[upload_mid]="#b7bdf8"
        theme[upload_end]="#c6a0f6"

        # Процессы
        theme[process_start]="#8bd5ca"
        theme[process_mid]="#8aadf4"
        theme[process_end]="#c6a0f6"

        # Пауза и слежение за процессом
        theme[proc_pause_bg]="#8aadf4"
        theme[proc_follow_bg]="#c6a0f6"
        theme[proc_banner_bg]="#494d64"
        theme[proc_banner_fg]="#cad3f5"

        theme[followed_bg]="#363a4f"
        theme[followed_fg]="#8bd5ca"
      '';
    };
  };
}
