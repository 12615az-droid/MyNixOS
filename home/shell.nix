{ ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      ll = "ls -lah";

      rebuild = "sudo nixos-rebuild switch --flake ~/MyNixOS#nixos";
      nbuild = "sudo nixos-rebuild build --flake ~/MyNixOS#nixos";
      ntest = "sudo nixos-rebuild test --flake ~/MyNixOS#nixos";

      nclean = "sudo nix-collect-garbage -d";
      nupdate = "cd ~/MyNixOS && sudo nix flake update && sudo nixos-rebuild switch --flake ~/MyNixOS#nixos";

      grep = "grep --color=auto";



      watchnvidia = "watch -n 1 nvidia-smi";





    };
  };
}
