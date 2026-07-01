{ pkgs, ... }:

{
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    vulkan-tools
    mesa-demos
  ];
}
