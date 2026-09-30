{ config, pkgs, ... }:

{

programs.zed-editor = {
  enable = true;

  # Сделать Zed редактором по умолчанию для EDITOR/VISUAL
  defaultEditor = true;

  # Расширения Zed
  extensions = [
    "nix"

  ];
  extraPackages = with pkgs; [
  nixd
];

  userSettings = {
    # Автосохранение при уходе с файла
    autosave = "on_focus_change";

    # Форматировать код при сохранении
    format_on_save = "on";

    # Размеры интерфейса
    ui_font_size = 16;
    buffer_font_size = 15;

    # Встроенный терминал открывается в проекте
    terminal = {
      working_directory = "current_project_directory";
    };

    # Настройки конкретно Rust
    languages = {
      Rust = {
        formatter = "language_server";
        format_on_save = "on";
      };
    };
  };
};


}
