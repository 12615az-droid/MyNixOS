{ pkgs, ... }:

{


  services.hardware.openrgb = {
  enable = true;
  motherboard = "amd";
  startupProfile = "norm2.orp";
};
systemd.services.openrgb.preStart = ''
cp -f ${./norm2.orp} /var/lib/OpenRGB/norm2.orp
'';

}
