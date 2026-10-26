{ pkgs, ... }:
{
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    # OpenRGB 1.1 expects a profile name and loads profiles/<name>.json.
    startupProfile = "nonrgb";
  };

  systemd.services.openrgb.preStart = ''
    ${pkgs.coreutils}/bin/mkdir -p /var/lib/OpenRGB/profiles
    ${pkgs.coreutils}/bin/ln -sfn \
      ${./nonrgb.json} \
      /var/lib/OpenRGB/profiles/nonrgb.json
  '';
}
