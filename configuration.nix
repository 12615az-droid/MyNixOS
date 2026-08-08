{ ... }:

{
  imports = [
    ./hosts/nixos
    ./modules
    ./home
  ];

  system.stateVersion = "26.05";
}
