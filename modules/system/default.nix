{ ... }:

{
  imports = [
    ./boot.nix
    ./network.nix
    ./locale.nix
    ./nix-settings.nix
    ./swap.nix

    ./ssh.nix
  ];
}
