# modules/home/bottom.nix
{ pkgs, ... }:

{
  programs.bottom = {
    enable = true;
    package = pkgs.bottom;

    settings = {
      flags = {
        # Спокойное обновление, без мельтешения.
        rate = "1s";

        temperature_type = "c";
        default_time_value = "60s";

        # Тонкая линия вместо пустого пространства в таблицах.
        table_gap = "line";

        # Маленький индикатор положения в длинных списках.
        show_table_scroll_position = true;
      };

      cpu = {
        default = "average";
        show_decimal = true;
      };

      processes = {
        default_sort = "CPU%";
        default_memory_value = true;

        # Я бы оставил обычный список:
        # визуально чище и ближе к "операторской".
        default_tree = false;

        hide_k_threads = false;
      };

      # ─────────────────────────────────────────────
      # NIX//UNDERGROUND palette
      #
      # bg       #080b10
      # surface  #11151d
      # nix blue #7ebae4
      # nix dark #5277c3
      # purple   #a78bfa
      # muted    #596579
      # text     #c7d0dd
      # ─────────────────────────────────────────────

      styles = {
        # Берём дефолт только как основу;
        # всё заметное ниже переопределяется.
        theme = "default";

        cpu = {
          all_entry_colour = "#7ebae4";
          avg_entry_colour = "#a78bfa";

          cpu_core_colours = [
            "#7ebae4"
            "#5277c3"
            "#8bbfe5"
            "#7289da"
            "#a78bfa"
            "#8b7ac8"
            "#659ad2"
            "#9d8bea"
          ];
        };

        temp_graph = {
          temp_graph_colour_styles = [
            "#7ebae4"
            "#5277c3"
            "#a78bfa"
            "#8b7ac8"
          ];
        };

        memory = {
          # RAM — главный NixOS blue.
          ram_colour = "#7ebae4";

          # Cache чуть приглушён.
          cache_colour = "#5277c3";

          # Purple появляется, но не захватывает интерфейс.
          swap_colour = "#a78bfa";
          arc_colour = "#7289da";

          gpu_colours = [
            "#7ebae4"
            "#a78bfa"
            "#5277c3"
            "#8b7ac8"
          ];
        };

        network = {
          rx_colour = "#7ebae4";
          tx_colour = "#a78bfa";

          rx_total_colour = "#5277c3";
          tx_total_colour = "#8b7ac8";
        };

        battery = {
          high_battery_colour = "#7ebae4";
          medium_battery_colour = "#a78bfa";
          low_battery_colour = "#e06c75";
        };

        tables = {
          headers = {
            colour = "#7ebae4";
            bold = true;
          };
        };

        graphs = {
          # Сетка намеренно почти незаметная.
          graph_colour = "#293241";

          legend_text = {
            colour = "#768399";
          };
        };

        widgets = {
          # Не чистый black — выглядит глубже.
          bg_colour = "#080b10";

          border_colour = "#293241";

          # Активный виджет — Nix Blue.
          selected_border_colour = "#7ebae4";

          widget_title = {
            colour = "#a78bfa";
            bold = true;
          };

          text = {
            colour = "#c7d0dd";
          };

          disabled_text = {
            colour = "#596579";
          };

          # Главный акцент интерфейса:
          # фиолетовый selection на тёмном тексте.
          selected_text = {
            colour = "#080b10";
            bg_colour = "#a78bfa";
            bold = true;
          };

          # Linux threads.
          thread_text = {
            colour = "#7ebae4";
          };
        };
      };

      # ─────────────────────────────────────────────
      # Layout
      #
      #         CPU
      # ─────────────────
      #   MEMORY │ TEMP
      #          │ DISK
      # ─────────────────
      # NETWORK  │ PROCESSES
      #          │ PROCESSES
      #
      # Процессы получают больше всего пространства.
      # ─────────────────────────────────────────────

      row = [
        {
          ratio = 24;

          child = [
            {
              type = "cpu";
            }
          ];
        }

        {
          ratio = 28;

          child = [
            {
              ratio = 4;
              type = "mem";
            }

            {
              ratio = 3;

              child = [
                {
                  type = "temp";
                }

                {
                  type = "disk";
                }
              ];
            }
          ];
        }

        {
          ratio = 48;

          child = [
            {
              ratio = 2;
              type = "net";
            }

            {
              ratio = 5;
              type = "proc";
              default = true;
            }
          ];
        }
      ];
    };
  };
}
