{ ... }:

{
  networking.networkmanager.enable = true;

networking.firewall.allowedUDPPorts = [ 5353 ];


services.openssh = {
  enable = true;
  openFirewall = true;
};

services.tailscale.enable = true;
}
