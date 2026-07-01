{ config, pkgs, ... }:

{
  # Поддержка NTFS через kernel-драйвер ntfs3.
  # Нужно для твоих HDD, которые остались в NTFS.
  boot.supportedFilesystems = [ "ntfs3" ];

  # Папка, где будут лежать примонтированные диски.
  # tmpfiles создаст её при загрузке, если её нет.
  systemd.tmpfiles.rules = [
    "d /home/popov/Drives 0755 popov users -"
    "d /home/popov/Drives/HDD1 0755 popov users -"
    "d /home/popov/Drives/HDD2 0755 popov users -"
  ];

  # Первый NTFS-раздел HDD.
  fileSystems."/home/popov/Drives/HDD1" = {
    device = "/dev/disk/by-uuid/6C26324326320F18";
    fsType = "ntfs3";

    options = [
      # Чтение и запись.
      "rw"

      # Все файлы на NTFS будут выглядеть как принадлежащие popov.
      "uid=1000"
      "gid=100"

      # Права: владелец пишет, остальные читают.
      "umask=0022"

      # Запрещает имена файлов, несовместимые с Windows.
      "windows_names"

      # Не ломать загрузку системы, если диск вдруг отсутствует.
      "nofail"

      # Не монтировать сразу при старте, а подключать при первом обращении.
      "x-systemd.automount"

      # Если диском не пользовались 5 минут — размонтировать.
      "x-systemd.idle-timeout=300"

      # Не ждать диск долго при загрузке.
      "x-systemd.device-timeout=5s"
    ];
  };

  # Второй NTFS-раздел HDD.
  fileSystems."/home/popov/Drives/HDD2" = {
    device = "/dev/disk/by-uuid/0A966E5D966E48F1";
    fsType = "ntfs3";

    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "umask=0022"
      "windows_names"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=300"
      "x-systemd.device-timeout=5s"
    ];
  };
}
