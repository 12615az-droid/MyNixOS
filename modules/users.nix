{ ... }:

{
  users.users."popov" = {
    isNormalUser = true;
    description = "Popov";
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "libvirtd"
    ];

    
  };
}
