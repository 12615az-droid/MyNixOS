{ config, pkgs, ... }:

{
  # Основной стек виртуализации: libvirt + QEMU/KVM.
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      # QEMU с поддержкой KVM. Это быстрые виртуалки через аппаратную виртуализацию.
      package = pkgs.qemu_kvm;

      # Эмуляция TPM. Нужно для Windows 11 и систем, которым нужен TPM.
      swtpm.enable = true;
    };
  };

  # USB-проброс в виртуалки через SPICE.
  virtualisation.spiceUSBRedirection.enable = true;

  # GUI-менеджер виртуалок.
  programs.virt-manager.enable = true;

  # Нужен GTK-приложениям, в том числе virt-manager.
  programs.dconf.enable = true;

  # По умолчанию используем системный libvirt, а не пользовательский qemu:///session.
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";

  # Доверяем NAT-интерфейсу libvirt.
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # Папки для ISO и дисков виртуалок.
  systemd.tmpfiles.rules = [
    "d /home/popov/VMs 0755 popov users -"
    "d /home/popov/VMs/images 0755 popov users -"
    "d /home/popov/Drives/HDD1/VMs 0755 popov users -"
    "d /home/popov/Drives/HDD1/VMs/iso 0755 popov users -"
  ];

  # Полезные утилиты для виртуалок.
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    dnsmasq
    swtpm
    spice
    spice-gtk
  ];
}
