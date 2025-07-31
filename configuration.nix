# Legacy configuration.nix for backward compatibility
# This file now imports the modular church machine configuration
# 
# For the new modular structure, use:
# sudo nixos-rebuild switch --flake .#church
#
# This file is kept for compatibility with the old symlink method

{ config, pkgs, ... }:

{
  imports = [
    ./machines/church/default.nix
  ];
}
