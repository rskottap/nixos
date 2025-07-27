{
  description = "Shared system-wide packages for Nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
    in {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          base   = import ./base.nix   { inherit pkgs; };
          apps   = import ./apps.nix   { inherit pkgs; };
          fonts  = import ./fonts.nix  { inherit pkgs; };
          python = import ./python.nix { inherit pkgs; };
        in {
          default = pkgs.buildEnv {
            name = "full-system-packages";
            paths = base ++ apps ++ fonts ++ python;
          };
        }
      );
    };
}
