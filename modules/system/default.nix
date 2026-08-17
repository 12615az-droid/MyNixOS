{ ... }:

{
  imports = [
    ./boot.nix
    ./network.nix
    ./locale.nix
    ./nix-settings.nix
    ./swap.nix
  ./secrets.nix
    ./ssh.nix
    ./vpn.nix
  ];
}
