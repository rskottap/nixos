{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/common.nix
    ../../modules/desktop.nix
    ../../modules/users.nix
  ];

  # Machine-specific settings
  networking.hostName = "church";

  # Machine-specific configurations can go here
  # For example, if this machine needs specific services or hardware support

  machine.additionalPackages = with pkgs; [
    kdePackages.kdenlive
  ];
}
