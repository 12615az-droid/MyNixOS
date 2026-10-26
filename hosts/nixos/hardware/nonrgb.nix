{ pkgs, ... }:
{
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    # OpenRGB 1.1 expects a profile name and loads profiles/<name>.json.
    startupProfile = "nonrgb";
  };

  systemd.services.openrgb.preStart = ''
    ${pkgs.coreutils}/bin/install -Dm0644 \
      ${./nonrgb.json} \
      /var/lib/OpenRGB/profiles/nonrgb.json
  '';
}
