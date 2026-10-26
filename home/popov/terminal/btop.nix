# modules/home/btop.nix
{ pkgs, ... }:

{
  programs.btop = {
    enable = true;
    package = pkgs.btop;

    settings = {
      # ─────────────────────────────────────────────
      # NIX//UNDERGROUND
      # ─────────────────────────────────────────────

      color_theme = "nix-underground";

      # У нас свой глубокий фон из темы.
      theme_background = true;
      truecolor = true;
      force_tty = false;

      # Немного более "терминальный" характер.
      rounded_corners = false;

      # Уменьшает мерцание на поддерживаемых терминалах.
      terminal_sync = true;

      # Braille здесь выглядит особенно хорошо:
      # btop умеет использовать его для графиков высокой плотности.
      graph_symbol = "braille";
      graph_symbol_cpu = "braille";
      graph_symbol_mem = "braille";
      graph_symbol_net = "braille";
      graph_symbol_proc = "braille";

      shown_boxes = "cpu mem net proc";

      # Не слишком нервный мониторинг.
      update_ms = 1500;

      # ── Processes ────────────────────────────────

      proc_sorting = "cpu lazy";
      proc_reversed = false;
      proc_tree = false;

      proc_colors = true;
      proc_gradient = true;

      proc_per_core = false;
      proc_mem_bytes = true;
      proc_cpu_graphs = true;

      proc_info_smaps = false;

      # Процессы справа — классическая btop-композиция.
      proc_left = false;

      # Kernel threads иногда полезны при диагностике NixOS/Linux.
      proc_filter_kernel = false;

      proc_follow_detailed = true;
      proc_aggregate = false;

      # ── CPU ──────────────────────────────────────

      cpu_graph_upper = "Auto";
      cpu_graph_lower = "Auto";

      cpu_invert_lower = true;
      cpu_single_graph = false;
      cpu_bottom = false;

      show_uptime = true;

      check_temp = true;
      show_coretemp = true;

      temp_scale = "celsius";

      show_cpu_freq = true;
      freq_mode = "average";

      # Минималистичные часы наверху.
      clock_format = "%H:%M";

      # ── Memory / disks ───────────────────────────

      mem_graphs = true;
      mem_below_net = false;

      show_swap = true;

      # Не превращаем swap в отдельный "диск".
      swap_disk = false;

      show_disks = true;

      only_physical = true;

      show_io_stat = true;

      # Большой disk IO view можно включить вручную при диагностике.
      io_mode = false;
      io_graph_combined = false;

      # ── Network ──────────────────────────────────

      net_auto = true;
      net_sync = true;

      # ── Misc ─────────────────────────────────────

      show_battery = true;
      show_battery_watts = true;

      background_update = true;

      base_10_sizes = false;

      log_level = "WARNING";
    };

    themes = {
      nix-underground = ''
        # ┌──────────────────────────────────────────────┐
        # │          NIX // UNDERGROUND                 │
        # │                                              │
        # │  NixOS blue + muted violet + deep terminal   │
        # └──────────────────────────────────────────────┘

        # Core
        theme[main_bg]="#080b10"
        theme[main_fg]="#c7d0dd"

        # Box titles
        theme[title]="#7ebae4"

        # Keyboard shortcut highlights
        theme[hi_fg]="#a78bfa"

        # Selection
        theme[selected_bg]="#a78bfa"
        theme[selected_fg]="#080b10"

        # Quiet / inactive information
        theme[inactive_fg]="#596579"

        # Text inside graphs
        theme[graph_text]="#768399"

        # Background of meters
        theme[meter_bg]="#151b25"

        # Process details / miscellaneous
        theme[proc_misc]="#7ebae4"


        # ─────────────────────────────────────────────
        # BOXES
        #
        # Boxes intentionally don't all have the same
        # color. Difference is subtle enough to retain
        # the underground aesthetic.
        # ─────────────────────────────────────────────

        theme[cpu_box]="#5277c3"
        theme[mem_box]="#7ebae4"
        theme[net_box]="#8b7ac8"
        theme[proc_box]="#7289da"

        theme[div_line]="#293241"


        # ─────────────────────────────────────────────
        # TEMPERATURE
        #
        # Blue → violet → muted red.
        # Red exists only where it actually communicates
        # something useful.
        # ─────────────────────────────────────────────

        theme[temp_start]="#5277c3"
        theme[temp_mid]="#a78bfa"
        theme[temp_end]="#e06c75"


        # ─────────────────────────────────────────────
        # CPU
        #
        # Classic Nix Blue dominates.
        # Violet only appears toward high utilization.
        # ─────────────────────────────────────────────

        theme[cpu_start]="#5277c3"
        theme[cpu_mid]="#7ebae4"
        theme[cpu_end]="#a78bfa"


        # ─────────────────────────────────────────────
        # MEMORY
        # ─────────────────────────────────────────────

        # Free
        theme[free_start]="#293241"
        theme[free_mid]="#5277c3"
        theme[free_end]="#7ebae4"

        # Cached
        theme[cached_start]="#343b4d"
        theme[cached_mid]="#596579"
        theme[cached_end]="#7289da"

        # Available
        theme[available_start]="#5277c3"
        theme[available_mid]="#659ad2"
        theme[available_end]="#8bbfe5"

        # Used
        theme[used_start]="#5277c3"
        theme[used_mid]="#7ebae4"
        theme[used_end]="#a78bfa"


        # ─────────────────────────────────────────────
        # NETWORK
        #
        # RX = Nix
        # TX = Violet
        #
        # С первого взгляда понятно направление.
        # ─────────────────────────────────────────────

        theme[download_start]="#5277c3"
        theme[download_mid]="#659ad2"
        theme[download_end]="#7ebae4"

        theme[upload_start]="#665a99"
        theme[upload_mid]="#8b7ac8"
        theme[upload_end]="#a78bfa"


        # ─────────────────────────────────────────────
        # PROCESS LIST
        #
        # Очень сдержанный gradient:
        # активные процессы становятся ярче,
        # но список не превращается в RGB-парад.
        # ─────────────────────────────────────────────

        theme[process_start]="#7ebae4"
        theme[process_mid]="#7289da"
        theme[process_end]="#596579"
      '';
    };
  };
}
