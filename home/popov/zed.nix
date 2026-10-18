
{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    defaultEditor = true;

    # ─────────────────────────────────────────────
    # NIX//UNDERGROUND — ZED
    # Kotlin / Jetpack Compose / Nix / Rust
    # ─────────────────────────────────────────────

    extensions = [
      "nix"
      "kotlin"
      "java"
      "xml"
    ];

    extraPackages = with pkgs; [
      # Nix
      nixd
      nixfmt



      # Шрифты
      jetbrains-mono
    ];

    userSettings = {

      # ── NIX//UNDERGROUND ──────────────────────

      theme = {
        mode = "dark";
        dark = "One Dark";
        light = "One Light";
      };

      # Переопределение цветов One Dark
      theme_overrides = {
        "One Dark" = {
          # Основные поверхности
          "background" = "#080b10";
          "surface.background" = "#0d1119";
          "elevated_surface.background" = "#151b25";
          "editor.background" = "#080b10";
          "editor.foreground" = "#c7d0dd";
          "editor.gutter.background" = "#080b10";

          # Активная строка и выделение
          "editor.active_line.background" = "#151b25";
          "editor.selection.background" = "#293a55";
          "editor.line_number" = "#596579";
          "editor.active_line_number" = "#7ebae4";

          # Рамки
          "border" = "#293241";
          "border.variant" = "#151b25";
          "border.focused" = "#7ebae4";

          # Панели
          "panel.background" = "#0d1119";
          "status_bar.background" = "#080b10";
          "tab_bar.background" = "#0d1119";
          "tab.active_background" = "#151b25";
          "tab.inactive_background" = "#0d1119";

          # Основные акцентные цвета
          "text" = "#c7d0dd";
          "text.muted" = "#768399";
          "text.accent" = "#7ebae4";

          # Подсветка кода
          syntax = {
            keyword = {
              color = "#a78bfa";
            };
            string = {
              color = "#8bbfe5";
            };
            number = {
              color = "#e5b97e";
            };
            comment = {
              color = "#596579";
              font_style = "italic";
            };
            type = {
              color = "#7ebae4";
            };
            function = {
              color = "#8bafe0";
            };
          };

          accents = [
            "#5277c3"
            "#7ebae4"
            "#a78bfa"
            "#8b7ac8"
            "#7289da"
            "#e06c75"
          ];
        };
      };

      # ── Интерфейс ─────────────────────────────

      ui_font_family = "JetBrains Mono";
      ui_font_size = 16;

      buffer_font_family = "JetBrains Mono";
      buffer_font_size = 15;

      # Редактор
      autosave = "on_focus_change";
      format_on_save = "on";

      show_whitespaces = "selection";
      preferred_line_length = 100;
      soft_wrap = "none";

      # Подсказки типов и параметров
      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
      };

      # Сохраняем стандартные исключения Zed
      file_scan_exclusions = [
        "**/.gradle"
        "**/build"
        "**/.cxx"
        "**/.idea"
        "**/captures"
        "..."
      ];

      # ── Терминал ───────────────────────────────

      terminal = {
        working_directory = "current_project_directory";
        font_family = "JetBrains Mono";
        font_size = 14;
        line_height = "standard";
      };

      # ── Языки ─────────────────────────────────

      languages = {

        # Kotlin / Jetpack Compose
        Kotlin = {
          tab_size = 4;
          hard_tabs = false;
          preferred_line_length = 120;

          # Kotlin LSP не гарантирует форматирование.
          # Gradle/ktlint лучше подключать отдельно.
          format_on_save = "off";
        };

        # Java
        Java = {
          tab_size = 4;
          hard_tabs = false;
        };

        # Разметка Android
        XML = {
          tab_size = 4;
          hard_tabs = false;
        };

        # Rust
        Rust = {
          formatter = "language_server";
          format_on_save = "on";
        };

        # Nix
        Nix = {
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [];
            };
          };
          format_on_save = "on";
        };
      };
    };
  };
}
