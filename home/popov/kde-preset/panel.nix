{ ... }:

{
  programs.plasma.panels = [
    {
      location = "bottom";

      # Панель на всю ширину
      lengthMode = "fill";
      screen ="all";

      # Не плавает над краем экрана
      floating = false;

      # Цельный непрозрачный фон
      opacity = "opaque";

      height = 48;

      # Автоматически скрывать
      hiding = "autohide";

      widgets = [
      {
        # Меню приложений
       kickoff = {
    icon = "nix-snowflake";
  };
  }
        # Закреплённые программы
        {
          iconTasks = {
            launchers = [
              "applications:org.kde.dolphin.desktop"
              "applications:org.kde.konsole.desktop"

              "applications:firefox.desktop"
              "applications:code.desktop"
              "applications:discord.desktop"
              "applications:steam.desktop"

              # Параметры системы
              "applications:systemsettings.desktop"

              # Virtual Machine Manager
              "applications:virt-manager.desktop"

              # KDE Connect
              "applications:org.kde.kdeconnect.app.desktop"

              # Android Studio
              "applications:android-studio.desktop"

              # Heroic Games Launcher
              "applications:com.heroicgameslauncher.hgl.desktop"

              # AyuGram
              "applications:com.ayugram.desktop.desktop"
            ];
          };
        }

        # Свободное пространство
        "org.kde.plasma.panelspacer"

        # Tray
        "org.kde.plasma.systemtray"

        # Часы
        "org.kde.plasma.digitalclock"

        # Показать рабочий стол
        "org.kde.plasma.showdesktop"
      ];
    }
  ];
}
