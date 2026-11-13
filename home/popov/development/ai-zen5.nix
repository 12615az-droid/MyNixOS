
{ pkgs, ... }:

let
  sdZen5 = pkgs.stable-diffusion-cpp-vulkan.overrideAttrs (old: {
    NIX_CFLAGS_COMPILE =
      (old.NIX_CFLAGS_COMPILE or "")
      + " -march=znver5 -mtune=znver5";
  });

  sdZen5Wrapped = pkgs.runCommand "stable-diffusion-cpp-zen5" {
    nativeBuildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p "$out/bin"

    makeWrapper ${sdZen5}/bin/sd-server "$out/bin/sd-server-zen5"
  '';
in
{
  home.packages = [
    sdZen5Wrapped
  ];
}
