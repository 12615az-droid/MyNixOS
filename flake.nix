{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    mytop-linux = {
      url = "path:/home/popov/MyProject/MyTopLinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    olhm = {
      url = "path:/home/popov/MyProject/olhm";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, home-manager, plasma-manager, mytop-linux, olhm, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix

        {
          nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
        }

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            # Сохранять конфликтующие файлы
            backupFileExtension = "hm-backup";

            extraSpecialArgs = {
              inherit mytop-linux olhm;
            };

            sharedModules = [
              plasma-manager.homeModules.plasma-manager
            ];
          };
        }
      ];
    };
  };
}
