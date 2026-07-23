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


  # По умолчанию используем системный libvirt, а не пользовательский qemu:///session.
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";





networking = {
  firewall = {
    trustedInterfaces = [ "virbr0" ];

    interfaces."wlp0s20f0u8".allowedUDPPorts = [ 51820 ];

    extraCommands = ''
      iptables -w -C FORWARD -i wlp0s20f0u8 -o virbr0 \
        -p udp -d 192.168.122.60 --dport 51820 -j ACCEPT 2>/dev/null \
        || iptables -w -I FORWARD 1 -i wlp0s20f0u8 -o virbr0 \
        -p udp -d 192.168.122.60 --dport 51820 -j ACCEPT

      iptables -w -C FORWARD -i virbr0 -o wlp0s20f0u8 \
        -p udp -s 192.168.122.60 --sport 51820 \
        -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 2>/dev/null \
        || iptables -w -I FORWARD 1 -i virbr0 -o wlp0s20f0u8 \
        -p udp -s 192.168.122.60 --sport 51820 \
        -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    '';

    extraStopCommands = ''
      iptables -w -D FORWARD -i wlp0s20f0u8 -o virbr0 \
        -p udp -d 192.168.122.60 --dport 51820 -j ACCEPT 2>/dev/null || true

      iptables -w -D FORWARD -i virbr0 -o wlp0s20f0u8 \
        -p udp -s 192.168.122.60 --sport 51820 \
        -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 2>/dev/null || true
    '';
  };

  nat = {
    enable = true;
    externalInterface = "wlp0s20f0u8";
    internalInterfaces = [ "virbr0" ];

    forwardPorts = [
      {
        sourcePort = 51820;
        destination = "192.168.122.60:51820";
        proto = "udp";
      }
    ];
  };
};
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
