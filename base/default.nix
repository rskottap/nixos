{ pkgs }:

let
  base   = import ./base.nix   { inherit pkgs; };
  apps   = import ./apps.nix   { inherit pkgs; };
  fonts  = import ./fonts.nix  { inherit pkgs; };
  python = import ./python.nix { inherit pkgs; };
in {
  # All base packages combined
  all = base ++ apps ++ fonts ++ python;
  
  # Individual categories for flexibility
  inherit base apps fonts python;
}
