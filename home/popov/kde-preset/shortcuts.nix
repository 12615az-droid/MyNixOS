{ ... }:

{
  programs.plasma = {
    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Return";
      command = "konsole";
    };

    shortcuts = {
      # Win / Meta → меню приложений
      plasmashell = {
        "activate application launcher" = [
          "Meta"
          "Alt+F1"
        ];
      };

      # Управление окнами
      kwin = {
        "Window Close" = "Meta+Q";
        "Expose" = "Meta+,";
        "Overview" = "Meta+W";
      };
    };
  };
}
