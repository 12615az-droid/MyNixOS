{ ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
