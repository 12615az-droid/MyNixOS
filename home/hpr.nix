{ config, lib, pkgs, ... }:

let
  version = "0.9.5";
  tag = "v${version}";
  archive = "HPRv${version}-Linux.tar.xz";
  releaseUrl = "https://github.com/plexescor/HPR/releases/download/${tag}/${archive}";
in
{
  home.packages = with pkgs; [
    curl
    gnutar
    xz
    dbus
    kdePackages.qttools
  ];

  home.activation.installHpr = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    set -eu