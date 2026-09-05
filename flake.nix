{
  description = "Shared system-wide packages with overlays for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Keep Codex fresh independently of the system nixpkgs pin.
    codex-nixpkgs.url = "github:NixOS/nixpkgs/0968519e14f7aa7d3e9b389682bd74d2b51c8ce8";

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

  outputs = { self, nixpkgs, codex-nixpkgs, home-manager, ramya-home, wnix-packages, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      overlay = import ./overlay;

      codexOverlay = final: _prev: {
        codex = codex-nixpkgs.legacyPackages.${final.stdenv.hostPlatform.system}.codex;
      };

      overlays = overlay ++ [ wnix-packages.overlays.default codexOverlay ];

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
