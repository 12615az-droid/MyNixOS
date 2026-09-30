{ pkgs, ... }:

{
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable=true;
  };

  environment.systemPackages = with pkgs; [
     vulkan-tools
    mesa-demos
  ];
}
