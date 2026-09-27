{ ... }:

{
  networking.networkmanager.enable = true;

networking.firewall.allowedUDPPorts = [ 5353 ];

networking.networkmanager.wifi.powersave = false;


services.openssh = {
  enable = true;
  openFirewall = true;
};

services.tailscale.enable = true;
}
