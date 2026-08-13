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


    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhSu0TZaTy5aO/Q7yO+H6Mb9o3qzSebIJRxVGmJVwhu мойпк"
    ];
    
  };
}
