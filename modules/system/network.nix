{ ... }:

{
  networking.networkmanager.enable = true;

networking.firewall.allowedUDPPorts = [ 5353 ];

networking.networkmanager.wifi.powersave = false;



services.tailscale.enable = true;
}
