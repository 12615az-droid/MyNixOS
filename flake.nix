{
  description = "NixOS · Niri / Nix Aurora";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [ agenix.packages.${system}.default ];
          }
        ];
      };

      # Validate the actual Home Manager output with the pinned Niri version.
      checks.${system}.niri-config = pkgs.runCommand "niri-config-check" {
        nativeBuildInputs = [ pkgs.niri ];
      } ''
        export XDG_RUNTIME_DIR="$TMPDIR"
        niri validate --config ${self.nixosConfigurations.nixos.config.home-manager.users.popov.xdg.configFile."niri/config.kdl".source}
        touch $out
      '';
    };
}
