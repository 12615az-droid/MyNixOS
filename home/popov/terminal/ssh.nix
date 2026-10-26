{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."my-server" = {
      HostName = "141.98.166.105";
      User = "admin";
    };
  };
}
