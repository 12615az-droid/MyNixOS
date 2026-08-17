{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "my-server" = {
        hostname = "83.171.227.174";
        user = "admin";
      identityFile = "/run/agenix/server-ssh";
        identitiesOnly = true;
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
      identityFile = "/run/agenix/github-ssh";
        identitiesOnly = true;
      };
    };
  };
}



