{ ... }:

{
  users.users."popov" = {
    isNormalUser = true;
    uid = 1000;
    description = "Popov";
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "libvirtd"
    ];

    
  };
}
