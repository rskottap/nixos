{
  description = "Shared system-wide packages with overlays for Nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
    in {
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
    };
}
