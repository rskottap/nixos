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

  # Work laptop specific configurations
  # You might want different settings for work environment
  # For example:
  # - Different timezone if traveling
  # - Corporate VPN settings
  # - Work-specific packages
  # - Security policies
  
  # Example work-specific overrides:
  # time.timeZone = "America/New_York";  # If work is in different timezone
  
  # Work-specific packages could be added here
  # environment.systemPackages = with pkgs; [
  #   teams
  #   slack
  #   # other work tools
  # ];
}
