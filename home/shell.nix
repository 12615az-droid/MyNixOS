{ ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      ll = "ls -lah";

      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      nbuild = "sudo nixos-rebuild build --flake /etc/nixos#nixos";
      ntest = "sudo nixos-rebuild test --flake /etc/nixos#nixos";

      nclean = "sudo nix-collect-garbage -d";
      nupdate = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake /etc/nixos#nixos";

      grep = "grep --color=auto";
    };
  };
}
