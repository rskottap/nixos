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
          };
          basePackages = import ./base { inherit pkgs; };
        in {
          default = pkgs.buildEnv {
            name = "base-system-packages";
            paths = basePackages.all;
          };
          
          # Individual package sets for flexibility
          base = pkgs.buildEnv {
            name = "base-packages";
            paths = basePackages.base;
          };
          apps = pkgs.buildEnv {
            name = "app-packages";
            paths = basePackages.apps;
          };
          fonts = pkgs.buildEnv {
            name = "font-packages";
            paths = basePackages.fonts;
          };
          python = pkgs.buildEnv {
            name = "python-packages";
            paths = basePackages.python;
          };
        }
      );
    };
}
