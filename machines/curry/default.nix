{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/common.nix
    ../../modules/desktop.nix
    ../../modules/users.nix
  ];

  # Machine-specific settings
  networking.hostName = "curry";
  
  # Work-specific packages
  machine.additionalPackages = with pkgs; [
    teams-for-linux
    awscli2
    # other work tools
  ];
}
