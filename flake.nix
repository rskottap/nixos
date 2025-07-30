{
  description = "Shared system-wide packages with overlays for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Directly pull from my home-manager config repo
    ramya-home.url = "https://github.com/rskottap/home-manager.git";
    ramya-home.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs }: 
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
    in {
      # ✅ For non-NixOS use: `nix profile add .` or `nix build .#default`
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = import ./overlay;
          };
          basePackages = import ./base { inherit pkgs; };
        in {
          default = pkgs.buildEnv {
            name = "base-system-packages";
            paths = basePackages.all;
          };
        }
      );

      # ✅ For NixOS use: `sudo nixos-rebuild switch`
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              nixpkgs = {
                overlays = import ./overlay;
                config.allowUnfree = true;
              };

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ramya = import ramya-home + "/home.nix";
              };
            }
          ];
        };
      };

    };
}
