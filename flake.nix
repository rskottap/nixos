{
  description = "Shared system-wide packages with overlays for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Directly pull from my home-manager config repo
    ramya-home = {
      url = "github:rskottap/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ramya-home, ... }: 
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      overlay = import ./overlay;

      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = overlay;
        config.allowUnfree = true;
      };

      # Helper function to create NixOS configurations for machines
      mkMachine = { name, system ? "x86_64-linux" }: 
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/${name}/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                backupFileExtension = "backup";
                users.ramya = ramya-home.nixosModules.default;
              };
            }
          ];
        };

      # Define all machines here
      machines = {
        church = {
          name = "church";
          system = "x86_64-linux";
        };
        curry = {
          name = "curry";
          system = "x86_64-linux";
        };
      };

    in {
      # ✅ For non-NixOS use: `nix profile add .` or `nix build .#default`
      packages = forAllSystems (system:
        let
          pkgs = mkPkgs system;
          basePackages = import ./base { inherit pkgs; };
        in {
          default = pkgs.buildEnv {
            name = "base-system-packages";
            paths = basePackages.all;
          };
        }
      );

      # ✅ For NixOS use: `sudo nixos-rebuild switch --flake .#<machine-name>`
      nixosConfigurations = nixpkgs.lib.mapAttrs (name: config: mkMachine config) machines;

      # Helper to list available machines
      apps = forAllSystems (system: {
        list-machines = {
          type = "app";
          program = toString (nixpkgs.legacyPackages.${system}.writeScript "list-machines" ''
            #!/bin/sh
            echo "Available NixOS configurations:"
            ${nixpkgs.lib.concatStringsSep "\n" (nixpkgs.lib.mapAttrsToList (name: config: "echo '  ${name} (${config.system})'") machines)}
          '');
        };
      });
    };
}
