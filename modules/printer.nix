{ pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

  users.users.popov.extraGroups = [
    "lp"
    "scanner"
  ];

  environment.systemPackages = with pkgs; [
    hplipWithPlugin
    simple-scan
  ];
}
