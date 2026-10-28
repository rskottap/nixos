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

    # External Python packages overlay
    wnix-packages = {
      url = "github:doubleunix/overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ramya-home, wnix-packages, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      overlay = import ./overlay;

      pythonCompatibilityOverlay = final: prev: {
        # Keep system/build tooling on the cached upstream interpreter. The
        # external overlay's experimental python314 disables dependency tests
        # and would otherwise force thousands of unrelated packages to rebuild.
        python3 = (import nixpkgs {
          localSystem = prev.stdenv.buildPlatform;
          crossSystem = prev.stdenv.hostPlatform;
        }).python3;
        python3Packages = final.python3.pkgs;
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (_pyfinal: pyprev: {
            # Match pyproject.toml in the overlay's pinned assure source;
            # newer nixpkgs rejects the overlay's placeholder "latest".
            assure = pyprev.assure.overridePythonAttrs {
              version = "0.0.6";
            };
          })
        ];
        python314 = prev.python314.override (old: {
          packageOverrides = nixpkgs.lib.composeExtensions
            (old.packageOverrides or (_: _: {}))
            (pyfinal: _pyprev: {
              # The external overlay's overridePythonAttrs drops .override,
              # which fetchCargoVendor needs to disable mypyc for bootstrapping.
              charset-normalizer = pyfinal.callPackage
                "${nixpkgs}/pkgs/development/python-modules/charset-normalizer" {};
            });
        });
      };

      overlays = overlay ++ [ wnix-packages.overlays.default pythonCompatibilityOverlay ];

      mkPkgs = system: import nixpkgs {
        inherit system;
        inherit overlays;
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
              nixpkgs.overlays = overlays;
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
