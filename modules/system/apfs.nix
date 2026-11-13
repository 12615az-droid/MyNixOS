
{ config, pkgs, ... }:

{
  boot.extraModulePackages = [
    config.boot.kernelPackages.apfs
  ];

  boot.kernelModules = [ "apfs" ];
}
