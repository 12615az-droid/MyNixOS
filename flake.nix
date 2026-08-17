   {
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

agenix = {
  url = "github:ryantm/agenix";
  inputs.nixpkgs.follows = "nixpkgs";
};
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager,agenix, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

     modules = [
  ./configuration.nix

  agenix.nixosModules.default

  home-manager.nixosModules.home-manager

  {
    environment.systemPackages = [
      agenix.packages.x86_64-linux.default
    ];

    home-manager.sharedModules = [
      plasma-manager.homeModules.plasma-manager
    ];
  }
];
    };
  };
}
