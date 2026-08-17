{ pkgs, ... }:

let
  theme = import ./theme.nix { inherit pkgs; };
in
{
  programs.plasma.kscreenlocker = {
    lockOnResume = false;
    timeout = 0;

    appearance.wallpaperSlideShow = {
      path = theme.wallpaperDir;
      interval = 24 * 60 * 60;
    };
  };
}
