# modules/system/ssh.nix

{ ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;

    settings = {
      PermitRootLogin = "no";

      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      AllowUsers = [ "popov" ];
    };
  };
}
