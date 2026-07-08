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
    "d /home/popov/Drives/Toshiba 0755 popov users -"

  ];

   # HDD 2 TB, ext4.
  fileSystems."/home/popov/Drives/HDD1" = {
    device = "/dev/disk/by-uuid/5f24ca9f-aa5b-4807-b66e-ac8e621ef819";
    fsType = "ext4";

    options = [
      "rw"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=300"
      "x-systemd.device-timeout=5s"
    ];
  };

   # Отдельный HDD Toshiba 500 GB, ext4.
  fileSystems."/home/popov/Drives/Toshiba" = {
    device = "/dev/disk/by-uuid/5297134a-6914-48ab-bac9-8ae884e9b05f";
    fsType = "ext4";

    options = [
      "rw"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=300"
      "x-systemd.device-timeout=5s"
    ];
  };
}
