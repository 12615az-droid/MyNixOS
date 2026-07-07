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

     nix2home = "mkdir -p ~/MyNixOS && rsync -av --delete --exclude .git --exclude result --exclude README.md --exclude .gitignore /etc/nixos/ ~/MyNixOS/";

      home2nix-check = "cd ~/MyNixOS && sudo rsync -av --dry-run --delete --chown=root:root --exclude .git --exclude result --exclude README.md --exclude .gitignore ./ /etc/nixos/";

      home2nix = "cd ~/MyNixOS && sudo rsync -av --delete --chown=root:root --exclude .git --exclude result --exclude README.md --exclude .gitignore ./ /etc/nixos/";
    };
  };
}
