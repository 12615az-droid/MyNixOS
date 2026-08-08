# obs.nix
{ lib, ... }:

{
  programs.obs-studio.enable = true;

  security.rtkit.enable = lib.mkDefault true;

  services.pipewire = {
    enable = lib.mkDefault true;
    alsa.enable = lib.mkDefault true;
    pulse.enable = lib.mkDefault true;
    wireplumber.enable = lib.mkDefault true;
  };

  xdg.portal.enable = lib.mkDefault true;
}
