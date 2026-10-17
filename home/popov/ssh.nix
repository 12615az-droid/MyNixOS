{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."my-server" = {
      hostname = "141.98.166.105";
      user = "admin";
    };
  };
}
