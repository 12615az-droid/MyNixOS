
{ pkgs, ... }:

{
  # Отдельная группа для чтения энергопотребления
  users.groups.rapl = {};

  # Доступ пользователю popov
  users.users.popov.extraGroups = [ "rapl" ];

  # Права на счётчики RAPL
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="powercap", KERNEL=="intel-rapl:*", RUN+="${pkgs.coreutils}/bin/chgrp rapl /sys%p/energy_uj", RUN+="${pkgs.coreutils}/bin/chmod 0440 /sys%p/energy_uj"
  '';
}
