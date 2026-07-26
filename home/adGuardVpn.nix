{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wireguard-tools
    qrencode
    openssh
  ];
}
