{ ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
     ll = "ls -lah";

     sbtop= "sudo btop";

      rebuild = "cd  ~/MyNixOS  && sudo nixos-rebuild switch --flake  .#nixos";
      nbuild = "cd  ~/MyNixOS  && sudo nixos-rebuild build --flake .#nixos";
      ntest = "cd   ~/MyNixOS  && sudo nixos-rebuild test --flake .#nixos";

      nclean = "sudo nix-collect-garbage -d";
      nupdate = "cd  ~/MyNixOS  && sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos";

      grep = "grep --color=auto";



      watchnvidia = "watch -n 1 nvidia-smi";





    };
  };
}
